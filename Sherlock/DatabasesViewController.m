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

@property (nonatomic, strong) NSArray* localFiles;
@property (nonatomic, strong) NSArray* dropboxFiles;

@end

@implementation DatabasesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[DBAccountManager sharedManager] addObserver:self block:^(DBAccount* account)
    {
        [self refreshFiles];
    }];
    
    self.localFiles = @[];
    self.dropboxFiles = @[];
    
    [self refreshFiles];
}

- (void)refreshFiles
{
    MBProgressHUD* hud = [self showHUDWithText:@"Loading list of databases"];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
    {
        self.localFiles = [self getListOfLocalFiles];
        self.dropboxFiles = [self getListOfDropboxFiles];
        
        dispatch_async(dispatch_get_main_queue(), ^
        {
            [hud hide:YES];
            
            [self.tableView reloadData];
        });
    });
}

- (NSArray*)getListOfLocalFiles
{
    NSString* documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSMutableArray* files = [NSMutableArray array];
    
    for (NSString* file in [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentDirectory error:nil])
        [files addObject:[documentDirectory stringByAppendingPathComponent:file]];
    
    return files;
}

- (NSArray*)getListOfDropboxFiles
{
    if ([DBAccountManager sharedManager].linkedAccount == nil)
        return [NSArray array];
    
    DBFilesystem* dbFilesystem = [[DBFilesystem alloc] initWithAccount:[DBAccountManager sharedManager].linkedAccount];

    NSMutableArray* files = [NSMutableArray array];
    
    for (DBFileInfo* file in [dbFilesystem listFolder:[DBPath root] error:nil])
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
        return self.localFiles.count > 0 ? @"Local" : nil;
    
    if (section == SECTION_DROPBOX)
        return self.dropboxFiles.count > 0 ? @"Dropbox" : nil;
    
    return nil;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == SECTION_LOCAL)
        return self.localFiles.count;
    
    if (section == SECTION_DROPBOX)
        return self.dropboxFiles.count;
    
    return 0;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    NSString* file;
    
    if (indexPath.section == SECTION_LOCAL)
    {
        file = [self.localFiles objectAtIndex:indexPath.row];
    }
    else if (indexPath.section == SECTION_DROPBOX)
    {
        file = [self.dropboxFiles objectAtIndex:indexPath.row];
    }
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"FileCell"];
    cell.textLabel.text = [[file lastPathComponent] stringByDeletingPathExtension];
    
    return cell;
}


- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    __block NSData* fileData;
    
    MBProgressHUD* hud = [self showHUDWithText:@"Loading database"];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
    {
        if (indexPath.section == SECTION_LOCAL)
        {
            NSString* file = [self.localFiles objectAtIndex:indexPath.row];
            fileData = [NSData dataWithContentsOfFile:file];
        }
        else if (indexPath.section == SECTION_DROPBOX)
        {
            NSString* file = [self.dropboxFiles objectAtIndex:indexPath.row];
            DBPath* dbPath = [[DBPath alloc] initWithString:file];
            DBFilesystem* dbFilesystem = [[DBFilesystem alloc] initWithAccount:[DBAccountManager sharedManager].linkedAccount];
            DBFile* dbFile = [dbFilesystem openFile:dbPath error:nil];

            fileData = [dbFile readData:nil];
        }

        dispatch_async(dispatch_get_main_queue(), ^
        {
            [hud hide:YES];

            PasswordViewController* passwordViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Password"];
            passwordViewController.fileData = fileData;
            
            [self.navigationController pushViewController:passwordViewController animated:YES];
        });
    });
}

@end
