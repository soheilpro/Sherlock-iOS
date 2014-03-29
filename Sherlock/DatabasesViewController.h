//
//  FilesViewController.h
//  Sherlock
//
//  Created by Soheil Rashidi on 3/30/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import "NewDatabaseViewController.h"
#import "PasswordViewController.h"
#import <UIKit/UIKit.h>

@interface DatabasesViewController : UITableViewController<PasswordDelegate, NewDatabaseDelegate>

+ (instancetype)instantiate;

@end
