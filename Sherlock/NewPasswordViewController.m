//
//  NewPasswordViewController.m
//  Sherlock
//
//  Created by Soheil Rashidi on 4/3/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import "NewPasswordViewController.h"
#import "UIView+Animation.h"

@implementation NewPasswordViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.currentPasswordTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.passwordConfirmTextField.delegate = self;

    [self.currentPasswordTextField becomeFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField
{
    if (textField == self.currentPasswordTextField)
        [self.passwordTextField becomeFirstResponder];

    if (textField == self.passwordTextField)
        [self.passwordConfirmTextField becomeFirstResponder];

    if (textField == self.passwordConfirmTextField)
        [self done:textField];
    
    return YES;
}

- (void)done:(id)sender
{
    if (![self.currentPasswordTextField.text isEqualToString:self.database.password ?: @""])
    {
        [self.currentPasswordTextField shake];
        [self.currentPasswordTextField becomeFirstResponder];
        
        return;
    }

    if (![self.passwordConfirmTextField.text isEqualToString:self.passwordTextField.text])
    {
        [self.passwordConfirmTextField shake];
        [self.passwordConfirmTextField becomeFirstResponder];
        
        return;
    }
    
    NSString* password = self.passwordTextField.text;
    
    if (password.length == 0)
        password = nil;
    
    [self.delegate didChooseNewPassword:password];
    
    [self dismissModalViewControllerAnimated:YES];
}

- (void)cancel:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

@end
