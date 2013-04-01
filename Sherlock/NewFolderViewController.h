//
//  NewFolderViewController.h
//  Sherlock
//
//  Created by Soheil Rashidi on 4/1/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Database.h"

@protocol NewFolderDelegate<NSObject>

@required
- (void)didCreateNewFolder:(Folder*)folder;

@end

@interface NewFolderViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic, weak) id<NewFolderDelegate> delegate;
@property (nonatomic, weak) IBOutlet UIBarButtonItem* createBarButtonItem;
@property (nonatomic, weak) IBOutlet UITextField* nameTextField;

- (IBAction)create:(id)sender;
- (IBAction)cancel:(id)sender;

@end
