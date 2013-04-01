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
#import "NewItemViewController.h"

#define SECTION_FOLDERS 0
#define SECTION_ITEMS 1

@interface FolderViewController ()

@property (nonatomic, strong) UIPopoverController* masterPopoverController;
@property (nonatomic, strong) UIBarButtonItem* unloadBarButtonItem;

@end

@implementation FolderViewController

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
    
    [self refresh];
    
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
        [detailMainViewController refresh];
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
        
        [self.navigationItem setLeftBarButtonItem:addButton animated:YES];
    }
    else
    {
        [self.navigationItem setLeftBarButtonItem: originalLeftBarButtonItem animated:YES];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"FolderSegue"])
    {
        Folder* folder = [self.folder.folders objectAtIndex:[self.tableView indexPathForSelectedRow].row];

        FolderViewController* destinationViewController = segue.destinationViewController;
        destinationViewController.folder = folder;
        destinationViewController.showCategories = self.showCategories;
        destinationViewController.showItems = self.showItems;
    }
    else if ([segue.identifier isEqualToString:@"ItemSegue"])
    {
        Item* item = [self.folder.items objectAtIndex:[self.tableView indexPathForSelectedRow].row];
        
        ItemViewController* itemViewController = segue.destinationViewController;
        itemViewController.item = item;
    }
}

- (void)refresh
{
    self.navigationItem.title = self.folder.parent != nil ? self.folder.name : self.folder.database.name;
    
    [self.tableView reloadData];
    [self.tableView setContentOffset:CGPointZero animated:NO];
}

- (void)addFolderOrItem
{
    ActionSheet* actionSheet = [ActionSheet actionSheet];
    
    [actionSheet addButtonWithTitle:@"Folder" selectBlock:^
    {
        EditFolderViewController* editFolderViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NewFolder"];
        editFolderViewController.folder = [[Folder alloc] init];
        editFolderViewController.folder.parent = self.folder;
        editFolderViewController.folder.database = self.folder.database;
        editFolderViewController.delegate = self;
        
        [self presentModalViewController:editFolderViewController animated:YES];
    }];

    [actionSheet addButtonWithTitle:@"Item" selectBlock:^
    {
        NewItemViewController* newItemViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NewItem"];
        newItemViewController.delegate = self;
        
        [self presentModalViewController:newItemViewController animated:YES];
    }];

    [actionSheet addCancelButtonWithTitle:@"Cancel"];
    
    [actionSheet presentInView:self.view];
}

- (void)didUpdateFolder:(Folder*)folder
{
    [self.folder.folders addObject:folder];
    [self.folder.folders sortUsingComparator:[Folder sortingComparator]];
    
    [self.folder.database save];
    
    NSInteger folderIndex = [self.folder.folders indexOfObject:folder];
    
    [self setEditing:NO];
    [self.tableView reloadData];
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:folderIndex inSection:SECTION_FOLDERS] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    
    [self performSegueWithIdentifier:@"FolderSegue" sender:self.tableView];
}

- (void)didCreateNewItem:(Item*)item
{
    item.parent = self.folder;
    item.database = self.folder.database;
    
    [self.folder.items addObject:item];
    [self.folder.items sortUsingComparator:[Item sortingComparator]];
    
    [self.folder.database save];
    
    NSInteger itemIndex = [self.folder.items indexOfObject:item];
    
    [self.tableView reloadData];
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:itemIndex inSection:SECTION_ITEMS] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}

- (void)unloadDatabase
{
    [((AppDelegate*)[UIApplication sharedApplication].delegate) unloadCurrentDatabase];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == SECTION_FOLDERS)
        return self.showCategories ? self.folder.folders.count : 0;

    if (section == SECTION_ITEMS)
        return self.showItems ? self.folder.items.count : 0;
    
    return 0;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath.section == SECTION_FOLDERS)
    {
        Folder* folder = [self.folder.folders objectAtIndex:indexPath.row];
        
        UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"FolderCell"];
        cell.textLabel.text = folder.name;
        
        return cell;
    }

    if (indexPath.section == SECTION_ITEMS)
    {
        Item* item = [self.folder.items objectAtIndex:indexPath.row];
        
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
        [self performSegueWithIdentifier:@"FolderSegue" sender:tableView];
    
    if (indexPath.section == SECTION_ITEMS)
    {
        Item* item = [self.folder.items objectAtIndex:indexPath.row];
        
        ActionSheet* actionSheet = [ActionSheet actionSheet];
        [actionSheet addButtonWithTitle:@"View" selectBlock:^
        {
            [self performSegueWithIdentifier:@"ItemSegue" sender:tableView];
            
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
}

- (void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        if (indexPath.section == SECTION_FOLDERS)
        {
            [self.folder.folders removeObjectAtIndex:indexPath.row];
        }
        else if (indexPath.section == SECTION_ITEMS)
        {
            [self.folder.items removeObjectAtIndex:indexPath.row];
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
