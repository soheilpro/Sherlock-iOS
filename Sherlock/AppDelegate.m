//
//  AppDelegate.m
//  Sherlock
//
//  Created by Soheil Rashidi on 3/30/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "Database.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{
    Database* database = [self readFile];

    UIUserInterfaceIdiom idiom = [[UIDevice currentDevice] userInterfaceIdiom];

    if (idiom == UIUserInterfaceIdiomPhone)
    {
        MainViewController* mainViewController = [((UINavigationController*)self.window.rootViewController).viewControllers objectAtIndex:0];
        mainViewController.rootNode = database.root;
        mainViewController.showCategories = YES;
        mainViewController.showItems = YES;
    }
    else if (idiom == UIUserInterfaceIdiomPad)
    {
        UINavigationController* masterViewController = [self.window.rootViewController.storyboard instantiateViewControllerWithIdentifier:@"Navigation"];
        MainViewController* masterMainViewController = [masterViewController.viewControllers objectAtIndex:0];
        masterMainViewController.rootNode = database.root;
        masterMainViewController.showCategories = YES;
        
        UINavigationController* detailViewController = [self.window.rootViewController.storyboard instantiateViewControllerWithIdentifier:@"Navigation"];
        MainViewController* detailMainViewController = [detailViewController.viewControllers objectAtIndex:0];
        detailMainViewController.rootNode = database.root;
        detailMainViewController.showItems = YES;

        UISplitViewController* splitViewController = (UISplitViewController*)self.window.rootViewController;
        splitViewController.viewControllers = @[masterViewController, detailViewController];
        splitViewController.delegate = detailMainViewController;
    }
    
    return YES;
}

- (Database*)readFile
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDir = [paths objectAtIndex:0];
    NSString* filePath = [documentsDir stringByAppendingPathComponent:@"Soheil.xml"];
    
    return [Database openDatabaseFromFile:filePath];
}

@end
