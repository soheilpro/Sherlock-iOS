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
@property (nonatomic, strong) Dropbox* dropbox;
@property (nonatomic, strong) NSMutableArray* observerBlocks;

@end

@implementation DropboxStorage

- (id)init
{
    self = [super init];
    
    if (self)
    {
        self.databases = @[];
        self.dropbox = [[Dropbox alloc] initWithSession:[DBSession sharedSession]];
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

- (void)fetchDatabasesWithCallback:(void (^) (NSArray* databases, NSError* error))callback;
{
    [self fetchRemoteDatabasesWithCallback:^(NSArray* databases, NSError* error)
    {
        NSMutableArray* mutableDatabases = [databases mutableCopy];
        
        [mutableDatabases sortUsingComparator:^NSComparisonResult(id obj1, id obj2)
         {
             Database* database1 = obj1;
             Database* database2 = obj2;
             
             return [database1.name compare:database2.name options:NSCaseInsensitiveSearch];
         }];
        
        self.databases = mutableDatabases;
        
        callback(mutableDatabases, nil);
    }];
}

- (void)fetchRemoteDatabasesWithCallback:(void (^) (NSArray* database, NSError* error))callback;
{
    NSMutableArray* databases = [NSMutableArray array];

    [self addDropboxDatabasesInPath:@"/" relativeTo:@"" toArray:databases withCallback:^(NSArray* database, NSError* error)
    {
        callback(database, error);
    }];
}

- (void)addDropboxDatabasesInPath:(NSString*)path relativeTo:(NSString*)relativePath toArray:(NSMutableArray*)databases withCallback:(void (^) (NSArray* database, NSError* error))callback;
{
    [self.dropbox loadMetadataForPath:path callback:^(DBMetadata* metadata, NSError* error)
    {
        for (DBMetadata* childMetadata in metadata.contents)
        {
            if (childMetadata.isDirectory)
            {
                [self addDropboxDatabasesInPath:[path stringByAppendingPathComponent:childMetadata.path] relativeTo:[relativePath stringByAppendingPathComponent:childMetadata.path] toArray:databases withCallback:callback];
                continue;
            }
            
            if (![[childMetadata.filename pathExtension] isEqualToString:DB_FILE_EXTENSION])
                continue;
            
            Database* database = [[Database alloc] init];
            database.storage = self;
            database.name = [[relativePath stringByAppendingPathComponent:childMetadata.filename] stringByDeletingPathExtension];
            
            [databases addObject:database];
            
            callback(databases, nil);
        }
    }];
}

- (void)readDatabase:(Database*)database callback:(void (^) (NSData* data, NSError* error))callback;
{
    [self readRemoteDatabase:database callback:callback];
}

- (void)readRemoteDatabase:(Database*)database callback:(void (^) (NSData* data, NSError* error))callback;
{
    [self.dropbox loadFileAtPath:[self pathForDatabase:database] callback:^(NSData* data, DBMetadata* metadata, NSError* error)
    {
        [database.metadata setObject:metadata.rev forKey:@"revision"];
        
        callback(data, error);
    }];
}

- (void)saveDatabase:(Database*)database withData:(NSData*)data callback:(void (^) (NSError* error))callback
{
    [self saveRemoteDatabase:database withData:data callback:^(NSError* error) {
        
        callback(error);
        
        [self notifyObservers];
    }];
}

- (void)saveRemoteDatabase:(Database*)database withData:(NSData*)data callback:(void (^) (NSError* error))callback
{
    NSString* revision = [database.metadata objectForKey:@"revision"];
    
    [self.dropbox uploadFileToPath:[self pathForDatabase:database] withData:data withRevision:revision callback:^(NSError* error)
    {
        callback(error);
    }];
}

- (void)deleteDatabase:(Database*)database callback:(void (^) (NSError* error))callback;
{
    [self deleteRemoteDatabase:database callback:^(NSError* error) {
        [self notifyObservers];
    }];
}

- (void)deleteRemoteDatabase:(Database*)database callback:(void (^) (NSError* error))callback
{
    [self.dropbox deleteFileAtPath:[self pathForDatabase:database] callback:callback];
}

- (NSString*)pathForDatabase:(Database*)database
{
    NSString* documentDirectory = @"/";
    
    return [documentDirectory stringByAppendingPathComponent:[database.name stringByAppendingPathExtension:DB_FILE_EXTENSION]];
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
