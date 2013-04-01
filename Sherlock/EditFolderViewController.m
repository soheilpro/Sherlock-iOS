//
//  NewFolderViewController.m
//  Sherlock
//
//  Created by Soheil Rashidi on 4/1/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import "EditFolderViewController.h"

@implementation EditFolderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.nameTextField.text = self.folder.name;
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
        [self done:textField];
    
    return YES;
}

- (void)toggleCreateButton
{
    self.doneBarButtonItem.enabled = self.nameTextField.text.length > 0;
}

- (void)done:(id)sender
{
    self.folder.name = self.nameTextField.text;
    
    [self.delegate didUpdateFolder:self.folder];
    
    [self dismissModalViewControllerAnimated:YES];
}

- (void)cancel:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

@end
