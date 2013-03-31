//
//  Storage.h
//  Sherlock
//
//  Created by Soheil Rashidi on 3/31/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Storage <NSObject>

@required

- (NSString*)name;
- (NSArray*)databaseFiles;
- (void)fetchListOfDatabaseFiles;
- (NSData*)readDatabaseFile:(NSString*)file;

@end
