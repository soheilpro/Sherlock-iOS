//
//  MasterViewController.m
//  Sherlock
//
//  Created by Soheil Rashidi on 3/30/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import "AppDelegate.h"
#import "Database+Display.h"
#import "EditFolderModalViewController.h"
#import "EditFolderViewController.h"
#import "EditItemModalViewController.h"
#import "FolderCell.h"
#import "FolderViewController.h"
#import "ItemCell.h"
#import "ItemViewController.h"
#import "NewPasswordModalViewController.h"
#import "SRActionSheet.h"
#import "UIViewController+ActivityIndicator.h"
#import "UIViewController+Alert.h"

#define SECTION_FOLDERS 0
#define SECTION_ITEMS 1

@interface FolderViewController ()

@property (nonatomic, strong) UIPopoverController* masterPopoverController;
@property (nonatomic, strong) UIBarButtonItem* unloadBarButtonItem;
@property (nonatomic, strong) NSMutableArray* folders;
@property (nonatomic, strong) NSMutableArray* items;
@property (nonatomic, weak) IBOutlet UISearchBar* searchBar;

@end

@implementation FolderViewController

#pragma - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (self.folder.parent == nil)
    {
        self.unloadBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Unload" style:UIBarButtonItemStylePlain target:self action:@selector(unloadDatabase:)];
        self.navigationItem.leftBarButtonItem = self.unloadBarButtonItem;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    if (self.navigationItem.leftBarButtonItem == self.unloadBarButtonItem)
        self.navigationItem.leftBarButtonItem.enabled = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    if (self.navigationItem.leftBarButtonItem == self.unloadBarButtonItem)
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void)
        {
            self.navigationItem.leftBarButtonItem.enabled = YES;
        });
    }
}

#pragma mark - UITableViewController

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];

    static NSArray* originalLeftBarButtonItems;

    if (editing)
    {
        originalLeftBarButtonItems = self.navigationItem.leftBarButtonItems;
        UIBarButtonItem* addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addFolderOrItem:)];
        UIBarButtonItem* changePasswordButton = [[UIBarButtonItem alloc] initWithTitle:@"PWD" style:UIBarButtonItemStylePlain target:self action:@selector(changePassword:)];

        [self.navigationItem setLeftBarButtonItems:@[addButton, changePasswordButton] animated:YES];
    }
    else
    {
        [self.navigationItem setLeftBarButtonItems:originalLeftBarButtonItems animated:YES];
    }
}

#pragma mark - Methods

- (void)setFolder:(Folder*)folder
{
    _folder = folder;

    self.folders = self.folder.folders;
    self.items = self.folder.items;

    self.navigationItem.rightBarButtonItem = !self.folder.database.isReadOnly ? self.editButtonItem : nil;
    self.navigationItem.title = self.folder.parent != nil ? self.folder.name : [self.folder.database displayName];

    self.searchBar.text = nil;
    [self.searchBar resignFirstResponder];

    [self.tableView reloadData];
}

#pragma mark - Actions

- (void)addFolderOrItem:(id)sender
{
    SRActionSheet* actionSheet = [SRActionSheet actionSheet];

    [actionSheet addButtonWithTitle:@"Folder" selectBlock:^
    {
        EditFolderModalViewController* editFolderModalViewController = [EditFolderModalViewController instantiate];
        editFolderModalViewController.folder = [[Folder alloc] init];
        editFolderModalViewController.editFolderDelegate = self;

        [self presentViewController:editFolderModalViewController animated:YES completion:nil];
    }];

    [actionSheet addButtonWithTitle:@"Item" selectBlock:^
    {
        EditItemModalViewController* editItemModalViewController = [EditItemModalViewController instantiate];
        editItemModalViewController.item = [[Item alloc] init];
        editItemModalViewController.editItemDelegate = self;

        [self presentViewController:editItemModalViewController animated:YES completion:nil];
    }];

    [actionSheet addCancelButtonWithTitle:@"Cancel"];

    [actionSheet presentInView:self.view];
}

