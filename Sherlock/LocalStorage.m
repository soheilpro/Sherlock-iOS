//
//  LocalStorage.m
//  Sherlock
//
//  Created by Soheil Rashidi on 3/31/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import "LocalStorage.h"

#define DB_FILE_EXTENSION @"sdb"

@interface LocalStorage ()

@property (nonatomic, strong) NSArray* databases;
@property (nonatomic, strong) NSMutableArray* observerBlocks;

@end

@implementation LocalStorage

- (id)init
{
    self = [super init];
    
    if (self)
    {
        self.databases = @[];
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

- (NSArray*)databases
{
    return _databases;
}

- (void)fetchDatabases
{
    self.databases = [self fetchDatabaseInternal];
}

- (NSArray*)fetchDatabaseInternal
{
    NSMutableArray* databases = [NSMutableArray array];
    NSString* documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    for (NSString* file in [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentDirectory error:nil])
    {
        if ([[file pathExtension] isEqualToString:DB_FILE_EXTENSION])
        {
            Database* database = [[Database alloc] init];
            database.storage = self;
            database.name = [file stringByDeletingPathExtension];
            
            [databases addObject:database];
        }
    }
    
    [databases sortUsingComparator:^NSComparisonResult(id obj1, id obj2)
    {
        Database* database1 = obj1;
        Database* database2 = obj2;
    
        return [database1.name compare:database2.name options:NSCaseInsensitiveSearch];
    }];
    
    return databases;
}

- (NSData*)readDatabase:(Database*)database
{
    NSString* file = [self fileForDatabase:database];
    
    return [NSData dataWithContentsOfFile:file];
}

- (void)saveDatabase:(Database*)database withData:(NSData*)data;
{
    NSString* file = [self fileForDatabase:database];
    
    [data writeToFile:file atomically:YES];
    
    [self notifyObservers];
}

- (void)deleteDatabase:(Database*)database
{
    NSString* file = [self fileForDatabase:database];
    
    [[NSFileManager defaultManager] removeItemAtPath:file error:nil];
    
    [self notifyObservers];
}

- (NSString*)fileForDatabase:(Database*)database
{
    NSString* documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* file = [[documentDirectory stringByAppendingPathComponent:database.name] stringByAppendingPathExtension:DB_FILE_EXTENSION];
    
    return file;
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
