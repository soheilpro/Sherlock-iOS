//
//  SettingsViewController.m
//  Sherlock
//
//  Created by Soheil Rashidi on 3/31/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import <DropboxSDK/DropboxSDK.h>
#import "SettingsViewController.h"
#import "ActionSheet.h"
#import "Theme.h"

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
    [[DBSession sharedSession] linkFromController:self];
}

- (void)unlinkDropbox:(id)sender
{
    ActionSheet* actionSheet = [ActionSheet actionSheet];
    
    [actionSheet addDestructiveButtonWithTitle:@"Unlink" selectBlock:^
    {
        [[DBSession sharedSession] unlinkAll];

        [self refreshDropboxStatus];
    }];
    
    [actionSheet addCancelButtonWithTitle:@"Cancel"];
    
    [actionSheet presentInView:self.view];
}

- (void)refreshDropboxStatus
{
    if (![DBSession sharedSession].isLinked)
    {
        self.linkDropboxButton.hidden = NO;
        self.unlinkDropboxButton.hidden = YES;
        self.dropboxStatusLabel.text = @"No linked account";
        self.dropboxStatusLabel.textColor = [UIColor grayColor];
    }
    else
    {
        self.linkDropboxButton.hidden = YES;
        self.unlinkDropboxButton.hidden = NO;
        self.dropboxStatusLabel.text = @"Linked";
        self.dropboxStatusLabel.textColor = [UIColor colorWithRed:0 green:.5 blue:0 alpha:1];
    }
}

@end
