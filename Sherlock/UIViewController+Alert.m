//
//  UIViewController+Alert.m
//  Sherlock
//
//  Created by Soheil Rashidi on 6/13/12.
//  Copyright (c) 2012 Radset. All rights reserved.
//

#import "UIViewController+Alert.h"
#import "MBProgressHUD.h"
#import "Theme.h"

@implementation UIViewController (Alert)

- (void)displayErrorMessage:(NSString*)message
{
    [self displayErrorMessage:message withKeyboardVisible:NO];
}

- (void)displayErrorMessage:(NSString*)message withKeyboardVisible:(BOOL)keyboardVisible;
{
    MBProgressHUD* hud = [[MBProgressHUD alloc] initWithView:self.view];
    hud.yOffset = keyboardVisible ? -77 : -40;
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    hud.labelFont = [Theme defaultTheme].hudFont;
    hud.removeFromSuperViewOnHide = YES;
    hud.userInteractionEnabled = NO;

    [self.view addSubview:hud];
    [hud show:YES];
    [hud hide:YES afterDelay:2];
}

@end
