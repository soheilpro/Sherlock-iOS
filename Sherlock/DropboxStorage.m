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
#define METADATA_REVISION_KEY @"revision"

@interface DropboxStorage ()

@property (nonatomic, strong) Dropbox* dropbox;

@end

@implementation DropboxStorage

- (id)init
{
    self = [super init];
    
    if (self)
    {
        self.dropbox = [[Dropbox alloc] initWithSession:[DBSession sharedSession]];
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

        callback([Database sortDatabases:database], nil);
    }];
}

- (void)addDropboxDatabasesInPath:(NSString*)path basePath:(NSString*)basePath toArray:(NSMutableArray*)databases withCallback:(void (^) (NSArray* database, NSError* error))callback;
{
    [self.dropbox loadMetadataForPath:path callback:^(DBMetadata* metadata, NSError* error)
    {
        if (error != nil)
        {
            callback(nil, error);
            return;
        }
        
        __block NSInteger remainingChildrenToReturn = 0;
        __block NSError* lastError = nil;
        
        for (DBMetadata* childMetadata in metadata.contents)
        {
            if (childMetadata.isDirectory)
            {
                remainingChildrenToReturn++;
                
                [self addDropboxDatabasesInPath:childMetadata.path basePath:basePath toArray:databases withCallback:^(NSArray* database, NSError* error)
                {
                    remainingChildrenToReturn--;
                    lastError = error;
                    
                    if (remainingChildrenToReturn == 0)
                        callback(database, lastError);
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

        if (remainingChildrenToReturn == 0)
            callback(databases, nil);
    }];
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

        database.metadata[METADATA_REVISION_KEY] = metadata.rev;
        
        callback(data, error);
    }];
}

- (void)saveRemoteDatabase:(Database*)database withData:(NSData*)data callback:(void (^) (NSError* error))callback
{
    NSString* revision = database.metadata[METADATA_REVISION_KEY];
    
    [self.dropbox uploadFileToPath:[self pathForDatabase:database] withData:data withRevision:revision callback:^(DBMetadata* metadata, NSError* error)
    {
        if (error != nil)
        {
            callback(error);
            return;
        }
        
        database.metadata[METADATA_REVISION_KEY] = metadata.rev;
        
        callback(nil);
    }];
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
