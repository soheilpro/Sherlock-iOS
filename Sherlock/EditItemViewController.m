//
//  NewItemViewController.m
//  Sherlock
//
//  Created by Soheil Rashidi on 4/2/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import "EditItemViewController.h"

@implementation EditItemViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.nameTextField.text = self.item.name;
    self.nameTextField.delegate = self;
    self.valueTextView.text = self.item.value;
    [self.isSecretSwitch setOn:self.item.isSecret];

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
        [self.valueTextView becomeFirstResponder];
    
    return YES;
}

- (void)toggleCreateButton
{
    self.doneBarButtonItem.enabled = self.nameTextField.text.length > 0;
}

- (void)done:(id)sender
{
    self.item.name = self.nameTextField.text;
    self.item.value = self.valueTextView.text;
    self.item.isSecret = [self.isSecretSwitch isOn];
    
    [self.delegate didUpdateItem:self.item];
    
    [self dismissModalViewControllerAnimated:YES];
}

- (void)cancel:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

@end
