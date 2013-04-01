//
//  NewItemViewController.h
//  Sherlock
//
//  Created by Soheil Rashidi on 4/2/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Database.h"

@protocol EditItemDelegate<NSObject>

@required
- (void)didUpdateItem:(Item*)item;

@end

@interface EditItemViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic, strong) Item* item;
@property (nonatomic, weak) id<EditItemDelegate> delegate;
@property (nonatomic, weak) IBOutlet UIBarButtonItem* doneBarButtonItem;
@property (nonatomic, weak) IBOutlet UITextField* nameTextField;
@property (nonatomic, weak) IBOutlet UITextView* valueTextView;
@property (nonatomic, weak) IBOutlet UISwitch* isSecretSwitch;

- (IBAction)done:(id)sender;
- (IBAction)cancel:(id)sender;

@end
