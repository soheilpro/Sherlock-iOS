//
//  ItemViewController.m
//  Sherlock
//
//  Created by Soheil Rashidi on 3/30/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import "AppDelegate.h"
#import "ItemViewController.h"

#define SECTION_NAME 0
#define SECTION_VALUE 1

@interface ItemViewController ()

@property (nonatomic, weak) IBOutlet UILabel* nameLabel;
@property (nonatomic, weak) IBOutlet UILabel* valueLabel;

@end

@implementation ItemViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.nameLabel.text = self.item.name;
    self.valueLabel.text = self.item.value;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath.section == SECTION_NAME)
        return 44.0f - 23.0f + ceil([self.item.name sizeWithFont:[UIFont boldSystemFontOfSize:16] constrainedToSize:CGSizeMake(280.0f, MAXFLOAT)].height);

    if (indexPath.section == SECTION_VALUE)
        return 44.0f - 23.0f + ceil([self.item.value sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(280.0f, MAXFLOAT)].height);

    return tableView.rowHeight;
}

#pragma mark - Class methods

+ (instancetype)instantiate
{
    return [[AppDelegate sharedDelegate].window.rootViewController.storyboard instantiateViewControllerWithIdentifier:@"Item"];
}

@end
