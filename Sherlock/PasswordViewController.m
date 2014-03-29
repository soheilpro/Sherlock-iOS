//
//  PasswordViewController.m
//  Sherlock
//
//  Created by Soheil Rashidi on 3/30/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import "AppDelegate.h"
#import "PasswordViewController.h"
#import "Database.h"
#import "Database+Display.h"
#import "UIView+Animation.h"

@interface PasswordViewController ()

@property (nonatomic, weak) IBOutlet UITextField* passwordTextField;

@end

@implementation PasswordViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = [self.database displayName];
    self.passwordTextField.delegate = self;
    
    [self toggleOpenButton:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toggleOpenButton:) name:UITextFieldTextDidChangeNotification object:self.passwordTextField];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.passwordTextField becomeFirstResponder];
}

#pragma mark - Actions

- (IBAction)go:(id)sender
{
    BOOL isPasswordCorrect = [self.delegate didEnterPassword:self.passwordTextField.text inViewController:self];

    if (!isPasswordCorrect)
    {
        self.passwordTextField.text = nil;
        [self.passwordTextField shake];
    }
}

#pragma mark - Notifications

- (void)toggleOpenButton:(NSNotification*)notification
{
    self.navigationItem.rightBarButtonItem.enabled = self.passwordTextField.text.length > 0;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField*)textField
{
    if (textField == self.passwordTextField)
        [self go:textField];

    return YES;
}

#pragma mark - Class methods

+ (instancetype)instantiate
{
    return [[AppDelegate sharedDelegate].window.rootViewController.storyboard instantiateViewControllerWithIdentifier:@"Password"];
}

@end
