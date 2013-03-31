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

#define SECTION_CATEGORIES 0
#define SECTION_ITEMS 1

@interface FolderViewController ()

@property (strong, nonatomic) UIPopoverController* masterPopoverController;

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
    
    if (self.folder.parent == nil)
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Unload" style:UIBarButtonItemStylePlain target:self action:@selector(unloadDatabase)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.folder.parent == nil)
        self.navigationItem.leftBarButtonItem.enabled = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.folder.parent == nil)
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
    if (section == SECTION_CATEGORIES)
        return self.showCategories ? self.folder.folders.count : 0;

    if (section == SECTION_ITEMS)
        return self.showItems ? self.folder.items.count : 0;
    
    return 0;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath.section == SECTION_CATEGORIES)
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
    if (indexPath.section == SECTION_CATEGORIES)
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
