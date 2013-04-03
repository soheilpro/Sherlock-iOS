//
//  AppDelegate.m
//  Sherlock
//
//  Created by Soheil Rashidi on 3/30/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import <Dropbox/Dropbox.h>
#import "AppDelegate.h"
#import "FolderViewController.h"
#import "Theme.h"

NSString* const NSURLIsExcludedFromBackupKey = @"NSURLIsExcludedFromBackupKey";

@interface AppDelegate ()

@property (nonatomic, strong) Database* database;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{
    UIUserInterfaceIdiom idiom = [[UIDevice currentDevice] userInterfaceIdiom];

    if (idiom == UIUserInterfaceIdiomPhone)
    {
        FolderViewController* mainViewController = [((UINavigationController*)self.window.rootViewController).viewControllers objectAtIndex:0];
        mainViewController.showCategories = YES;
        mainViewController.showItems = YES;
    }
    else if (idiom == UIUserInterfaceIdiomPad)
    {
        UINavigationController* masterViewController = [self.window.rootViewController.storyboard instantiateViewControllerWithIdentifier:@"Navigation"];
        FolderViewController* masterMainViewController = [masterViewController.viewControllers objectAtIndex:0];
        masterMainViewController.showCategories = YES;
        
        UINavigationController* detailViewController = [self.window.rootViewController.storyboard instantiateViewControllerWithIdentifier:@"Navigation"];
        FolderViewController* detailMainViewController = [detailViewController.viewControllers objectAtIndex:0];
        detailMainViewController.showItems = YES;

        UISplitViewController* splitViewController = (UISplitViewController*)self.window.rootViewController;
        splitViewController.viewControllers = @[masterViewController, detailViewController];
        splitViewController.delegate = detailMainViewController;
    }
    
    [[Theme defaultTheme] apply];
    
    [self setupDropbox];
    
    [self.window makeKeyAndVisible];
    [self selectDatabase:NO];
    
    return YES;
}

- (BOOL)application:(UIApplication*)app openURL:(NSURL*)url sourceApplication:(NSString*)source annotation:(id)annotation
{    
    DBAccount* account = [[DBAccountManager sharedManager] handleOpenURL:url];
    
    if (account != nil)
        return YES;
    
    return NO;
}

- (void)setupDropbox
{
    DBAccountManager* accountManager = [[DBAccountManager alloc] initWithAppKey:@"YOUR_APP_KEY" secret:@"YOUR_APP_SECRET"];
    [DBAccountManager setSharedManager:accountManager];
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
