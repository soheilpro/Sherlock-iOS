//
//  FilesViewController.m
//  Sherlock
//
//  Created by Soheil Rashidi on 3/30/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import "DatabasesViewController.h"
#import "MBProgressHUD.h"
#import "Theme.h"
#import "Storage.h"
#import "LocalStorage.h"
#import "DropboxStorage.h"
#import "Database.h"
#import "AppDelegate.h"
#import "Database+Display.h"

@interface DatabasesViewController ()

@property (nonatomic, strong) NSArray* storages;
@property (nonatomic, strong) Database* selectedDatabase;
@property (nonatomic, strong) NSData* selectedDatabaseData;

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

- (BOOL)didEnterPassword:(NSString*)password inViewController:(UIViewController*)viewController;
{
    BOOL didOpenDatabase = [self.selectedDatabase openWithData:self.selectedDatabaseData andPassword:password];
     
    if (!didOpenDatabase)
        return NO;
    
    [((AppDelegate*)[UIApplication sharedApplication].delegate) didOpenDatabase:self.selectedDatabase];
    
    [viewController dismissModalViewControllerAnimated:NO];
    [self dismissModalViewControllerAnimated:YES];
    
    return YES;
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
    cell.textLabel.text = [database displayName];
    
    return cell;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    MBProgressHUD* hud = [self showHUDWithText:@"Loading database"];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
    {
        id<Storage> storage = [self.storages objectAtIndex:indexPath.section];
        Database* database = [[storage databases] objectAtIndex:indexPath.row];

        self.selectedDatabase = database;
        self.selectedDatabaseData = [storage readDatabase:database];
        
        dispatch_async(dispatch_get_main_queue(), ^
        {
            [hud hide:YES];

            BOOL didOpenDatabase = [self.selectedDatabase openWithData:self.selectedDatabaseData andPassword:nil];
            
            if (didOpenDatabase)
            {
                [((AppDelegate*)[UIApplication sharedApplication].delegate) didOpenDatabase:self.selectedDatabase];
                [self dismissModalViewControllerAnimated:YES];
            }
            else
            {
                PasswordViewController* passwordViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Password"];
                passwordViewController.database = database;
                passwordViewController.delegate = self;
            
                [self presentModalViewController:passwordViewController animated:YES];
            }
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
