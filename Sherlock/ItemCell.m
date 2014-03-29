//
//  ItemCell.m
//  Sherlock
//
//  Created by Soheil Rashidi on 3/29/14.
//  Copyright (c) 2014 Softtool. All rights reserved.
//

#import "ItemCell.h"

@implementation ItemCell

#pragma mark - Methods

- (void)setItem:(Item*)item
{
    _item = item;

    self.textLabel.text = item.name;
    self.detailTextLabel.text = !item.isSecret ? item.value : [@"" stringByPaddingToLength:item.value.length withString:@"\u2022" startingAtIndex:0];
}

@end
