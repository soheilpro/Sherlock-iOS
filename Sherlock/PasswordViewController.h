//
//  PasswordViewController.h
//  Sherlock
//
//  Created by Soheil Rashidi on 3/30/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import "Database.h"
#import "Storage.h"
#import <UIKit/UIKit.h>

@protocol PasswordDelegate<NSObject>

@required
- (BOOL)didEnterPassword:(NSString*)password inViewController:(UIViewController*)viewController;

@end

@interface PasswordViewController : UITableViewController<UITextFieldDelegate>

@property (nonatomic, strong) Database* database;
@property (nonatomic, weak) id<PasswordDelegate> delegate;

+ (instancetype)instantiate;

@end
