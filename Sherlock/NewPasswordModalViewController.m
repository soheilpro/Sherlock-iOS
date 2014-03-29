//
//  NewPasswordModalViewController.m
//  Sherlock
//
//  Created by Soheil Rashidi on 3/29/14.
//  Copyright (c) 2014 Softtool. All rights reserved.
//

#import "NewPasswordModalViewController.h"

@implementation NewPasswordModalViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NewPasswordViewController* newPasswordModalViewController = [NewPasswordViewController instantiate];
    newPasswordModalViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    newPasswordModalViewController.database = self.database;
    newPasswordModalViewController.delegate = self.neuPasswordDelegate;

    self.viewControllers = @[newPasswordModalViewController];
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
