//
//  NewDatabaseModalViewController.m
//  Sherlock
//
//  Created by Soheil Rashidi on 3/29/14.
//  Copyright (c) 2014 Softtool. All rights reserved.
//

#import "NewDatabaseModalViewController.h"

@implementation NewDatabaseModalViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NewDatabaseViewController* newDatabaseModalViewController = [NewDatabaseViewController instantiate];
    newDatabaseModalViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    newDatabaseModalViewController.storage = self.storage;
    newDatabaseModalViewController.delegate = self.neuDatabaseDelegate;

    self.viewControllers = @[newDatabaseModalViewController];
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
