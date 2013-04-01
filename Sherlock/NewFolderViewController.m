//
//  NewFolderViewController.m
//  Sherlock
//
//  Created by Soheil Rashidi on 4/1/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import "NewFolderViewController.h"

@implementation NewFolderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.nameTextField.delegate = self;
    
    [self toggleCreateButton];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toggleCreateButton) name:UITextFieldTextDidChangeNotification object:self.nameTextField];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self.nameTextField becomeFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField
{
    if (textField == self.nameTextField)
        [self create:textField];
    
    return YES;
}

- (void)toggleCreateButton
{
    self.createBarButtonItem.enabled = self.nameTextField.text.length > 0;
}

- (void)create:(id)sender
{
    Folder* folder = [[Folder alloc] initWithName:self.nameTextField.text];
    
    [self.delegate didCreateNewFolder:folder];
    
    [self dismissModalViewControllerAnimated:YES];
}

- (void)cancel:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

@end
