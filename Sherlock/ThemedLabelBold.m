//
//  ThemedLabelBold.m
//  Sherlock
//
//  Created by Soheil Rashidi on 3/31/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import "ThemedLabelBold.h"
#import "Theme.h"

@implementation ThemedLabelBold

- (void)awakeFromNib
{
    self.font = [Theme defaultTheme].textFontBold;
}

@end
