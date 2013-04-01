//
//  MasterViewController.h
//  Sherlock
//
//  Created by Soheil Rashidi on 3/30/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Database.h"
#import "NewFolderViewController.h"

@interface FolderViewController : UITableViewController<UISplitViewControllerDelegate, NewFolderDelegate>

@property (nonatomic, strong) Folder* folder;
@property (nonatomic) BOOL showCategories;
@property (nonatomic) BOOL showItems;

- (void)refresh;

@end
