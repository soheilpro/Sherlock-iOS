//
//  NewPasswordViewController.h
//  Sherlock
//
//  Created by Soheil Rashidi on 4/3/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Database.h"

@protocol NewPasswordDelegate<NSObject>

@required
- (void)didChooseNewPassword:(NSString*)password;

@end

@interface NewPasswordViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic, strong) Database* database;
@property (nonatomic, weak) id<NewPasswordDelegate> delegate;
@property (nonatomic, weak) IBOutlet UITextField* currentPasswordTextField;
@property (nonatomic, weak) IBOutlet UITextField* passwordTextField;
@property (nonatomic, weak) IBOutlet UITextField* passwordConfirmTextField;

- (IBAction)done:(id)sender;
- (IBAction)cancel:(id)sender;

@end
