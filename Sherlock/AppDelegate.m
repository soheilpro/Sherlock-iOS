//
//  AppDelegate.m
//  Sherlock
//
//  Created by Soheil Rashidi on 3/30/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import <DropboxSDK/DropboxSDK.h>
#import "AppDelegate.h"
#import "FolderViewController.h"

NSString* const NSURLIsExcludedFromBackupKey = @"NSURLIsExcludedFromBackupKey";

@interface AppDelegate ()

@property (nonatomic, strong) Database* database;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{
    FolderViewController* mainViewController = [((UINavigationController*)self.window.rootViewController).viewControllers objectAtIndex:0];
    mainViewController.showCategories = YES;
    mainViewController.showItems = YES;

    [self setupDropbox];
    
    [self.window makeKeyAndVisible];
    [self selectDatabase:NO];
    
    return YES;
}

- (BOOL)application:(UIApplication*)app openURL:(NSURL*)url sourceApplication:(NSString*)source annotation:(id)annotation
{
    if ([[DBSession sharedSession] handleOpenURL:url])
        return YES;
    
    return NO;
}

- (void)setupDropbox
{
    DBSession* session = [[DBSession alloc] initWithAppKey:@"YOUR_APP_KEY" appSecret:@"YOUR_APP_SECRET" root:kDBRootDropbox];
    [DBSession setSharedSession:session];
}

- (void)selectDatabase:(BOOL)animated;
{
    UIViewController* rootViewController = self.window.rootViewController;
    UINavigationController* navigationViewController = [rootViewController.storyboard instantiateViewControllerWithIdentifier:@"DatabasesNavigation"];
    
    [rootViewController presentModalViewController:navigationViewController animated:animated];
}

- (void)didOpenDatabase:(Database*)database
{
    self.database = database;
    
    FolderViewController* mainViewController = [((UINavigationController*)self.window.rootViewController).viewControllers objectAtIndex:0];
    mainViewController.folder = database.root;
}

- (void)unloadCurrentDatabase
{
    self.database = nil;
    
    [self selectDatabase:YES];
}

@end
