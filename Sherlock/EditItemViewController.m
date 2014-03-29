//
//  NewItemViewController.m
//  Sherlock
//
//  Created by Soheil Rashidi on 4/2/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import "AppDelegate.h"
#import "EditItemViewController.h"

#define ROW_VALUE 1

@interface EditItemViewController ()

@property (nonatomic, weak) IBOutlet UIBarButtonItem* doneBarButtonItem;
@property (nonatomic, weak) IBOutlet UITextField* nameTextField;
@property (nonatomic, weak) IBOutlet UITextView* valueTextView;
@property (nonatomic, weak) IBOutlet UISwitch* isSecretSwitch;

@end

@implementation EditItemViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.nameTextField.text = self.item.name;
    self.nameTextField.delegate = self;
    self.valueTextView.text = self.item.value;
    self.valueTextView.delegate = self;
    [self.isSecretSwitch setOn:self.item.isSecret];

    // Make sure valueTextView.contentSize is properly set
    [self.valueTextView sizeThatFits:self.valueTextView.frame.size];
    [self.valueTextView layoutIfNeeded];

    [self toggleCreateButton:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toggleCreateButton:) name:UITextFieldTextDidChangeNotification object:self.nameTextField];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    if (self.nameTextField.text.length == 0)
        [self.nameTextField becomeFirstResponder];
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    self.item.name = self.nameTextField.text;
    self.item.value = self.valueTextView.text;
    self.item.isSecret = [self.isSecretSwitch isOn];

    [self.delegate didUpdateItem:self.item];

    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - Notifications

- (void)toggleCreateButton:(NSNotification*)notification
{
    self.doneBarButtonItem.enabled = self.nameTextField.text.length > 0;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath.row == ROW_VALUE)
        return 60.0f - 48.0f + self.valueTextView.contentSize.height;

    return tableView.rowHeight;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField*)textField
{
    if (textField == self.nameTextField)
    {
        [self.valueTextView becomeFirstResponder];

        return NO;
    }
    
    return YES;
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView*)textView
{
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}

#pragma mark - Class methods

+ (instancetype)instantiate
{
    return [[AppDelegate sharedDelegate].window.rootViewController.storyboard instantiateViewControllerWithIdentifier:@"EditItem"];
}

@end
