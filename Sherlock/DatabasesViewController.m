//
//  FilesViewController.m
//  Sherlock
//
//  Created by Soheil Rashidi on 3/30/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import "DatabasesViewController.h"
#import "PasswordViewController.h"
#import <Dropbox/Dropbox.h>
#import "MBProgressHUD.h"
#import "Theme.h"

#define SECTION_LOCAL 0
#define SECTION_DROPBOX 1

@interface DatabasesViewController ()

@property (nonatomic, strong) NSArray* localDatabaseFiles;
@property (nonatomic, strong) NSArray* dropboxDatabaseFiles;

@end

@implementation DatabasesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[DBAccountManager sharedManager] addObserver:self block:^(DBAccount* account)
    {
        [self refreshFiles];
    }];
    
    self.localDatabaseFiles = @[];
    self.dropboxDatabaseFiles = @[];
    
    [self refreshFiles];
}

- (void)refreshFiles
{
    MBProgressHUD* hud = [self showHUDWithText:@"Loading list of databases"];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
    {
        self.localDatabaseFiles = [self getListOfLocalDatabaseFiles];
        self.dropboxDatabaseFiles = [self getListOfDropboxDatabaseFiles];
        
        dispatch_async(dispatch_get_main_queue(), ^
        {
            [hud hide:YES];
            
            [self.tableView reloadData];
        });
    });
}

- (NSArray*)getListOfLocalDatabaseFiles
{
    NSString* documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSMutableArray* files = [NSMutableArray array];
    
    for (NSString* file in [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentDirectory error:nil])
        [files addObject:[documentDirectory stringByAppendingPathComponent:file]];
    
    return files;
}

- (NSArray*)getListOfDropboxDatabaseFiles
{
    DBAccount* account = [DBAccountManager sharedManager].linkedAccount;
    
    if (account == nil)
        return [NSArray array];
    
    if ([DBFilesystem sharedFilesystem] == nil)
        [DBFilesystem setSharedFilesystem:[[DBFilesystem alloc] initWithAccount:account]];

    NSMutableArray* files = [NSMutableArray array];
    
    for (DBFileInfo* file in [[DBFilesystem sharedFilesystem] listFolder:[DBPath root] error:nil])
        [files addObject:[file.path stringValue]];
    
    return files;
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
    return 2;
}

- (NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == SECTION_LOCAL)
        return self.localDatabaseFiles.count > 0 ? @"Local" : nil;
    
    if (section == SECTION_DROPBOX)
        return self.dropboxDatabaseFiles.count > 0 ? @"Dropbox" : nil;
    
    return nil;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == SECTION_LOCAL)
        return self.localDatabaseFiles.count;
    
    if (section == SECTION_DROPBOX)
        return self.dropboxDatabaseFiles.count;
    
    return 0;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    NSString* file;
    
    if (indexPath.section == SECTION_LOCAL)
    {
        file = [self.localDatabaseFiles objectAtIndex:indexPath.row];
    }
    else if (indexPath.section == SECTION_DROPBOX)
    {
        file = [self.dropboxDatabaseFiles objectAtIndex:indexPath.row];
    }
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"DatabaseCell"];
    cell.textLabel.text = [[file lastPathComponent] stringByDeletingPathExtension];
    
    return cell;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    __block NSString* databaseFile;
    __block NSData* datanaseFileData;
    
    MBProgressHUD* hud = [self showHUDWithText:@"Loading database"];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
    {
        if (indexPath.section == SECTION_LOCAL)
        {
            databaseFile = [self.localDatabaseFiles objectAtIndex:indexPath.row];            
            datanaseFileData = [NSData dataWithContentsOfFile:databaseFile];
        }
        else if (indexPath.section == SECTION_DROPBOX)
        {
            databaseFile = [self.dropboxDatabaseFiles objectAtIndex:indexPath.row];
            
            DBPath* dbPath = [[DBPath alloc] initWithString:databaseFile];
            DBFile* dbFile = [[DBFilesystem sharedFilesystem] openFile:dbPath error:nil];

            datanaseFileData = [dbFile readData:nil];
        }

        dispatch_async(dispatch_get_main_queue(), ^
        {
            [hud hide:YES];

            PasswordViewController* passwordViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Password"];
            passwordViewController.databaseFile = databaseFile;
            passwordViewController.databaseFileData = datanaseFileData;
            
            [self.navigationController pushViewController:passwordViewController animated:YES];
        });
    });
}

@end
