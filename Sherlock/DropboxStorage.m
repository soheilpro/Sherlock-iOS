//
//  DropboxStorage.m
//  Sherlock
//
//  Created by Soheil Rashidi on 3/31/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import <Dropbox/Dropbox.h>
#import "DropboxStorage.h"

@interface DropboxStorage ()

@property (nonatomic, strong) NSArray* files;
@property (nonatomic, strong) NSMutableArray* observerBlocks;

@end

@implementation DropboxStorage

- (id)init
{
    self = [super init];
    
    if (self)
    {
        self.files = @[];
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
    DBAccount* account = [DBAccountManager sharedManager].linkedAccount;
    
    if (account == nil)
        return @[];
    
    [self ensureSharedFilesystem];
    
    NSMutableArray* files = [NSMutableArray array];
    
    for (DBFileInfo* file in [[DBFilesystem sharedFilesystem] listFolder:[DBPath root] error:nil])
        if ([[[file.path stringValue] pathExtension] isEqualToString:@"sdb"])
            [files addObject:[file.path stringValue]];
    
    [files sortUsingComparator:^NSComparisonResult(id obj1, id obj2)
    {
        NSString* file1 = obj1;
        NSString* file2 = obj2;
        
        return [file1 compare:file2 options:NSCaseInsensitiveSearch];
    }];

    return files;
}

- (NSData*)readDatabaseFile:(NSString*)file
{
    DBPath* dbPath = [[DBPath alloc] initWithString:file];
    DBFile* dbFile = [[DBFilesystem sharedFilesystem] openFile:dbPath error:nil];
    
    return [dbFile readData:nil];
}

- (void)saveDatabaseData:(NSData*)data withName:(NSString*)name;
{
    DBPath* dbPath = [[DBPath root] childPath:[name stringByAppendingPathExtension:@"sdb"]];
    DBFile* dbFile;
    
    DBFilesystem* filesystem = [DBFilesystem sharedFilesystem];
    dbFile = [filesystem openFile:dbPath error:nil];
    
    if (dbFile == nil)
        dbFile = [filesystem createFile:dbPath error:nil];
    
    [dbFile writeData:data error:nil];
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
