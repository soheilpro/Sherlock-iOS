//
//  UIViewController+Alert.h
//  Sherlock
//
//  Created by Soheil Rashidi on 6/13/12.
//  Copyright (c) 2012 Radset. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Alert)

- (void)displayErrorMessage:(NSString*)message;
- (void)displayErrorMessage:(NSString*)message withKeyboardVisible:(BOOL)keyboardVisible;

@end
