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

#define DB_ROOT_DIRECTORY @"/Apps/Sherlock/"
#define CACHE_ROOT_DIRECTORY @"Dropbox"
#define DB_FILE_EXTENSION @"sdb"
#define METADATA_REVISION_KEY @"revision"

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
        if (error != nil)
        {
            callback(nil, error);
            return;
        }
        
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

    [self addDropboxDatabasesInPath:DB_ROOT_DIRECTORY basePath:DB_ROOT_DIRECTORY toArray:databases withCallback:^(NSArray* database, NSError* error)
    {
        if (error != nil)
        {
            callback(nil, error);
            return;
        }

        callback(database, error);
    }];
}

- (void)addDropboxDatabasesInPath:(NSString*)path basePath:(NSString*)basePath toArray:(NSMutableArray*)databases withCallback:(void (^) (NSArray* database, NSError* error))callback;
{
    [self.dropbox loadMetadataForPath:path callback:^(DBMetadata* metadata, NSError* error)
    {
        __block NSInteger remainingCallbacksToReturn = 0;
        
        for (DBMetadata* childMetadata in metadata.contents)
        {
            if (childMetadata.isDirectory)
            {
                remainingCallbacksToReturn++;
                
                [self addDropboxDatabasesInPath:childMetadata.path basePath:basePath toArray:databases withCallback:^(NSArray* database, NSError* error)
                {
                    remainingCallbacksToReturn--;
                    
                    if (remainingCallbacksToReturn == 0)
                        callback(database, nil);
                }];
                
                continue;
            }
            
            if (![[childMetadata.filename pathExtension] isEqualToString:DB_FILE_EXTENSION])
                continue;
            
            Database* database = [[Database alloc] init];
            database.storage = self;
            database.name = [childMetadata.path stringByReplacingCharactersInRange:NSMakeRange(0, [basePath length]) withString:@""];
            
            [databases addObject:database];
        }

        if (remainingCallbacksToReturn == 0)
            callback(databases, nil);
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
        if (error != nil)
        {
            callback(nil, error);
            return;
        }

        [database.metadata setObject:metadata.rev forKey:METADATA_REVISION_KEY];
        
        callback(data, error);
    }];
}

- (void)saveDatabase:(Database*)database withData:(NSData*)data callback:(void (^) (NSError* error))callback
{
    [self saveRemoteDatabase:database withData:data callback:callback];
}

- (void)saveRemoteDatabase:(Database*)database withData:(NSData*)data callback:(void (^) (NSError* error))callback
{
    NSString* revision = [database.metadata objectForKey:METADATA_REVISION_KEY];
    
    [self.dropbox uploadFileToPath:[self pathForDatabase:database] withData:data withRevision:revision callback:^(DBMetadata* metadata, NSError* error)
    {
        if (error != nil)
        {
            callback(error);
            return;
        }
        
        [database.metadata setObject:metadata.rev forKey:METADATA_REVISION_KEY];
        
        callback(nil);
    }];
}

- (void)deleteDatabase:(Database*)database callback:(void (^) (NSError* error))callback;
{
    [self deleteRemoteDatabase:database callback:callback];
}

- (void)deleteRemoteDatabase:(Database*)database callback:(void (^) (NSError* error))callback
{
    [self.dropbox deleteFileAtPath:[self pathForDatabase:database] callback:callback];
}

- (NSString*)pathForDatabase:(Database*)database
{
    return [DB_ROOT_DIRECTORY stringByAppendingPathComponent:database.name];
}

@end
