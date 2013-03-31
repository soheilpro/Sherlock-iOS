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

#define SECTION_LOCAL 0
#define SECTION_DROPBOX 1

@interface DatabasesViewController ()

@property (nonatomic, strong) NSArray* localFiles;
@property (nonatomic, strong) NSArray* dropboxFiles;

@end

@implementation DatabasesViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.localFiles = [self getListOfLocalFiles];
    self.dropboxFiles = [self getListOfDropboxFiles];
}

- (void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"PasswordSegue"])
    {
        NSIndexPath* indexPath = [self.tableView indexPathForSelectedRow];
        NSData* fileData;
        
        if (indexPath.section == SECTION_LOCAL)
        {
            NSString* file = [self.localFiles objectAtIndex:indexPath.row];
            fileData = [NSData dataWithContentsOfFile:file];
        }
        else if (indexPath.section == SECTION_DROPBOX)
        {
            NSString* file = [self.dropboxFiles objectAtIndex:indexPath.row];
            DBPath* dbPath = [[DBPath alloc] initWithString:file];
            DBFile* dbFile = [[DBFilesystem sharedFilesystem] openFile:dbPath error:nil];
            
            fileData = [dbFile readData:nil];
        }

        PasswordViewController* passwordViewController = segue.destinationViewController;
        passwordViewController.fileData = fileData;
    }
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
    if ([DBFilesystem sharedFilesystem] == nil)
        return [NSArray array];
    
    NSMutableArray* files = [NSMutableArray array];
    
    for (DBFileInfo* file in [[DBFilesystem sharedFilesystem] listFolder:[DBPath root] error:nil])
        [files addObject:[file.path stringValue]];
    
    return files;
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

@end
