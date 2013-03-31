//
//  ThemedTextField.m
//  Sherlock
//
//  Created by Soheil Rashidi on 10/11/12.
//  Copyright (c) 2012 Radset. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ThemedTextField.h"
#import "Theme.h"

@implementation ThemedTextField

- (void)awakeFromNib
{
    self.font = [Theme defaultTheme].textFieldFont;
    self.borderStyle = UITextBorderStyleNone;
    self.layer.backgroundColor = [[Theme defaultTheme].textFieldBackgroundColor CGColor];
    self.layer.borderColor = [[Theme defaultTheme].textFieldBorderColor CGColor];
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = 5;
    self.clipsToBounds = YES;
    
    UIView* paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, self.frame.size.height)];
    self.leftView = paddingView;
    self.rightView = paddingView;
    self.leftViewMode = UITextFieldViewModeAlways;
    self.rightViewMode = UITextFieldViewModeAlways;
    
    CGRect frame = self.frame;
    frame.size.height = 34;
    self.frame = frame;
}

@end
