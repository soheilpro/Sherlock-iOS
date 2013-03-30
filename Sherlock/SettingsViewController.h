//
//  SettingsViewController.h
//  Sherlock
//
//  Created by Soheil Rashidi on 3/31/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIButton* linkDropboxButton;
@property (nonatomic, weak) IBOutlet UIButton* unlinkDropboxButton;
@property (nonatomic, weak) IBOutlet UILabel* dropboxDislpayNameLabel;
@property (nonatomic, weak) IBOutlet UILabel* dropboxEMailLabel;

- (IBAction)close:(id)sender;
- (IBAction)linkDropbox:(id)sender;
- (IBAction)unlinkDropbox:(id)sender;

@end
