//
//  Folder.m
//  Sherlock
//
//  Created by Soheil Rashidi on 3/30/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import "Folder.h"

@implementation Folder

+ (NSComparator)sortingComparator
{
    return ^NSComparisonResult(id obj1, id obj2)
    {
        Folder* folder1 = (Folder*)obj1;
        Folder* folder2 = (Folder*)obj2;
        
        return [folder1.name compare:folder2.name options:NSCaseInsensitiveSearch];
    };
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
        self.folders = [NSMutableArray array];
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
