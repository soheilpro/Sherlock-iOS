//
//  ThemedButton.m
//  Sherlock
//
//  Created by Soheil Rashidi on 10/12/12.
//  Copyright (c) 2012 Radset. All rights reserved.
//

#import "ThemedButtonDark.h"
#import "Theme.h"

@implementation ThemedButtonDark

- (void)awakeFromNib
{
    [self setBackgroundImage:[Theme defaultTheme].buttonDarkBackgroundImage forState:UIControlStateNormal];
    [self setTitleColor:[Theme defaultTheme].buttonDarkTextColor forState:UIControlStateNormal];
    self.titleLabel.font = [Theme defaultTheme].buttonFont;
}

@end
