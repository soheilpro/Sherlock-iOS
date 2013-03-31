//
//  NewDatabaseViewController.h
//  Sherlock
//
//  Created by Soheil Rashidi on 3/31/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewDatabaseViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) NSArray* storages;
@property (nonatomic, weak) IBOutlet UITextField* nameTextField;
@property (nonatomic, weak) IBOutlet UITextField* passwordTextField;
@property (nonatomic, weak) IBOutlet UITableView* storageTableView;
@property (nonatomic, weak) IBOutlet UIBarButtonItem* createButtonItem;

- (IBAction)create:(id)sender;
- (IBAction)cancel:(id)sender;

@end
