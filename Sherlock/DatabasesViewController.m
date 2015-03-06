//
//  FilesViewController.m
//  Sherlock
//
//  Created by Soheil Rashidi on 3/30/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import "AppDelegate.h"
#import "Database.h"
#import "DatabaseCell.h"
#import "DatabasesViewController.h"
#import "DropboxStorage.h"
#import "GoogleDriveStorage.h"
#import "LocalStorage.h"
#import "MBProgressHUD.h"
#import "NewDatabaseModalViewController.h"
#import "PasswordModalViewController.h"
#import "SRActionSheet.h"
#import "SettingsModalViewController.h"
#import "UIViewController+ActivityIndicator.h"
#import "UIViewController+Alert.h"

@interface DatabasesViewController ()

@property (nonatomic, strong) NSArray* storages;
@property (nonatomic, strong) Database* selectedDatabase;
@property (nonatomic, strong) NSData* selectedDatabaseData;
@property (nonatomic, strong) NSMutableArray* storageLoadingState;

@end

@implementation DatabasesViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.rightBarButtonItem = self.editButtonItem;

    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshDatabases) forControlEvents:UIControlEventValueChanged];

    self.storages = @[
        [[LocalStorage alloc] initWithRootDirectory:@"Local"],
        [[DropboxStorage alloc] init],
        [[GoogleDriveStorage alloc] init]
    ];

    self.storageLoadingState = [NSMutableArray arrayWithCapacity:self.storages];
    [self.storages enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
    {
        self.storageLoadingState[idx] = @(NO);
    }];

    [self refreshDatabases];
}

#pragma mark - UITableViewController

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];

    static NSArray* originalLeftBarButtonItems;

    if (editing)
    {
        originalLeftBarButtonItems = self.navigationItem.leftBarButtonItems;
        UIBarButtonItem* addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(newDatabase:)];

        [self.navigationItem setLeftBarButtonItem:addButton animated:YES];
    }
    else
    {
        [self.navigationItem setLeftBarButtonItems:originalLeftBarButtonItems animated:YES];
    }
}

#pragma mark - Actions

- (IBAction)openSettings:(id)sender
{
    SettingsModalViewController* settingsModalViewController = [SettingsModalViewController instantiate];

    [self presentViewController:settingsModalViewController animated:YES completion:nil];
}

- (void)newDatabase:(id)sender
{
    SRActionSheet* actionSheet = [SRActionSheet actionSheet];

    for (id<Storage> storage in self.storages)
    {
        if (![storage isAvailable])
            continue;

        [actionSheet addButtonWithTitle:storage.name selectBlock:^
        {
            NewDatabaseModalViewController* newDatabaseModalViewController = [NewDatabaseModalViewController instantiate];
            newDatabaseModalViewController.storage = storage;
            newDatabaseModalViewController.neuDatabaseDelegate = self;

            [self presentViewController:newDatabaseModalViewController animated:YES completion:nil];
        }];
    }

    [actionSheet addCancelButtonWithTitle:@"Cancel"];

    [actionSheet presentInView:self.view];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return self.storages.count;
}

- (NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section
{
    id<Storage> storage = self.storages[section];

    return [storage name];
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    id<Storage> storage = self.storages[section];
    BOOL isStorageLoaded = [self.storageLoadingState[section] boolValue];

    return !isStorageLoaded ? 1 : [storage databases].count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    id<Storage> storage = self.storages[indexPath.section];
    BOOL isStorageLoaded = [self.storageLoadingState[indexPath.section] boolValue];

    if (!isStorageLoaded)
        return [tableView dequeueReusableCellWithIdentifier:@"LoadingCell"];

    Database* database = [storage databases][indexPath.row];

    DatabaseCell* cell = [tableView dequeueReusableCellWithIdentifier:@"DatabaseCell"];
    cell.database = database;

    return cell;
}

- (BOOL)tableView:(UITableView*)tableView canEditRowAtIndexPath:(NSIndexPath*)indexPath
{
    id<Storage> storage = (self.storages)[indexPath.section];
    BOOL isStorageLoaded = [self.storageLoadingState[indexPath.section] boolValue];

    if (!isStorageLoaded)
        return NO;

    Database* database = [storage databases][indexPath.row];

    return !database.isReadOnly;
}

- (void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        SRActionSheet* actionSheet = [SRActionSheet actionSheet];

        [actionSheet addDestructiveButtonWithTitle:@"Delete" selectBlock:^
        {
            id<Storage> storage = self.storages[indexPath.section];
            Database* database = [storage databases][indexPath.row];

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

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    id activityIndicator = [self displayActivityIndicatorWithMessage:@"Loading database"];

    id<Storage> storage = self.storages[indexPath.section];
    Database* database = [storage databases][indexPath.row];

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
            PasswordModalViewController* passwordModalViewController = [PasswordModalViewController instantiate];
            passwordModalViewController.database = database;
            passwordModalViewController.passwordDelegate = self;

            [self presentViewController:passwordModalViewController animated:YES completion:nil];
        }
    }];
}


#pragma mark - PasswordDelegate

- (BOOL)didEnterPassword:(NSString*)password inViewController:(UIViewController*)viewController;
{
    BOOL didOpenDatabase = [self.selectedDatabase openWithData:self.selectedDatabaseData andPassword:password];

    if (!didOpenDatabase)
        return NO;

    [((AppDelegate*)[UIApplication sharedApplication].delegate) didOpenDatabase:self.selectedDatabase];

    [viewController dismissViewControllerAnimated:NO completion:^{
        [self dismissViewControllerAnimated:YES completion:nil];
    }];

    return YES;
}

#pragma mark - NewDatabaseDelegate

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

#pragma mark -

- (void)refreshDatabases
{
    __block NSInteger fetchedStorageDatabases = 0;

    for (id<Storage> storage in self.storages)
    {
        [storage fetchDatabasesWithCallback:^(NSArray* databases, NSError* error)
        {
            self.storageLoadingState[[self.storages indexOfObject:storage]] = @(YES);
            fetchedStorageDatabases++;

            if (fetchedStorageDatabases == self.storages.count)
            {
                [self.refreshControl endRefreshing];
            }

            [self.tableView reloadData];
        }];
    }
}

#pragma mark - Class methods

+ (instancetype)instantiate
{
    return [[AppDelegate sharedDelegate].window.rootViewController.storyboard instantiateViewControllerWithIdentifier:@"Databases"];
}

@end
