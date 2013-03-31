//
//  ItemNode.m
//  Sherlock
//
//  Created by Soheil Rashidi on 3/30/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import "Item.h"

@implementation Item

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
