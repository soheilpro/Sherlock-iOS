//
//  NewPasswordViewController.h
//  Sherlock
//
//  Created by Soheil Rashidi on 4/3/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import "Database.h"
#import <UIKit/UIKit.h>

@protocol NewPasswordDelegate<NSObject>

@required
- (void)didChooseNewPassword:(NSString*)password;

@end

@interface NewPasswordViewController : UITableViewController<UITextFieldDelegate>

@property (nonatomic, strong) Database* database;
@property (nonatomic, weak) id<NewPasswordDelegate> delegate;

+ (instancetype)instantiate;

@end
