//
//  Node.h
//  Sherlock
//
//  Created by Soheil Rashidi on 3/30/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Folder;
@class Database;

@interface Node : NSObject

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) Folder* parent;
@property (nonatomic, strong) Database* database;

@end
