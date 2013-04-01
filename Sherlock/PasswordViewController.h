//
//  PasswordViewController.h
//  Sherlock
//
//  Created by Soheil Rashidi on 3/30/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Storage.h"

@interface PasswordViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic, strong) id<Storage> storage;
@property (nonatomic, strong) NSString* databaseFile;
@property (nonatomic, strong) NSData* databaseFileData;
@property (nonatomic, weak) IBOutlet UITextField* passwordTextField;

- (IBAction)open:(id)sender;

@end
