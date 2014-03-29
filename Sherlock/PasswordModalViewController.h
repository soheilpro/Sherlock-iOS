//
//  PasswordModalViewController.h
//  Sherlock
//
//  Created by Soheil Rashidi on 3/29/14.
//  Copyright (c) 2014 Softtool. All rights reserved.
//

#import "PasswordViewController.h"
#import <UIKit/UIKit.h>

@interface PasswordModalViewController : UINavigationController

@property (nonatomic, strong) Database* database;
@property (nonatomic, weak) id<PasswordDelegate> passwordDelegate;

+ (instancetype)instantiate;

@end
