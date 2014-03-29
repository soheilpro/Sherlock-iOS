//
//  EditItemModalViewController.h
//  Sherlock
//
//  Created by Soheil Rashidi on 3/29/14.
//  Copyright (c) 2014 Softtool. All rights reserved.
//

#import "Database.h"
#import "EditItemViewController.h"
#import <UIKit/UIKit.h>

@interface EditItemModalViewController : UINavigationController

@property (nonatomic, strong) Item* item;
@property (nonatomic, weak) id<EditItemDelegate> editItemDelegate;

+ (instancetype)instantiate;

@end
