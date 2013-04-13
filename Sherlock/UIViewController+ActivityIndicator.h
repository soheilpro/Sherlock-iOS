//
//  UIView+UIVIew_ActivityIndicator.h
//  Sherlock
//
//  Created by Soheil Rashidi on 6/13/12.
//  Copyright (c) 2012 Radset. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ActivityIndicator)

- (id)displayActivityIndicator;
- (id)displayActivityIndicatorWithUserInteractionsEnabled:(BOOL)userInteractionEnabled;
- (id)displayActivityIndicatorWithMessage:(NSString*)message;
- (id)displayActivityIndicatorWithMessage:(NSString*)message userInteractionsEnabled:(BOOL)userInteractionEnabled;
- (void)hideActivityIndicator:(id)indicator;

@end
