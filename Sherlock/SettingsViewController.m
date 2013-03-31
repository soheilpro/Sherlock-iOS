//
//  SettingsViewController.m
//  Sherlock
//
//  Created by Soheil Rashidi on 3/31/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import <Dropbox/Dropbox.h>
#import "SettingsViewController.h"
#import "ActionSheet.h"
#import "Theme.h"

@implementation SettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[DBAccountManager sharedManager] addObserver:self block:^(DBAccount* account)
    {
        [self refreshDropboxStatus];
    }];

    [self refreshDropboxStatus];
}

- (IBAction)close:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)linkDropbox:(id)sender
{
    [[DBAccountManager sharedManager] linkFromController:self];
}

- (void)unlinkDropbox:(id)sender
{
    ActionSheet* actionSheet = [ActionSheet actionSheet];
    
    [actionSheet addDestructiveButtonWithTitle:@"Unlink" selectBlock:^
    {
        [[DBAccountManager sharedManager].linkedAccount unlink];
        [DBFilesystem setSharedFilesystem:nil];
    }];
    
    [actionSheet addCancelButtonWithTitle:@"Cancel"];
    
    [actionSheet presentInView:self.view];
}

- (void)refreshDropboxStatus
{
    DBAccount* account = [DBAccountManager sharedManager].linkedAccount;
    
    if (account == nil)
    {
        self.linkDropboxButton.hidden = NO;
        self.unlinkDropboxButton.hidden = YES;
        self.dropboxDislpayNameLabel.text = @"no linked account";
        self.dropboxDislpayNameLabel.textColor = [self.dropboxDislpayNameLabel.textColor colorWithAlphaComponent:.5];
    }
    else
    {
        self.linkDropboxButton.hidden = YES;
        self.unlinkDropboxButton.hidden = NO;
        self.dropboxDislpayNameLabel.text = account.info.displayName;
        self.dropboxDislpayNameLabel.textColor = [self.dropboxDislpayNameLabel.textColor colorWithAlphaComponent:1];
    }
}

@end
