//
//  AppDelegate.m
//  Sherlock
//
//  Created by Soheil Rashidi on 3/30/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

@interface AppDelegate ()

@property (nonatomic, strong) Database* database;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{
    UIUserInterfaceIdiom idiom = [[UIDevice currentDevice] userInterfaceIdiom];

    if (idiom == UIUserInterfaceIdiomPhone)
    {
        MainViewController* mainViewController = [((UINavigationController*)self.window.rootViewController).viewControllers objectAtIndex:0];
        mainViewController.showCategories = YES;
        mainViewController.showItems = YES;
    }
    else if (idiom == UIUserInterfaceIdiomPad)
    {
        UINavigationController* masterViewController = [self.window.rootViewController.storyboard instantiateViewControllerWithIdentifier:@"Navigation"];
        MainViewController* masterMainViewController = [masterViewController.viewControllers objectAtIndex:0];
        masterMainViewController.showCategories = YES;
        
        UINavigationController* detailViewController = [self.window.rootViewController.storyboard instantiateViewControllerWithIdentifier:@"Navigation"];
        MainViewController* detailMainViewController = [detailViewController.viewControllers objectAtIndex:0];
        detailMainViewController.showItems = YES;

        UISplitViewController* splitViewController = (UISplitViewController*)self.window.rootViewController;
        splitViewController.viewControllers = @[masterViewController, detailViewController];
        splitViewController.delegate = detailMainViewController;
    }
    
    [self.window makeKeyAndVisible];
    [self selectDatabase:NO];
    
    return YES;
}

- (void)selectDatabase:(BOOL)animated;
{
    UIViewController* rootViewController = self.window.rootViewController;
    UINavigationController* navigationViewController = [rootViewController.storyboard instantiateViewControllerWithIdentifier:@"FilesNavigation"];
    
    [rootViewController presentModalViewController:navigationViewController animated:animated];
}

- (void)didOpenDatabase:(Database*)database
{
    self.database = database;
    
    MainViewController* mainViewController = [((UINavigationController*)self.window.rootViewController).viewControllers objectAtIndex:0];
    mainViewController.rootNode = database.root;
    [mainViewController refresh];
}

@end
