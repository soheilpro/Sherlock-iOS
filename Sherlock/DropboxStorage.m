//
//  DropboxStorage.m
//  Sherlock
//
//  Created by Soheil Rashidi on 3/31/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import <DropboxSDK/DropboxSDK.h>
#import "DropboxStorage.h"
#import "Dropbox.h"

#define DB_ROOT_DIRECTORY @"Dropbox"
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
    }
    
    return self;
}

- (NSString*)name
{
    return @"Dropbox";
}

- (BOOL)isAvailable
{
    return [DBSession sharedSession].isLinked;
}

- (NSArray*)databases
{
    return _databases;
}

- (void)fetchDatabases
{
    NSMutableArray* databases = [[self fetchRemoteDatabases] mutableCopy];
    
    [databases sortUsingComparator:^NSComparisonResult(id obj1, id obj2)
    {
        Database* database1 = obj1;
        Database* database2 = obj2;
        
        return [database1.name compare:database2.name options:NSCaseInsensitiveSearch];
    }];

    self.databases = databases;
}

- (NSArray*)fetchRemoteDatabases
{
    NSMutableArray* databases = [NSMutableArray array];

    [self addDropboxDatabasesInPath:@"/" relativeTo:@"" toArray:databases];
    
    return databases;
}

- (void)addDropboxDatabasesInPath:(NSString*)path relativeTo:(NSString*)relativePath toArray:(NSMutableArray*)databases
{
    Dropbox* dropbox = [[Dropbox alloc] initWithSession:[DBSession sharedSession]];
    DBMetadata* rootMetadata = [dropbox loadMetadataForPath:path];

    for (DBMetadata* childMetadata in rootMetadata.contents)
    {
        if (childMetadata.isDirectory)
        {
            [self addDropboxDatabasesInPath:[path stringByAppendingPathComponent:childMetadata.path] relativeTo:[relativePath stringByAppendingPathComponent:childMetadata.path] toArray:databases];
            continue;
        }
        
        if (![[childMetadata.filename pathExtension] isEqualToString:DB_FILE_EXTENSION])
            continue;
        
        Database* database = [[Database alloc] init];
        database.storage = self;
        database.name = [[relativePath stringByAppendingPathComponent:childMetadata.filename] stringByDeletingPathExtension];
        
        [databases addObject:database];
    }
}

- (NSArray*)fetchLocalDatabases
{
    NSString* documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* localDirectory = [documentDirectory stringByAppendingPathComponent:DB_ROOT_DIRECTORY];
    NSMutableArray* databases = [NSMutableArray array];
    
    [self addCachedDatabasesInPath:localDirectory relativeTo:@"" toArray:databases];
    
    return databases;
}

- (void)addCachedDatabasesInPath:(NSString*)path relativeTo:(NSString*)relativePath toArray:(NSMutableArray*)databases
{
    for (NSString* file in [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil])
    {
        NSDictionary* attributres = [[NSFileManager defaultManager] attributesOfItemAtPath:[path stringByAppendingPathComponent:file] error:nil];
        
        if ([attributres objectForKey:NSFileType] == NSFileTypeDirectory)
        {
            [self addCachedDatabasesInPath:[path stringByAppendingPathComponent:file] relativeTo:[relativePath stringByAppendingPathComponent:file] toArray:databases];
        }
        else if ([[file pathExtension] isEqualToString:DB_FILE_EXTENSION])
        {
            Database* database = [[Database alloc] init];
            database.storage = self;
            database.name = [[relativePath stringByAppendingPathComponent:file] stringByDeletingPathExtension];
            
            [databases addObject:database];
        }
    }
}

- (NSData*)readDatabase:(Database*)database
{
    return [self readRemoteDatabase:database];
}

- (NSData*)readRemoteDatabase:(Database*)database
{
    Dropbox* dropbox = [[Dropbox alloc] initWithSession:[DBSession sharedSession]];
    
    return [dropbox loadFileAtPath:[self pathForDatabase:database]];
}

- (NSData*)readCachedDatabase:(Database*)database
{
    NSString* file = [self fileForDatabase:database];
    
    return [NSData dataWithContentsOfFile:file];
}

- (void)saveDatabase:(Database*)database withData:(NSData*)data;
{
    [self saveRemoteDatabase:database withData:data];
    
    [self notifyObservers];
}

- (BOOL)saveRemoteDatabase:(Database*)database withData:(NSData*)data
{
    Dropbox* dropbox = [[Dropbox alloc] initWithSession:[DBSession sharedSession]];
    
    return [dropbox uploadFileToPath:[self pathForDatabase:database] withData:data withRevision:nil];
}

- (BOOL)saveCachedDatabase:(Database*)database withData:(NSData*)data
{
    NSString* file = [self fileForDatabase:database];
    NSString* diretory = [file stringByDeletingLastPathComponent];
    
    [[NSFileManager defaultManager] createDirectoryAtPath:diretory withIntermediateDirectories:YES attributes:nil error:nil];
    [data writeToFile:file atomically:YES];
    
    return YES;
}

- (void)deleteDatabase:(Database*)database
{
    [self deleteRemoteDatabase:database];
    [self deleteCachedDatabase:database];
    
    [self notifyObservers];
}

- (void)deleteRemoteDatabase:(Database*)database
{
    Dropbox* dropbox = [[Dropbox alloc] initWithSession:[DBSession sharedSession]];
    
    [dropbox deleteFileAtPath:[self pathForDatabase:database]];
}

- (void)deleteCachedDatabase:(Database*)database
{
    NSString* file = [self fileForDatabase:database];
    
    [[NSFileManager defaultManager] removeItemAtPath:file error:nil];
    
}

- (NSString*)pathForDatabase:(Database*)database
{
    NSString* documentDirectory = @"/";
    
    return [documentDirectory stringByAppendingPathComponent:[database.name stringByAppendingPathExtension:DB_FILE_EXTENSION]];
}

- (NSString*)fileForDatabase:(Database*)database
{
    NSString* documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* localDirectory = [documentDirectory stringByAppendingPathComponent:DB_ROOT_DIRECTORY];
    NSString* file = [[localDirectory stringByAppendingPathComponent:database.name] stringByAppendingPathExtension:DB_FILE_EXTENSION];
    
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
