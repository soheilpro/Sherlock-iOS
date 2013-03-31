//
//  ThemedTextView.m
//  Sherlock
//
//  Created by Soheil Rashidi on 3/31/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ThemedTextView.h"
#import "Theme.h"

@implementation ThemedTextView

- (void)awakeFromNib
{
    self.font = [Theme defaultTheme].textFieldFont;
    self.layer.backgroundColor = [[Theme defaultTheme].textFieldBackgroundColor CGColor];
    self.layer.borderColor = [[Theme defaultTheme].textFieldBorderColor CGColor];
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = 5;
    self.clipsToBounds = YES;
}

@end
