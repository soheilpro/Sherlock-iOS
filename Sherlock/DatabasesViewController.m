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
#import "UIViewController+ActivityIndicator.h"
#import "UIViewController+Alert.h"
#import "ActionSheet.h"

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
        [[LocalStorage alloc] initWithRootDirectory:@"Local"],
        [[DropboxStorage alloc] init]
    ];
    
    [self refreshDatabases];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    
    static NSArray* originalLeftBarButtonItems;
    
    if (editing)
    {
        originalLeftBarButtonItems = self.navigationItem.leftBarButtonItems;
        UIBarButtonItem* addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(newDatabase)];
        
        [self.navigationItem setLeftBarButtonItem:addButton animated:YES];
    }
    else
    {
        [self.navigationItem setLeftBarButtonItems:originalLeftBarButtonItems animated:YES];
    }
}

- (void)refreshDatabases
{
    id activityIndicator = [self displayActivityIndicatorWithMessage:@"Loading list of databases"];
    __block NSInteger fetchedStorageDatabases = 0;
    
    for (id<Storage> storage in self.storages)
    {
        [storage fetchDatabasesWithCallback:^(NSArray* databases, NSError* error)
        {
            [self.tableView reloadData];

            fetchedStorageDatabases++;
            
            if (fetchedStorageDatabases == self.storages.count)
                [self hideActivityIndicator:activityIndicator];
        }];
    }
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
    id activityIndicator = [self displayActivityIndicatorWithMessage:@"Creating database"];
    
    [database saveWithCallback:^(NSError* error)
    {
        [self hideActivityIndicator:activityIndicator];
        
        if (error != nil)
            [self displayErrorMessage:@"Cannot create database"];
        else
            [self refreshDatabases];

    }];
    
    [self setEditing:NO];
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
    cell.detailTextLabel.text = database.isReadOnly ? @"readonly" : nil;
    
    return cell;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    id activityIndicator = [self displayActivityIndicatorWithMessage:@"Loading database"];

    id<Storage> storage = [self.storages objectAtIndex:indexPath.section];
    Database* database = [[storage databases] objectAtIndex:indexPath.row];

    [storage readDatabase:database callback:^(NSData* data, NSError* error)
    {
        [self hideActivityIndicator:activityIndicator];
        
        if (error != nil)
        {
            [self displayErrorMessage:@"Cannot load database"];
            return;
        }
        
        self.selectedDatabase = database;
        self.selectedDatabaseData = data;
        
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
    }];
}

- (BOOL)tableView:(UITableView*)tableView canEditRowAtIndexPath:(NSIndexPath*)indexPath
{
    id<Storage> storage = [self.storages objectAtIndex:indexPath.section];
    Database* database = [[storage databases] objectAtIndex:indexPath.row];
    
    return !database.isReadOnly;
}

- (void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        ActionSheet* actionSheet = [ActionSheet actionSheet];

        [actionSheet addDestructiveButtonWithTitle:@"Delete" selectBlock:^
        {
            id<Storage> storage = [self.storages objectAtIndex:indexPath.section];
            Database* database = [[storage databases] objectAtIndex:indexPath.row];
            
            id activityIndicator = [self displayActivityIndicatorWithMessage:@"Deleting database"];
            
            [storage deleteDatabase:database callback:^(NSError* error)
            {
                [self hideActivityIndicator:activityIndicator];
                
                if (error != nil)
                    [self displayErrorMessage:@"Cannot delete database"];
                else
                    [self refreshDatabases];
            }];
        }];
        
        [actionSheet addCancelButtonWithTitle:@"Cancel"];
        
        [actionSheet presentInView:self.view];
    }
}

@end
