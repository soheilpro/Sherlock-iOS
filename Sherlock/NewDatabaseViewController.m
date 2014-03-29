//
//  NewDatabaseViewController.m
//  Sherlock
//
//  Created by Soheil Rashidi on 3/31/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import "AppDelegate.h"
#import "NewDatabaseViewController.h"

@interface NewDatabaseViewController ()

@property (nonatomic) NSInteger selectedStorageIndex;
@property (nonatomic, weak) IBOutlet UITextField* nameTextField;
@property (nonatomic, weak) IBOutlet UITableView* storageTableView;
@property (nonatomic, weak) IBOutlet UIBarButtonItem* createButtonItem;

@end

@implementation NewDatabaseViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.nameTextField.delegate = self;

    [self toggleCreateButton:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toggleCreateButton:) name:UITextFieldTextDidChangeNotification object:self.nameTextField];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.nameTextField becomeFirstResponder];
}

#pragma mark - Actions

-(IBAction)create:(id)sender
{
    Database* database = [[Database alloc] init];
    database.name = [self.nameTextField.text stringByAppendingPathExtension:DB_FILE_EXTENSION];
    database.storage = self.storage;

    [self.delegate didCreateDatabase:database];
    
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - Notifications

- (void)toggleCreateButton:(NSNotification*)notification
{
    self.createButtonItem.enabled = self.nameTextField.text.length > 0;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField*)textField
{
    if (textField == self.nameTextField)
        [self create:textField];

    return YES;
}

#pragma mark - Class methods

+ (instancetype)instantiate
{
    return [[AppDelegate sharedDelegate].window.rootViewController.storyboard instantiateViewControllerWithIdentifier:@"NewDatabase"];
}

@end
