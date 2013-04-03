//
//  MasterViewController.m
//  Sherlock
//
//  Created by Soheil Rashidi on 3/30/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import "FolderViewController.h"
#import "ItemViewController.h"
#import "ActionSheet.h"
#import "AppDelegate.h"
#import "EditFolderViewController.h"
#import "EditItemViewController.h"
#import "Database+Display.h"
#import "NewPasswordViewController.h"

#define SECTION_FOLDERS 0
#define SECTION_ITEMS 1

@interface FolderViewController ()

@property (nonatomic, strong) UIPopoverController* masterPopoverController;
@property (nonatomic, strong) UIBarButtonItem* unloadBarButtonItem;
@property (nonatomic, strong) NSMutableArray* folders;
@property (nonatomic, strong) NSMutableArray* items;

@end

@implementation FolderViewController

- (void)setFolder:(Folder*)folder
{
    _folder = folder;
    
    self.folders = self.folder.folders;
    self.items = self.folder.items;
    
    self.navigationItem.title = self.folder.parent != nil ? self.folder.name : [self.folder.database displayName];
    
    self.searchBar.text = nil;
    [self.searchBar resignFirstResponder];
    
    [self.tableView reloadData];
    [self.tableView setContentOffset:CGPointZero animated:NO];
}

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    }
    
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    if (self.folder.parent == nil)
    {
        self.unloadBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Unload" style:UIBarButtonItemStylePlain target:self action:@selector(unloadDatabase)];
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

    // If we're in the master view controller, update the detail view controller as well
    if (self.splitViewController != nil && [self.splitViewController.viewControllers objectAtIndex:0] == self.navigationController)
    {
        UINavigationController* detailViewController = [self.splitViewController.viewControllers lastObject];
        FolderViewController* detailMainViewController = [detailViewController.viewControllers objectAtIndex:0];
        detailMainViewController.folder = self.folder;
    }
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];

    static UIBarButtonItem* originalLeftBarButtonItem = nil;
    
    if (editing)
    {
        originalLeftBarButtonItem = self.navigationItem.leftBarButtonItem;
        UIBarButtonItem* addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addFolderOrItem)];
        UIBarButtonItem* changePasswordButton = [[UIBarButtonItem alloc] initWithTitle:@"Password" style:UIBarButtonItemStylePlain target:self action:@selector(changePassword)];
        
        [self.navigationItem setLeftBarButtonItems:@[addButton, changePasswordButton] animated:YES];
    }
    else
    {
        [self.navigationItem setLeftBarButtonItems: @[originalLeftBarButtonItem] animated:YES];
    }
}

- (void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)searchText
{
    [self filterFoldersAndItemsUsingText:searchText];
}

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

- (void)searchBarSearchButtonClicked:(UISearchBar*)searchBar
{
    [searchBar resignFirstResponder];
}

- (void)addFolderOrItem
{
    ActionSheet* actionSheet = [ActionSheet actionSheet];
    
    [actionSheet addButtonWithTitle:@"Folder" selectBlock:^
    {
        EditFolderViewController* editFolderViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"EditFolder"];
        editFolderViewController.folder = [[Folder alloc] init];
        editFolderViewController.delegate = self;
        
        [self presentModalViewController:editFolderViewController animated:YES];
    }];

    [actionSheet addButtonWithTitle:@"Item" selectBlock:^
    {
        EditItemViewController* newItemViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"EditItem"];
        newItemViewController.item = [[Item alloc] init];
        newItemViewController.delegate = self;
        
        [self presentModalViewController:newItemViewController animated:YES];
    }];

    [actionSheet addCancelButtonWithTitle:@"Cancel"];
    
    [actionSheet presentInView:self.view];
}

- (void)changePassword
{
    NewPasswordViewController* newPasswordViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NewPassword"];
    newPasswordViewController.database = self.folder.database;
    newPasswordViewController.delegate = self;
    
    [self presentModalViewController:newPasswordViewController animated:YES];
}

