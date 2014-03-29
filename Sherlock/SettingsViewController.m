//
//  SettingsViewController.m
//  Sherlock
//
//  Created by Soheil Rashidi on 3/31/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import "AppDelegate.h"
#import "SRActionSheet.h"
#import "SettingsViewController.h"
#import <DropboxSDK/DropboxSDK.h>

@interface SettingsViewController ()

@property (nonatomic, weak) IBOutlet UIButton* linkDropboxButton;
@property (nonatomic, weak) IBOutlet UIButton* unlinkDropboxButton;
@property (nonatomic, weak) IBOutlet UILabel* dropboxStatusLabel;

@end

@implementation SettingsViewController

#pragma mark - UIViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self refreshDropboxStatus];
}

#pragma mark - Actions

- (IBAction)linkDropbox:(id)sender
{
    [[DBSession sharedSession] linkFromController:self];
}

- (IBAction)unlinkDropbox:(id)sender
{
    SRActionSheet* actionSheet = [SRActionSheet actionSheet];
    
    [actionSheet addDestructiveButtonWithTitle:@"Unlink" selectBlock:^
    {
        [[DBSession sharedSession] unlinkAll];

        [self refreshDropboxStatus];
    }];
    
    [actionSheet addCancelButtonWithTitle:@"Cancel"];
    
    [actionSheet presentInView:self.view];
}

#pragma mark - 

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

#pragma mark - Class methods

+ (instancetype)instantiate
{
    return [[AppDelegate sharedDelegate].window.rootViewController.storyboard instantiateViewControllerWithIdentifier:@"Settings"];
}

@end
