//
//  NewItemViewController.h
//  Sherlock
//
//  Created by Soheil Rashidi on 4/2/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Database.h"

@protocol NewItemDelegate<NSObject>

@required
- (void)didCreateNewItem:(Item*)item;

@end

@interface NewItemViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic, weak) id<NewItemDelegate> delegate;
@property (nonatomic, weak) IBOutlet UIBarButtonItem* createBarButtonItem;
@property (nonatomic, weak) IBOutlet UITextField* nameTextField;
@property (nonatomic, weak) IBOutlet UITextView* valueTextView;
@property (nonatomic, weak) IBOutlet UISwitch* isSecretSwitch;

- (IBAction)create:(id)sender;
- (IBAction)cancel:(id)sender;

@end
