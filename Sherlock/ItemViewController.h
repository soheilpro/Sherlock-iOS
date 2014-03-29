//
//  ItemViewController.h
//  Sherlock
//
//  Created by Soheil Rashidi on 3/30/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import "Database.h"
#import <UIKit/UIKit.h>

@interface ItemViewController : UITableViewController

@property (nonatomic, strong) Item* item;

+ (instancetype)instantiate;

@end
