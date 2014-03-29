//
//  NewPasswordModalViewController.h
//  Sherlock
//
//  Created by Soheil Rashidi on 3/29/14.
//  Copyright (c) 2014 Softtool. All rights reserved.
//

#import "NewPasswordViewController.h"
#import <UIKit/UIKit.h>

@interface NewPasswordModalViewController : UINavigationController

@property (nonatomic, strong) Database* database;
@property (nonatomic, weak) id<NewPasswordDelegate> neuPasswordDelegate;

+ (instancetype)instantiate;

@end
