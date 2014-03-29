//
//  EditFolderModalViewController.m
//  Sherlock
//
//  Created by Soheil Rashidi on 3/29/14.
//  Copyright (c) 2014 Softtool. All rights reserved.
//

#import "EditFolderModalViewController.h"

@implementation EditFolderModalViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    EditFolderViewController* editFolderModalViewController = [EditFolderViewController instantiate];
    editFolderModalViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    editFolderModalViewController.folder = self.folder;
    editFolderModalViewController.delegate = self.editFolderDelegate;

    self.viewControllers = @[editFolderModalViewController];
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
