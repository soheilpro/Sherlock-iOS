//
//  AppDelegate.h
//  Sherlock
//
//  Created by Soheil Rashidi on 3/30/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import "Database.h"
#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow* window;

- (void)unloadCurrentDatabase;
- (void)didOpenDatabase:(Database*)database;

+ (instancetype)sharedDelegate;

@end
