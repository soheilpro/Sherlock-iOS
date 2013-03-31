//
//  UserTableView.m
//  Sherlock
//
//  Created by Soheil Rashidi on 10/13/12.
//  Copyright (c) 2012 Radset. All rights reserved.
//

#import "ThemedTableView.h"
#import "Theme.h"

@implementation ThemedTableView

- (void)awakeFromNib
{
    self.backgroundView = nil;
    self.backgroundColor = [Theme defaultTheme].tableBackgroundColor;
    self.separatorColor = [Theme defaultTheme].tableBackgroundColor;
}

@end
