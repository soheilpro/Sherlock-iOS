//
//  NewDatabaseViewController.m
//  Sherlock
//
//  Created by Soheil Rashidi on 3/31/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import "NewDatabaseViewController.h"
#import "Storage.h"
#import "Database.h"
#import "AppDelegate.h"

@interface NewDatabaseViewController ()

@property (nonatomic) NSInteger selectedStorageIndex;

@end

@implementation NewDatabaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.nameTextField.delegate = self;

    [self toggleCreateButton];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toggleCreateButton) name:UITextFieldTextDidChangeNotification object:self.nameTextField];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
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
    self.createButtonItem.enabled = self.nameTextField.text.length > 0;
}

-(void)done:(id)sender
{
    Database* database = [[Database alloc] init];
    database.name = self.nameTextField.text;
    database.storage = [self.storages objectAtIndex:self.selectedStorageIndex];

    [self.delegate didCreateDatabase:database];
    
    [self dismissModalViewControllerAnimated:YES];
}

- (void)cancel:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.storages.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    id<Storage> storage = [self.storages objectAtIndex:indexPath.row];
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"StorageCell"];
    cell.textLabel.text = [storage name];
    cell.accessoryType = indexPath.row == self.selectedStorageIndex ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    self.selectedStorageIndex = indexPath.row;
    
    [tableView reloadData];
    [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
