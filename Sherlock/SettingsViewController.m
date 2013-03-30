//
//  SettingsViewController.m
//  Sherlock
//
//  Created by Soheil Rashidi on 3/31/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import <Dropbox/Dropbox.h>
#import "SettingsViewController.h"

@implementation SettingsViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self refreshDropboxStatus];
}

- (IBAction)close:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)linkDropbox:(id)sender
{
    [[DBAccountManager sharedManager] linkFromController:self];

    [self refreshDropboxStatus];
}

- (void)unlinkDropbox:(id)sender
{
    [[[DBAccountManager sharedManager] linkedAccount] unlink];
    
    [self refreshDropboxStatus];
}

- (void)refreshDropboxStatus
{
    DBAccount* account = [[DBAccountManager sharedManager] linkedAccount];
    
    if (account == nil)
    {
        self.linkDropboxButton.hidden = NO;
        self.unlinkDropboxButton.hidden = YES;
        self.dropboxDislpayNameLabel.text = @"";
        self.dropboxEMailLabel.text = @"";
    }
    else
    {
        self.linkDropboxButton.hidden = YES;
        self.unlinkDropboxButton.hidden = NO;
        self.dropboxDislpayNameLabel.text = account.info.displayName;
        self.dropboxEMailLabel.text = account.info.email;
    }
}

@end
