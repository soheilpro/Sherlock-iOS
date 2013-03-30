//
//  AppDelegate.m
//  Sherlock
//
//  Created by Soheil Rashidi on 3/30/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "CategoryNode.h"
#import "ItemNode.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{
    UIUserInterfaceIdiom idiom = [[UIDevice currentDevice] userInterfaceIdiom];
    
    CategoryNode* rootNode = [[CategoryNode alloc] init];
    CategoryNode* cat1Node = [[CategoryNode alloc] initWithName:@"Cat 1"];
    [cat1Node.categories addObject:[[CategoryNode alloc] initWithName:@"Cat 1.1"]];
    [cat1Node.items addObject:[[ItemNode alloc] initWithName:@"Item 1.2" andValue:@"Val 1.2"]];
    [rootNode.categories addObject:cat1Node];
    [rootNode.categories addObject:[[CategoryNode alloc] initWithName:@"Cat 2"]];
    [rootNode.items addObject:[[ItemNode alloc] initWithName:@"Item 1" andValue:@"Val 1"]];
    [rootNode.items addObject:[[ItemNode alloc] initWithName:@"Item 2" andValue:@"Val 2"]];
    
    if (idiom == UIUserInterfaceIdiomPhone)
    {
        MainViewController* mainViewController = [((UINavigationController*)self.window.rootViewController).viewControllers objectAtIndex:0];
        mainViewController.rootNode = rootNode;
        mainViewController.showCategories = YES;
        mainViewController.showItems = YES;
    }
    else if (idiom == UIUserInterfaceIdiomPad)
    {
        UINavigationController* masterViewController = [self.window.rootViewController.storyboard instantiateViewControllerWithIdentifier:@"Navigation"];
        MainViewController* masterMainViewController = [masterViewController.viewControllers objectAtIndex:0];
        masterMainViewController.rootNode = rootNode;
        masterMainViewController.showCategories = YES;
        
        UINavigationController* detailViewController = [self.window.rootViewController.storyboard instantiateViewControllerWithIdentifier:@"Navigation"];
        MainViewController* detailMainViewController = [detailViewController.viewControllers objectAtIndex:0];
        detailMainViewController.rootNode = rootNode;
        detailMainViewController.showItems = YES;

        UISplitViewController* splitViewController = (UISplitViewController*)self.window.rootViewController;
        splitViewController.viewControllers = @[masterViewController, detailViewController];
        splitViewController.delegate = detailMainViewController;
    }
    
    return YES;
}

@end
