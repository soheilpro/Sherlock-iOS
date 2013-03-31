//
//  Folder.h
//  Sherlock
//
//  Created by Soheil Rashidi on 3/30/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Node.h"

@interface Folder : Node

@property (nonatomic, strong) NSMutableArray* folders;
@property (nonatomic, strong) NSMutableArray* items;

- (id)initWithName:(NSString*)name;

@end
