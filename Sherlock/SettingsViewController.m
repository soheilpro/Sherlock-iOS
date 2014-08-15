//
//  SettingsViewController.m
//  Sherlock
//
//  Created by Soheil Rashidi on 3/31/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import "AppDelegate.h"
#import "GoogleDrive.h"
#import "SRActionSheet.h"
#import "SettingsViewController.h"
#import <DropboxSDK/DropboxSDK.h>

@interface SettingsViewController ()

@property (nonatomic, weak) IBOutlet UIButton* linkDropboxButton;
@property (nonatomic, weak) IBOutlet UIButton* unlinkDropboxButton;
@property (nonatomic, weak) IBOutlet UILabel* dropboxStatusLabel;

@property (nonatomic, weak) IBOutlet UIButton* linkGoogleDriveButton;
@property (nonatomic, weak) IBOutlet UIButton* unlinkGoogleDriveButton;
@property (nonatomic, weak) IBOutlet UILabel* googleDriveStatusLabel;

@end

@implementation SettingsViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self refreshDropboxStatus];
    [self refreshGoogleDriveStatus];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
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

- (IBAction)linkGoogleDrive:(id)sender
{
    [[GoogleDrive sharedGoogleDrive] linkWithViewController:self callback:^
    {
        [self refreshGoogleDriveStatus];
    }];
}

- (IBAction)unlinkGoogleDrive:(id)sender
{
    SRActionSheet* actionSheet = [SRActionSheet actionSheet];

    [actionSheet addDestructiveButtonWithTitle:@"Unlink" selectBlock:^
    {
        [[GoogleDrive sharedGoogleDrive] unlink];

        [self refreshGoogleDriveStatus];
    }];

    [actionSheet addCancelButtonWithTitle:@"Cancel"];

    [actionSheet presentInView:self.view];
}

#pragma mark - Notifications

- (void)applicationDidBecomeActive:(NSNotification*)notification
{
    [self refreshDropboxStatus];
    [self refreshGoogleDriveStatus];
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

- (void)refreshGoogleDriveStatus
{
    if (![GoogleDrive sharedGoogleDrive].isLinked)
    {
        self.linkGoogleDriveButton.hidden = NO;
        self.unlinkGoogleDriveButton.hidden = YES;
        self.googleDriveStatusLabel.text = @"No linked account";
        self.googleDriveStatusLabel.textColor = [UIColor grayColor];
    }
    else
    {
        self.linkGoogleDriveButton.hidden = YES;
        self.unlinkGoogleDriveButton.hidden = NO;
        self.googleDriveStatusLabel.text = @"Linked";
        self.googleDriveStatusLabel.textColor = [UIColor colorWithRed:0 green:.5 blue:0 alpha:1];
    }
}

#pragma mark - Class methods

+ (instancetype)instantiate
{
    return [[AppDelegate sharedDelegate].window.rootViewController.storyboard instantiateViewControllerWithIdentifier:@"Settings"];
}

@end
