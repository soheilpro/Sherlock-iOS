//
//  MasterViewController.h
//  Sherlock
//
//  Created by Soheil Rashidi on 3/30/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import "Database.h"
#import "EditFolderViewController.h"
#import "EditItemViewController.h"
#import "NewPasswordViewController.h"
#import <UIKit/UIKit.h>

@interface FolderViewController : UITableViewController<UISearchBarDelegate, EditFolderDelegate, EditItemDelegate, NewPasswordDelegate>

@property (nonatomic) BOOL showCategories;
@property (nonatomic) BOOL showItems;
@property (nonatomic, strong) Folder* folder;

+ (instancetype)instantiate;

@end
