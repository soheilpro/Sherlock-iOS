//
//  UIView+UIVIew_ActivityIndicator.m
//  Sherlock
//
//  Created by Soheil Rashidi on 6/13/12.
//  Copyright (c) 2012 Radset. All rights reserved.
//

#import "MBProgressHUD.h"
#import "UIViewController+ActivityIndicator.h"

@implementation UIViewController (ActivityIndicator)

- (id)displayActivityIndicator
{
    return [self displayActivityIndicatorWithMessage:nil userInteractionsEnabled:YES];
}

- (id)displayActivityIndicatorWithUserInteractionsEnabled:(BOOL)userInteractionEnabled
{
    return [self displayActivityIndicatorWithMessage:nil userInteractionsEnabled:userInteractionEnabled];
}

- (id)displayActivityIndicatorWithMessage:(NSString*)message
{
    return [self displayActivityIndicatorWithMessage:message userInteractionsEnabled:YES];
}

- (id)displayActivityIndicatorWithMessage:(NSString*)message userInteractionsEnabled:(BOOL)userInteractionEnabled
{
    MBProgressHUD* progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    progressHUD.labelText = message;
    progressHUD.removeFromSuperViewOnHide = YES;
    progressHUD.userInteractionEnabled = userInteractionEnabled;

    [self.view addSubview:progressHUD];
    [progressHUD show:YES];

    return progressHUD;
}

- (void)hideActivityIndicator:(id)indicator
{
    MBProgressHUD* progressHUD = (MBProgressHUD*)indicator;

    [progressHUD hide:YES];
}

@end
