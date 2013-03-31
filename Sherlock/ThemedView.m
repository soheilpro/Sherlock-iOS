//
//  ThemedView.m
//  Sherlock
//
//  Created by Soheil Rashidi on 10/15/12.
//  Copyright (c) 2012 Radset. All rights reserved.
//

#import "ThemedView.h"
#import "Theme.h"

@implementation ThemedView

- (void)awakeFromNib
{
    self.backgroundColor = [Theme defaultTheme].viewBackgroundColor;
}

@end
