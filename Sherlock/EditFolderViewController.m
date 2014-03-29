//
//  NewFolderViewController.m
//  Sherlock
//
//  Created by Soheil Rashidi on 4/1/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import "AppDelegate.h"
#import "EditFolderViewController.h"

@interface EditFolderViewController ()

@property (nonatomic, weak) IBOutlet UIBarButtonItem* doneBarButtonItem;
@property (nonatomic, weak) IBOutlet UITextField* nameTextField;

@end

@implementation EditFolderViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.nameTextField.text = self.folder.name;
    self.nameTextField.delegate = self;
    
    [self toggleCreateButton:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toggleCreateButton:) name:UITextFieldTextDidChangeNotification object:self.nameTextField];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.nameTextField becomeFirstResponder];
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    self.folder.name = self.nameTextField.text;

    [self.delegate didUpdateFolder:self.folder];

    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - Notifications

- (void)toggleCreateButton:(NSNotification*)notification
{
    self.doneBarButtonItem.enabled = self.nameTextField.text.length > 0;
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField*)textField
{
    if (textField == self.nameTextField)
        [self done:textField];
    
    return YES;
}

#pragma mark - Class methods

+ (instancetype)instantiate
{
    return [[AppDelegate sharedDelegate].window.rootViewController.storyboard instantiateViewControllerWithIdentifier:@"EditFolder"];
}

@end
