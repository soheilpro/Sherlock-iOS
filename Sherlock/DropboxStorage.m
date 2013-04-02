//
//  DropboxStorage.m
//  Sherlock
//
//  Created by Soheil Rashidi on 3/31/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import <Dropbox/Dropbox.h>
#import "DropboxStorage.h"

#define DB_FILE_EXTENSION @"sdb"

@interface DropboxStorage ()

@property (nonatomic, strong) NSArray* databases;
@property (nonatomic, strong) NSMutableArray* observerBlocks;

@end

@implementation DropboxStorage

- (id)init
{
    self = [super init];
    
    if (self)
    {
        self.databases = @[];
        self.observerBlocks = [NSMutableArray array];
        
        [self ensureSharedFilesystem];
        
        [[DBAccountManager sharedManager] addObserver:self block:^(DBAccount* account)
        {
            [self notifyObservers];
        }];
        
        [[DBFilesystem sharedFilesystem] addObserver:self forPathAndDescendants:[DBPath root] block:^
        {
            [self notifyObservers];
        }];
    }
    
    return self;
}

- (NSString*)name
{
    return @"Dropbox";
}

- (BOOL)isAvailable
{
    DBAccount* account = [DBAccountManager sharedManager].linkedAccount;

    return account != nil;
}

- (NSArray*)databases
{
    return _databases;
}

- (void)fetchDatabases
{
    self.databases = [self fetchDatabasesInternal];
}

- (NSArray*)fetchDatabasesInternal
{
    DBAccount* account = [DBAccountManager sharedManager].linkedAccount;
    
    if (account == nil)
        return @[];

    [self ensureSharedFilesystem];

    NSMutableArray* databases = [NSMutableArray array];

    [self addDatabasesInPath:[DBPath root] toArray:databases];
    
    [databases sortUsingComparator:^NSComparisonResult(id obj1, id obj2)
    {
        Database* database1 = obj1;
        Database* database2 = obj2;
        
        return [database1.name compare:database2.name options:NSCaseInsensitiveSearch];
    }];

    return databases;
}

- (void)addDatabasesInPath:(DBPath*)path toArray:(NSMutableArray*)databases
{
    for (DBFileInfo* file in [[DBFilesystem sharedFilesystem] listFolder:path error:nil])
    {
        if (file.isFolder)
        {
            [self addDatabasesInPath:file.path toArray:databases];
        }
        else if ([[[file.path stringValue] pathExtension] isEqualToString:DB_FILE_EXTENSION])
        {
            Database* database = [[Database alloc] init];
            database.storage = self;
            database.name = [[file.path.stringValue stringByDeletingPathExtension] substringFromIndex:1];
            
            [databases addObject:database];
        }
    }
}

- (NSData*)readDatabase:(Database*)database
{
    DBPath* path = [self pathForDatabase:database];
    DBFile* file = [[DBFilesystem sharedFilesystem] openFile:path error:nil];

    return [file readData:nil];
}

- (void)saveDatabase:(Database*)database withData:(NSData*)data;
{
    DBPath* path = [self pathForDatabase:database];
    DBFile* file = [[DBFilesystem sharedFilesystem] openFile:path error:nil];
    
    if (file == nil)
        file = [[DBFilesystem sharedFilesystem] createFile:path error:nil];
    
    [file writeData:data error:nil];
}

- (void)deleteDatabase:(Database*)database
{
    DBPath* path = [self pathForDatabase:database];
    
    [[DBFilesystem sharedFilesystem] deletePath:path error:nil];
}

- (DBPath*)pathForDatabase:(Database*)database
{
    return [[DBPath root] childPath:[database.name stringByAppendingPathExtension:DB_FILE_EXTENSION]];
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

- (void)ensureSharedFilesystem
{
    DBAccount* account = [DBAccountManager sharedManager].linkedAccount;

    if (account == nil)
        return;
    
    if ([DBFilesystem sharedFilesystem] == nil)
        [DBFilesystem setSharedFilesystem:[[DBFilesystem alloc] initWithAccount:account]];
}

@end
