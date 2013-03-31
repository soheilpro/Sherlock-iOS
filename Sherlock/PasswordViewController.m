//
//  PasswordViewController.m
//  Sherlock
//
//  Created by Soheil Rashidi on 3/30/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import "PasswordViewController.h"
#import "Database.h"
#import "AppDelegate.h"

@implementation PasswordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.passwordTextField.delegate = self;
    [self passwordTextFieldDidChange];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(passwordTextFieldDidChange) name:UITextFieldTextDidChangeNotification object:self.passwordTextField];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.passwordTextField becomeFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField
{
    if (textField == self.passwordTextField)
        [self open:textField];
    
    return YES;
}

- (void)passwordTextFieldDidChange
{
    self.navigationItem.rightBarButtonItem.enabled = self.passwordTextField.text.length > 0;
}

- (void)open:(id)sender
{    
    Database* database = [Database openDatabaseFromData:self.fileData withPassword:self.passwordTextField.text];
    
    if (database == nil)
        return;
    
    [((AppDelegate*)[UIApplication sharedApplication].delegate) didOpenDatabase:database];
    
    [self dismissModalViewControllerAnimated:YES];
}

@end
