//
//  AppDelegate.h
//  Sherlock
//
//  Created by Soheil Rashidi on 3/30/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Database.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow* window;

- (void)didOpenDatabase:(Database*)database;

@end
