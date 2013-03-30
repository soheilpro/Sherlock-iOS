//
//  MasterViewController.h
//  Sherlock
//
//  Created by Soheil Rashidi on 3/30/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Database.h"

@interface MainViewController : UITableViewController <UISplitViewControllerDelegate>

@property (nonatomic, strong) CategoryNode* rootNode;
@property (nonatomic) BOOL showCategories;
@property (nonatomic) BOOL showItems;

- (void)refresh;

@end
