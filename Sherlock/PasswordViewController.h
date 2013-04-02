//
//  PasswordViewController.h
//  Sherlock
//
//  Created by Soheil Rashidi on 3/30/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Storage.h"
#import "Database.h"

@protocol PasswordDelegate<NSObject>

@required
- (BOOL)didEnterPassword:(NSString*)password inViewController:(UIViewController*)viewController;

@end

@interface PasswordViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic, strong) Database* database;
@property (nonatomic, weak) id<PasswordDelegate> delegate;
@property (nonatomic, weak) IBOutlet UINavigationItem* navigationItem2;
@property (nonatomic, weak) IBOutlet UITextField* passwordTextField;

- (IBAction)go:(id)sender;
- (IBAction)cancel:(id)sender;

@end
