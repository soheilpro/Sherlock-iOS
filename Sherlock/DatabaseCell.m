//
//  DatabaseCell.m
//  Sherlock
//
//  Created by Soheil Rashidi on 3/29/14.
//  Copyright (c) 2014 Softtool. All rights reserved.
//

#import "Database+Display.h"
#import "DatabaseCell.h"

@implementation DatabaseCell

#pragma mark - Methods

- (void)setDatabase:(Database*)database
{
    _database = database;

    self.textLabel.text = [database displayName];
    self.detailTextLabel.text = database.isReadOnly ? @"readonly" : nil;
}

@end
