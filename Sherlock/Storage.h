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
- (NSArray*)databaseFiles;
- (void)fetchListOfDatabaseFiles;
- (NSData*)readDatabaseFile:(NSString*)file;
- (void)saveDatabaseData:(NSData*)data withName:(NSString*)name;
- (void)addObserverBlock:(observerBlock)block;

@end
