//
//  MasterViewController.m
//  Sherlock
//
//  Created by Soheil Rashidi on 3/30/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import "MainViewController.h"
#import "ItemViewController.h"
#import "ActionSheet.h"

#define SECTION_CATEGORIES 0
#define SECTION_ITEMS 1

@interface MainViewController ()

@property (strong, nonatomic) UIPopoverController* masterPopoverController;

@end

@implementation MainViewController

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
}

- (void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"CategorySegue"])
    {
        CategoryNode* category = [self.rootNode.categories objectAtIndex:[self.tableView indexPathForSelectedRow].row];

        MainViewController* destinationViewController = segue.destinationViewController;
        destinationViewController.rootNode = category;
        destinationViewController.showCategories = self.showCategories;
        destinationViewController.showItems = self.showItems;
    }
    else if ([segue.identifier isEqualToString:@"ItemSegue"])
    {
        ItemNode* item = [self.rootNode.items objectAtIndex:[self.tableView indexPathForSelectedRow].row];
        
        ItemViewController* itemViewController = segue.destinationViewController;
        itemViewController.item = item;
    }
}

- (void)refresh
{
    self.navigationItem.title = self.rootNode.name;
    
    [self.tableView reloadData];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == SECTION_CATEGORIES)
        return self.showCategories ? self.rootNode.categories.count : 0;

    if (section == SECTION_ITEMS)
        return self.showItems ? self.rootNode.items.count : 0;
    
    return 0;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath.section == SECTION_CATEGORIES)
    {
        CategoryNode* category = [self.rootNode.categories objectAtIndex:indexPath.row];
        
        UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"CategoryCell"];
        cell.textLabel.text = category.name;
        
        return cell;
    }

    if (indexPath.section == SECTION_ITEMS)
    {
        ItemNode* item = [self.rootNode.items objectAtIndex:indexPath.row];
        
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
        [self performSegueWithIdentifier:@"CategorySegue" sender:tableView];
    
    if (indexPath.section == SECTION_ITEMS)
    {
        ItemNode* item = [self.rootNode.items objectAtIndex:indexPath.row];
        
        ActionSheet* actionSheet = [ActionSheet actionSheet];
        [actionSheet addButtonWithTitle:@"View" selectBlock:^
        {
            [self performSegueWithIdentifier:@"ItemSegue" sender:tableView];
        }];

        [actionSheet addButtonWithTitle:@"Copy" selectBlock:^
        {
            UIPasteboard* pasteboard = [UIPasteboard generalPasteboard];
            pasteboard.string = item.value;
        }];

        NSURL* url = [NSURL URLWithString:item.value];
        
        if (url != nil && url.scheme != nil)
        {
            [actionSheet addButtonWithTitle:@"Open" selectBlock:^
            {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:item.value]];
            }];
        }
        
        [actionSheet addCancelButtonWithTitle:@"Cancel"];
        [actionSheet presentInView:self.view];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    // If we're in the master view controller, update the detail view controller as well
    if (self.splitViewController != nil && [self.splitViewController.viewControllers objectAtIndex:0] == self.navigationController)
    {
        UINavigationController* detailViewController = [self.splitViewController.viewControllers lastObject];
        MainViewController* detailMainViewController = [detailViewController.viewControllers objectAtIndex:0];
        detailMainViewController.rootNode = self.rootNode;
        [detailMainViewController refresh];
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
