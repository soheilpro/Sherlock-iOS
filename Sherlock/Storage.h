//
//  Storage.h
//  Sherlock
//
//  Created by Soheil Rashidi on 3/31/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Database.h"

@protocol Storage<NSObject>

@required
- (NSString*)name;
- (BOOL)isAvailable;
- (NSArray*)databases;
- (void)fetchDatabasesWithCallback:(void (^) (NSArray* databases, NSError* error))callback;
- (void)readDatabase:(Database*)database callback:(void (^) (NSData* data, NSError* error))callback;
- (void)saveDatabase:(Database*)database withData:(NSData*)data callback:(void (^) (NSError* error))callback;
- (void)deleteDatabase:(Database*)database callback:(void (^) (NSError* error))callback;

@end