- (void)changePassword:(id)sender
{
    NewPasswordModalViewController* newPasswordViewController = [NewPasswordModalViewController instantiate];
    newPasswordViewController.database = self.folder.database;
    newPasswordViewController.neuPasswordDelegate = self;

    [self presentViewController:newPasswordViewController animated:YES completion:nil];
}

- (void)unloadDatabase:(id)sender
{
    [((AppDelegate*)[UIApplication sharedApplication].delegate) unloadCurrentDatabase];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView*)scrollView
{
    [self.searchBar resignFirstResponder];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == SECTION_FOLDERS)
        return self.showCategories ? self.folders.count : 0;

    if (section == SECTION_ITEMS)
        return self.showItems ? self.items.count : 0;

    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == SECTION_FOLDERS)
        return self.folders.count > 0 ? @"Folders" : nil;

    if (section == SECTION_ITEMS)
        return self.items.count > 0 ? @"Items" : nil;

    return 0;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath.section == SECTION_FOLDERS)
    {
        FolderCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"FolderCell"];
        cell.folder = [self.folders objectAtIndex:indexPath.row];

        return cell;
    }

    if (indexPath.section == SECTION_ITEMS)
    {
        ItemCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"ItemCell"];
        cell.item = [self.items objectAtIndex:indexPath.row];

        return cell;
    }

    return nil;
}

-(BOOL)tableView:(UITableView*)tableView canEditRowAtIndexPath:(NSIndexPath*)indexPath
{
    return !self.folder.database.isReadOnly;
}

- (void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        id activityIndicator = [self displayActivityIndicatorWithMessage:@"Saving database"];

        if (indexPath.section == SECTION_FOLDERS)
        {
            Folder* folder = [self.folders objectAtIndex:indexPath.row];

            [self.folder.folders removeObject:folder];
            [self.folders removeObject:folder];
        }
        else if (indexPath.section == SECTION_ITEMS)
        {
            Item* item = [self.items objectAtIndex:indexPath.row];

            [self.folder.items removeObject:item];
            [self.items removeObject:item];
        }

        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];

        [self.folder.database saveWithCallback:^(NSError* error)
        {
            [self hideActivityIndicator:activityIndicator];

            if (error != nil)
                [self displayErrorMessage:@"Cannot save database"];
        }];
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath.section == SECTION_FOLDERS)
    {
        Folder* folder = [self.folders objectAtIndex:indexPath.row];

        if (!self.tableView.isEditing)
        {
            FolderViewController* folderViewController = [FolderViewController instantiate];
            folderViewController.showCategories = self.showCategories;
            folderViewController.showItems = self.showItems;
            folderViewController.folder = folder;

            [self.navigationController pushViewController:folderViewController animated:YES];
        }
        else
        {
            EditFolderModalViewController* editFolderModalViewController = [EditFolderModalViewController instantiate];
            editFolderModalViewController.folder = folder;
            editFolderModalViewController.editFolderDelegate = self;

            [self presentViewController:editFolderModalViewController animated:YES completion:nil];
        }
    }
    else if (indexPath.section == SECTION_ITEMS)
    {
        if (!self.tableView.isEditing)
        {
            Item* item = [self.items objectAtIndex:indexPath.row];

            SRActionSheet* actionSheet = [SRActionSheet actionSheet];
            [actionSheet addButtonWithTitle:@"View" selectBlock:^
            {
                ItemViewController* itemViewController = [ItemViewController instantiate];
                itemViewController.item = item;

                [self.navigationController pushViewController:itemViewController animated:YES];
            }];

            [actionSheet addButtonWithTitle:@"Copy" selectBlock:^
            {
                UIPasteboard* pasteboard = [UIPasteboard generalPasteboard];
                pasteboard.string = item.value;

                [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
            }];

            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:item.value]])
            {
                [actionSheet addButtonWithTitle:@"Open" selectBlock:^
                {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:item.value]];

                    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
                }];
            }

            [actionSheet addCancelButtonWithTitle:@"Cancel" selectBlock:^
            {
                [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
            }];

            [actionSheet presentInView:self.view];
        }
        else
        {
            Item* item = [self.items objectAtIndex:indexPath.row];

            EditItemModalViewController* editItemModalViewController = [EditItemModalViewController instantiate];
            editItemModalViewController.item = item;
            editItemModalViewController.editItemDelegate = self;

            [self presentViewController:editItemModalViewController animated:YES completion:nil];
        }
    }
}

