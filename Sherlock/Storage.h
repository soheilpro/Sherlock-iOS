//
//  Storage.h
//  Sherlock
//
//  Created by Soheil Rashidi on 3/31/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Database.h"

typedef void (^observerBlock)();

@protocol Storage<NSObject>

@required
- (NSString*)name;
- (BOOL)isAvailable;
- (NSArray*)databases;
- (void)fetchDatabases;
- (NSData*)readDatabase:(Database*)database;
- (void)saveDatabase:(Database*)data withData:(NSData*)data;
- (void)deleteDatabase:(Database*)database;
- (void)addObserverBlock:(observerBlock)block;

@end
