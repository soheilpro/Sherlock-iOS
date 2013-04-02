//
//  FilesViewController.m
//  Sherlock
//
//  Created by Soheil Rashidi on 3/30/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import "DatabasesViewController.h"
#import "PasswordViewController.h"
#import "MBProgressHUD.h"
#import "Theme.h"
#import "Storage.h"
#import "LocalStorage.h"
#import "DropboxStorage.h"
#import "Database.h"
#import "NewDatabaseViewController.h"

@interface DatabasesViewController ()

@property (nonatomic, strong) NSArray* storages;

@end

@implementation DatabasesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;

    self.storages = @[
        [[LocalStorage alloc] init],
        [[DropboxStorage alloc] init]
    ];
    
    for (id<Storage> storage in self.storages)
    {
        [storage addObserverBlock:^{
            [self refreshDatabases];
        }];
    }

    [self refreshDatabases];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    
    static UIBarButtonItem* originalLeftBarButtonItem = nil;
    
    if (editing)
    {
        originalLeftBarButtonItem = self.navigationItem.leftBarButtonItem;
        UIBarButtonItem* addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(newDatabase)];
        
        [self.navigationItem setLeftBarButtonItem:addButton animated:YES];
    }
    else
    {
        [self.navigationItem setLeftBarButtonItem: originalLeftBarButtonItem animated:YES];
    }
}

- (void)refreshDatabases
{
    MBProgressHUD* hud = [self showHUDWithText:@"Loading list of databases"];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
    {
        for (id<Storage> storage in self.storages)
            [storage fetchDatabases];
        
        dispatch_async(dispatch_get_main_queue(), ^
        {
            [hud hide:YES];
            
            [self.tableView reloadData];
        });
    });
}

- (void)newDatabase
{
    NSMutableArray* availableStorages = [NSMutableArray array];
    
    for (id<Storage> storage in self.storages)
        if ([storage isAvailable])
            [availableStorages addObject:storage];
    
    NewDatabaseViewController* newDatabaseViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NewDatabase"];
    newDatabaseViewController.storages = availableStorages;
    newDatabaseViewController.delegate = self;

    [self presentModalViewController:newDatabaseViewController animated:YES];
}

- (void)didCreateDatabase:(Database*)database
{
    [database save];
    
    [self setEditing:NO];
}

- (MBProgressHUD*)showHUDWithText:(NSString*)text
{
    MBProgressHUD* hud = [[MBProgressHUD alloc] initWithView:self.view];
    hud.yOffset = -40;
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = text;
    hud.labelFont = [Theme defaultTheme].hudFont;
    hud.removeFromSuperViewOnHide = YES;
    hud.userInteractionEnabled = NO;
    
    [self.view addSubview:hud];
    [hud show:YES];
    
    return hud;
}

- (IBAction)openSettings:(id)sender
{
    UIViewController* settingsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Settings"];

    [self presentModalViewController:settingsViewController animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return self.storages.count;
}

- (NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section
{
    id<Storage> storage = [self.storages objectAtIndex:section];
    
    return [storage databases].count > 0 ? [storage name] : nil;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    id<Storage> storage = [self.storages objectAtIndex:section];
    
    return [storage databases].count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    id<Storage> storage = [self.storages objectAtIndex:indexPath.section];
    Database* database = [[storage databases] objectAtIndex:indexPath.row];
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"DatabaseCell"];
    cell.textLabel.text = database.name;
    
    return cell;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    __block NSData* datanaseFileData;
    
    MBProgressHUD* hud = [self showHUDWithText:@"Loading database"];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
    {
        id<Storage> storage = [self.storages objectAtIndex:indexPath.section];
        Database* database = [[storage databases] objectAtIndex:indexPath.row];

        datanaseFileData = [storage readDatabase:database];
        
        dispatch_async(dispatch_get_main_queue(), ^
        {
            [hud hide:YES];

            PasswordViewController* passwordViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Password"];
            passwordViewController.storage = storage;
            passwordViewController.databaseFile = database.name;
            passwordViewController.databaseFileData = datanaseFileData;
            
            [self.navigationController pushViewController:passwordViewController animated:YES];
        });
    });
}

- (void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        id<Storage> storage = [self.storages objectAtIndex:indexPath.section];
        Database* database = [[storage databases] objectAtIndex:indexPath.row];
        
        [storage deleteDatabase:database];
    }
}

@end
