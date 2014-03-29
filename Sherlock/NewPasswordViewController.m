//
//  NewPasswordViewController.m
//  Sherlock
//
//  Created by Soheil Rashidi on 4/3/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import "AppDelegate.h"
#import "NewPasswordViewController.h"
#import "UIView+Animation.h"

@interface NewPasswordViewController ()

@property (nonatomic, weak) IBOutlet UITextField* currentPasswordTextField;
@property (nonatomic, weak) IBOutlet UITextField* passwordTextField;
@property (nonatomic, weak) IBOutlet UITextField* passwordConfirmTextField;

@end

@implementation NewPasswordViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.currentPasswordTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.passwordConfirmTextField.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.currentPasswordTextField becomeFirstResponder];
}

#pragma mark - Actions

- (IBAction)done:(id)sender
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

#pragma mark - UITextFieldDelegate

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

#pragma mark - Class methods

+ (instancetype)instantiate
{
    return [[AppDelegate sharedDelegate].window.rootViewController.storyboard instantiateViewControllerWithIdentifier:@"NewPassword"];
}

@end
