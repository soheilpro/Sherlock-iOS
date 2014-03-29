//
//  DatabasesModalViewController.m
//  Sherlock
//
//  Created by Soheil Rashidi on 3/29/14.
//  Copyright (c) 2014 Softtool. All rights reserved.
//

#import "DatabasesModalViewController.h"
#import "DatabasesViewController.h"

@implementation DatabasesModalViewController

#pragma mark - Init

- (instancetype)init
{
    self = [super init];

    if (self)
    {
        self.transitioningDelegate = self;
    }

    return self;
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    DatabasesViewController* databasesViewController = [DatabasesViewController instantiate];

    self.viewControllers = @[databasesViewController];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController*)presented presentingController:(UIViewController*)presenting sourceController:(UIViewController*)source
{
    return (id<UIViewControllerAnimatedTransitioning>)self;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController*)dismissed
{
    return (id<UIViewControllerAnimatedTransitioning>)self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.7f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView* containerView = [transitionContext containerView];
    UIViewController* fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController* toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    [containerView addSubview:fromVC.view];
    [containerView addSubview:toVC.view];

    UIViewAnimationOptions animationOption = ([toVC.presentedViewController isEqual:fromVC]) ? UIViewAnimationOptionTransitionFlipFromLeft : UIViewAnimationOptionTransitionFlipFromRight;

    [UIView transitionFromView:fromVC.view toView:toVC.view duration:[self transitionDuration:transitionContext] options:animationOption completion:^(BOOL finished)
    {
        [transitionContext completeTransition:YES];
    }];
}

#pragma mark - Class methods

+ (instancetype)instantiate
{
    return [[self alloc] init];
}

@end
