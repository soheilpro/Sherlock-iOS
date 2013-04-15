//
//  FilesViewController.h
//  Sherlock
//
//  Created by Soheil Rashidi on 3/30/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PasswordViewController.h"
#import "NewDatabaseViewController.h"
#import "PullRefreshTableViewController.h"

@interface DatabasesViewController : PullRefreshTableViewController<PasswordDelegate, NewDatabaseDelegate>

- (IBAction)openSettings:(id)sender;

@end
