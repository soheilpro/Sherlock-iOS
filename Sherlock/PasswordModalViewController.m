//
//  PasswordModalViewController.m
//  Sherlock
//
//  Created by Soheil Rashidi on 3/29/14.
//  Copyright (c) 2014 Softtool. All rights reserved.
//

#import "PasswordModalViewController.h"

@implementation PasswordModalViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    PasswordViewController* passwordModalViewController = [PasswordViewController instantiate];
    passwordModalViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    passwordModalViewController.database = self.database;
    passwordModalViewController.delegate = self.passwordDelegate;

    self.viewControllers = @[passwordModalViewController];
}

#pragma mark - Actions

- (void)cancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Class methods

+ (instancetype)instantiate
{
    return [[self alloc] init];
}

@end
