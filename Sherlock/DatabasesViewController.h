//
//  FilesViewController.h
//  Sherlock
//
//  Created by Soheil Rashidi on 3/30/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewDatabaseViewController.h"

@interface DatabasesViewController : UITableViewController<NewDatabaseDelegate>

- (IBAction)openSettings:(id)sender;

@end
