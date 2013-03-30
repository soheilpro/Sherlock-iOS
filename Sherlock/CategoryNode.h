//
//  CategoryNode.h
//  Sherlock
//
//  Created by Soheil Rashidi on 3/30/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Node.h"

@interface CategoryNode : Node

@property (nonatomic, strong) NSMutableArray* categories;
@property (nonatomic, strong) NSMutableArray* items;

- (id)initWithName:(NSString*)name;

@end
