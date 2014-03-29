//
//  NewDatabaseModalViewController.h
//  Sherlock
//
//  Created by Soheil Rashidi on 3/29/14.
//  Copyright (c) 2014 Softtool. All rights reserved.
//

#import "NewDatabaseViewController.h"
#import <UIKit/UIKit.h>

@interface NewDatabaseModalViewController : UINavigationController

@property (nonatomic, strong) id<Storage> storage;
@property (nonatomic, weak) id<NewDatabaseDelegate> neuDatabaseDelegate;

+ (instancetype)instantiate;

@end
