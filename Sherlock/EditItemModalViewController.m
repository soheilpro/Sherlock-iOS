//
//  EditItemModalViewController.m
//  Sherlock
//
//  Created by Soheil Rashidi on 3/29/14.
//  Copyright (c) 2014 Softtool. All rights reserved.
//

#import "EditItemModalViewController.h"

@implementation EditItemModalViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    EditItemViewController* editItemModalViewController = [EditItemViewController instantiate];
    editItemModalViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    editItemModalViewController.item = self.item;
    editItemModalViewController.delegate = self.editItemDelegate;

    self.viewControllers = @[editItemModalViewController];
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