#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)searchText
{
    [self filterFoldersAndItemsUsingText:searchText];
}

- (void)searchBarSearchButtonClicked:(UISearchBar*)searchBar
{
    [searchBar resignFirstResponder];
}

#pragma mark - EditFolderDelegate

- (void)didUpdateFolder:(Folder*)folder
{
    id activityIndicator = [self displayActivityIndicatorWithMessage:@"Saving database"];

    BOOL isNewFolder = NO;

    if (folder.parent == nil)
    {
        isNewFolder = YES;

        folder.parent = self.folder;
        folder.database = self.folder.database;

        [self.folder.folders addObject:folder];
    }

    [self.folder.folders sortUsingComparator:[Folder sortingComparator]];

    [self.folder.database saveWithCallback:^(NSError* error)
    {
        [self hideActivityIndicator:activityIndicator];

        if (error != nil)
            [self displayErrorMessage:@"Cannot save database"];
    }];

    [self filterFoldersAndItemsUsingText:self.searchBar.text];

    NSInteger folderIndex = [self.folders indexOfObject:folder];

    if (isNewFolder)
        [self setEditing:NO];

    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:folderIndex inSection:SECTION_FOLDERS];

    [self.tableView reloadData];
    [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionMiddle];

    if (isNewFolder)
        [self tableView:self.tableView didSelectRowAtIndexPath:indexPath];
}

#pragma mark - EditItemDelegate

- (void)didUpdateItem:(Item*)item
{
    id activityIndicator = [self displayActivityIndicatorWithMessage:@"Saving database"];

    if (item.parent == nil)
    {
        item.parent = self.folder;
        item.database = self.folder.database;

        [self.folder.items addObject:item];
    }

    [self.folder.items sortUsingComparator:[Item sortingComparator]];

    [self.folder.database saveWithCallback:^(NSError* error)
    {
        [self hideActivityIndicator:activityIndicator];

        if (error != nil)
            [self displayErrorMessage:@"Cannot save database"];
    }];

    [self filterFoldersAndItemsUsingText:self.searchBar.text];

    NSInteger itemIndex = [self.items indexOfObject:item];

    [self.tableView reloadData];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:itemIndex inSection:SECTION_ITEMS] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
}

#pragma mark - NewPasswordDelegate

- (void)didChooseNewPassword:(NSString*)password
{
    id activityIndicator = [self displayActivityIndicatorWithMessage:@"Saving database"];

    self.folder.database.password = password;

    [self.folder.database saveWithCallback:^(NSError* error)
    {
        [self hideActivityIndicator:activityIndicator];

        if (error != nil)
            [self displayErrorMessage:@"Cannot save database"];
    }];

    [self setEditing:NO];
}

#pragma mark -

- (void)filterFoldersAndItemsUsingText:(NSString*)searchText
{
    if (searchText != nil && searchText.length > 0)
    {
        NSPredicate* predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"SELF.name contains[c] '%@'", searchText]];

        self.folders = [[self.folder.folders filteredArrayUsingPredicate:predicate] mutableCopy];
        self.items = [[self.folder.items filteredArrayUsingPredicate:predicate] mutableCopy];
    }
    else
    {
        self.folders = self.folder.folders;
        self.items = self.folder.items;
    }

    [self.tableView reloadData];
}

#pragma mark - Class methods

+ (instancetype)instantiate
{
    return [[AppDelegate sharedDelegate].window.rootViewController.storyboard instantiateViewControllerWithIdentifier:@"Folder"];
}

@end
