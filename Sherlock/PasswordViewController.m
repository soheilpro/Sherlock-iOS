//
//  PasswordViewController.m
//  Sherlock
//
//  Created by Soheil Rashidi on 3/30/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import "PasswordViewController.h"
#import "Database.h"
#import "Database+Display.h"
#import "UIView+Animation.h"

@implementation PasswordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem2.title = [self.database displayName];
    self.passwordTextField.delegate = self;
    
    [self toggleOpenButton];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toggleOpenButton) name:UITextFieldTextDidChangeNotification object:self.passwordTextField];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.passwordTextField becomeFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField
{
    if (textField == self.passwordTextField)
        [self go:textField];
    
    return YES;
}

- (void)toggleOpenButton
{
    self.navigationItem.rightBarButtonItem.enabled = self.passwordTextField.text.length > 0;
}

- (void)go:(id)sender
{
    BOOL isPasswordCorrect = [self.delegate didEnterPassword:self.passwordTextField.text inViewController:self];

    if (!isPasswordCorrect)
        [self.passwordTextField shake];
}

- (void)cancel:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

@end
