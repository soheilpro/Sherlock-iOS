//
//  CategoryNode.m
//  Sherlock
//
//  Created by Soheil Rashidi on 3/30/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import "CategoryNode.h"

@implementation CategoryNode

- (id)init
{
    self = [super init];
    
    if (self)
    {
        self.categories = [NSMutableArray array];
        self.items = [NSMutableArray array];
    }
    
    return self;
}

- (id)initWithName:(NSString*)name
{
    self = [self init];

    if (self)
    {
        self.name = name;
    }
    
    return self;
}

@end
