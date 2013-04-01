//
//  ItemNode.m
//  Sherlock
//
//  Created by Soheil Rashidi on 3/30/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import "Item.h"

@implementation Item

+ (NSComparator)sortingComparator
{
    return ^NSComparisonResult(id obj1, id obj2)
    {
        Item* item1 = (Item*)obj1;
        Item* item2 = (Item*)obj2;
        
        return [item1.name compare:item2.name options:NSCaseInsensitiveSearch];
    };
}

- (id)initWithName:(NSString*)name andValue:(NSString*)value
{
    self = [self init];
    
    if (self)
    {
        self.name = name;
        self.value = value;
    }
    
    return self;
}

@end
