//
//  NewFolderViewController.h
//  Sherlock
//
//  Created by Soheil Rashidi on 4/1/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Database.h"

@protocol EditFolderDelegate<NSObject>

@required
- (void)didUpdateFolder:(Folder*)folder;

@end

@interface EditFolderViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic, strong) Folder* folder;
@property (nonatomic, weak) id<EditFolderDelegate> delegate;
@property (nonatomic, weak) IBOutlet UIBarButtonItem* doneBarButtonItem;
@property (nonatomic, weak) IBOutlet UITextField* nameTextField;

- (IBAction)done:(id)sender;
- (IBAction)cancel:(id)sender;

@end
