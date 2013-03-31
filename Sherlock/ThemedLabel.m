//
//  ThemedLabel.m
//  Sherlock
//
//  Created by Soheil Rashidi on 3/31/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import "ThemedLabel.h"
#import "Theme.h"

@implementation ThemedLabel

- (void)awakeFromNib
{
    self.font = [Theme defaultTheme].textFont;
}

@end
