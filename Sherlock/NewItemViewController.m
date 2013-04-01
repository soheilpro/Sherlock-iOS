//
//  NewItemViewController.m
//  Sherlock
//
//  Created by Soheil Rashidi on 4/2/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import "NewItemViewController.h"

@implementation NewItemViewController

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
        [self.valueTextView becomeFirstResponder];
    
    return YES;
}

- (void)toggleCreateButton
{
    self.createBarButtonItem.enabled = self.nameTextField.text.length > 0;
}

- (void)create:(id)sender
{
    Item* item = [[Item alloc] initWithName:self.nameTextField.text andValue:self.valueTextView.text];
    item.isSecret = [self.isSecretSwitch isOn];
    
    [self.delegate didCreateNewItem:item];
    
    [self dismissModalViewControllerAnimated:YES];
}

- (void)cancel:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

@end
