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
    self.passwordTextField.delegate = self;

    [self toggleCreateButton];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toggleCreateButton) name:UITextFieldTextDidChangeNotification object:self.nameTextField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toggleCreateButton) name:UITextFieldTextDidChangeNotification object:self.passwordTextField];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.nameTextField becomeFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField
{
    if (textField == self.nameTextField)
    {
        [self.passwordTextField becomeFirstResponder];
    }
    else if (textField == self.passwordTextField)
    {
        [self create:textField];
    }
    
    return YES;
}

- (void)toggleCreateButton
{
    self.createButtonItem.enabled = self.nameTextField.text.length > 0 && self.passwordTextField.text.length > 0;
}

-(void)create:(id)sender
{
    Database* database = [[Database alloc] init];
    database.password = self.passwordTextField.text;
    [database.root.folders addObject:[[Folder alloc] initWithName:@"test"]];
    [database.root.items addObject:[[Item alloc] initWithName:@"test" andValue:@"test"]];
    
    NSData* data = [database save];
    
    id<Storage> storage = [self.storages objectAtIndex:self.selectedStorageIndex];
    [storage saveDatabaseData:data withName:self.nameTextField.text];
    
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
