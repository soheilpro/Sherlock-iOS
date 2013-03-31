//
//  ThemedPanel.m
//  Sherlock
//
//  Created by Soheil Rashidi on 3/31/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ThemedPanel.h"
#import "Theme.h"

@implementation ThemedPanel

- (void)awakeFromNib
{
    self.layer.backgroundColor = [[Theme defaultTheme].textFieldBackgroundColor CGColor];
    self.layer.borderColor = [[Theme defaultTheme].textFieldBorderColor CGColor];
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = 5;
    self.clipsToBounds = YES;
}

@end