- (void)didUpdateFolder:(Folder*)folder
{
    BOOL isNewFolder = NO;
    
    if (folder.parent == nil)
    {
        isNewFolder = YES;
        
        folder.parent = self.folder;
        folder.database = self.folder.database;

        [self.folder.folders addObject:folder];
    }
    
    [self.folder.folders sortUsingComparator:[Folder sortingComparator]];   
    [self.folder.database save];
    
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

- (void)didUpdateItem:(Item*)item
{
    if (item.parent == nil)
    {
        item.parent = self.folder;
        item.database = self.folder.database;

        [self.folder.items addObject:item];
    }
    
    [self.folder.items sortUsingComparator:[Item sortingComparator]];
    [self.folder.database save];

    [self filterFoldersAndItemsUsingText:self.searchBar.text];

    NSInteger itemIndex = [self.items indexOfObject:item];
    
    [self.tableView reloadData];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:itemIndex inSection:SECTION_ITEMS] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
}

- (void)didChooseNewPassword:(NSString*)password
{
    self.folder.database.password = password;
    
    [self.folder.database save];
    
    [self setEditing:NO];
}

- (void)unloadDatabase
{
    [((AppDelegate*)[UIApplication sharedApplication].delegate) unloadCurrentDatabase];
}

- (void)scrollViewWillBeginDragging:(UIScrollView*)scrollView
{
    [self.searchBar resignFirstResponder];
}

#pragma mark - Table View

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

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath.section == SECTION_FOLDERS)
    {
        Folder* folder = [self.folders objectAtIndex:indexPath.row];
        
        UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"FolderCell"];
        cell.textLabel.text = folder.name;
        
        return cell;
    }

    if (indexPath.section == SECTION_ITEMS)
    {
        Item* item = [self.items objectAtIndex:indexPath.row];
        
        UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"ItemCell"];
        cell.textLabel.text = item.name;
        cell.detailTextLabel.text = !item.isSecret ? item.value : [@"" stringByPaddingToLength:item.value.length withString:@"\u2022" startingAtIndex:0];
        
        return cell;
    }
    
    return nil;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath.section == SECTION_FOLDERS)
    {
        Folder* folder = [self.folders objectAtIndex:indexPath.row];

        if (!self.tableView.isEditing)
        {
            FolderViewController* folderViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Folder"];
            folderViewController.showCategories = self.showCategories;
            folderViewController.showItems = self.showItems;
            folderViewController.folder = folder;
            
            [self.navigationController pushViewController:folderViewController animated:YES];
        }
        else
        {
            EditFolderViewController* editFolderViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"EditFolder"];
            editFolderViewController.folder = folder;
            editFolderViewController.delegate = self;
            
            [self presentModalViewController:editFolderViewController animated:YES];
        }
    }
    else if (indexPath.section == SECTION_ITEMS)
    {
        if (!self.tableView.isEditing)
        {
            Item* item = [self.items objectAtIndex:indexPath.row];
            
            ActionSheet* actionSheet = [ActionSheet actionSheet];
            [actionSheet addButtonWithTitle:@"View" selectBlock:^
            {
                ItemViewController* itemViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Item"];
                itemViewController.item = item;
                
                [self presentModalViewController:itemViewController animated:YES];
                
                [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
            }];

            [actionSheet addButtonWithTitle:@"Copy" selectBlock:^
            {
                UIPasteboard* pasteboard = [UIPasteboard generalPasteboard];
                pasteboard.string = item.value;
                
                [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
            }];

            NSURL* url = [NSURL URLWithString:item.value];
            
            if (url != nil && url.scheme != nil)
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
            
            EditItemViewController* editItemViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"EditItem"];
            editItemViewController.item = item;
            editItemViewController.delegate = self;
            
            [self presentModalViewController:editItemViewController animated:YES];
        }
    }
}

- (void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
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
        
        [self.folder.database save];
    }
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController*)splitController willHideViewController:(UIViewController*)viewController withBarButtonItem:(UIBarButtonItem*)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController*)splitController willShowViewController:(UIViewController*)viewController invalidatingBarButtonItem:(UIBarButtonItem*)barButtonItem
{
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
