//
//  AppDelegate.m
//  Sherlock
//
//  Created by Soheil Rashidi on 3/30/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import "AppDelegate.h"
#import "DatabasesModalViewController.h"
#import "Dropbox.h"
#import "FolderViewController.h"

NSString* const NSURLIsExcludedFromBackupKey = @"NSURLIsExcludedFromBackupKey";

@interface AppDelegate ()

@property (nonatomic, strong) Database* database;

@end

@implementation AppDelegate

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{
    FolderViewController* mainViewController = ((UINavigationController*)self.window.rootViewController).viewControllers[0];
    mainViewController.showCategories = YES;
    mainViewController.showItems = YES;

    [self.window makeKeyAndVisible];
    [self selectDatabase:NO];
    
    return YES;
}

- (BOOL)application:(UIApplication*)app openURL:(NSURL*)url sourceApplication:(NSString*)source annotation:(id)annotation
{
    if ([[Dropbox sharedDropbox] handleOpenURL:url])
        return YES;
    
    return NO;
}

#pragma mark - Methods

- (void)unloadCurrentDatabase
{
    self.database = nil;

    [self selectDatabase:YES];
}

- (void)didOpenDatabase:(Database*)database
{
    self.database = database;

    FolderViewController* mainViewController = ((UINavigationController*)self.window.rootViewController).viewControllers[0];
    mainViewController.folder = database.root;
}

#pragma mark -

- (void)selectDatabase:(BOOL)animated;
{
    DatabasesModalViewController* databasesModalViewController = [DatabasesModalViewController instantiate];

    [self.window.rootViewController presentViewController:databasesModalViewController animated:animated completion:nil];
}

#pragma mark - Class methods

+ (AppDelegate*)sharedDelegate
{
    return ((AppDelegate*)[UIApplication sharedApplication].delegate);
}

@end
