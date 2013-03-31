//
//  LocalStorage.m
//  Sherlock
//
//  Created by Soheil Rashidi on 3/31/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import "LocalStorage.h"

@interface LocalStorage ()

@property (nonatomic, strong) NSArray* files;
@property (nonatomic, strong) NSMutableArray* observerBlocks;

@end

@implementation LocalStorage

- (id)init
{
    self = [super init];
    
    if (self)
    {
        self.files = @[];
        self.observerBlocks = [NSMutableArray array];
    }
    
    return self;
}

- (NSString*)name
{
    return @"Local";
}

- (BOOL)isAvailable
{
    return YES;
}

- (NSArray*)databaseFiles
{
    return self.files;
}

- (void)fetchListOfDatabaseFiles
{
    self.files = [self fetchListOfDatabaseFilesInternal];
}

- (NSArray*)fetchListOfDatabaseFilesInternal
{
    NSString* documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSMutableArray* files = [NSMutableArray array];
    
    for (NSString* file in [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentDirectory error:nil])
        if ([[file pathExtension] isEqualToString:@"sdb"])
            [files addObject:[documentDirectory stringByAppendingPathComponent:file]];
    
    return files;
}

- (NSData*)readDatabaseFile:(NSString*)file
{
    return [NSData dataWithContentsOfFile:file];
}

- (void)saveDatabaseData:(NSData*)data withName:(NSString*)name;
{
    NSString* documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* file = [documentDirectory stringByAppendingPathComponent:[name stringByAppendingPathExtension:@"sdb"]];
    
    [data writeToFile:file atomically:YES];
    
    [self notifyObservers];
}

- (void)addObserverBlock:(observerBlock)block
{
    [self.observerBlocks addObject:block];
}

- (void)notifyObservers
{
    for (observerBlock block in self.observerBlocks)
        block();
}

@end
