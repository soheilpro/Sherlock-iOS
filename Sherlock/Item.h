//
//  ItemNode.h
//  Sherlock
//
//  Created by Soheil Rashidi on 3/30/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Node.h"

@interface Item : Node

@property (nonatomic, strong) NSString* value;
@property (nonatomic) BOOL isSecret;

+ (NSComparator)sortingComparator;

- (id)initWithName:(NSString*)name andValue:(NSString*)value;

@end
