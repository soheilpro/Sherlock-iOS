//
//  GoogleDriveStorage.m
//  Sherlock
//
//  Created by Soheil Rashidi on 8/15/14.
//  Copyright (c) 2014 Softtool. All rights reserved.
//

#import "GoogleDrive.h"
#import "GoogleDriveStorage.h"

#define METADATA_FILE @"file"

@interface GoogleDriveStorage ()

@property (nonatomic, strong) NSArray* databases;

@end

@implementation GoogleDriveStorage

- (NSString*)name
{
    return @"Google Drive";
}

- (BOOL)isAvailable
{
    return [[GoogleDrive sharedGoogleDrive] isLinked];
}

- (NSArray*)databases
{
    return _databases;
}

- (void)fetchDatabasesWithCallback:(void (^) (NSArray* databases, NSError* error))callback
{
    NSString* query = [NSString stringWithFormat:@"fileExtension = '%@' and trashed=false", DB_FILE_EXTENSION];

    [[GoogleDrive sharedGoogleDrive] findFilesWithQuery:query callback:^(GTLDriveFileList* files, NSError* error)
    {
        if (error != nil)
        {
            callback(nil, error);
            return;
        }

        NSMutableArray* databases = [[NSMutableArray alloc] init];

        for (GTLDriveFile* file in files)
        {
            Database* database = [[Database alloc] init];
            database.name = file.title;
            database.metadata[@"file"] = file;
            database.storage = self;

            [databases addObject:database];
        }

        self.databases = databases;

        callback(self.databases, nil);
    }];
}

- (void)readDatabase:(Database*)database callback:(void (^) (NSData* data, NSError* error))callback;
{
    GTLDriveFile* file = database.metadata[METADATA_FILE];

    [[GoogleDrive sharedGoogleDrive] readFile:file callback:callback];
}

- (void)saveDatabase:(Database*)database withData:(NSData*)data callback:(void (^) (NSError* error))callback;
{
    GTLDriveFile* file = database.metadata[METADATA_FILE];

    if (file == nil)
    {
        file = [GTLDriveFile object];
        file.title = database.name;

        [[GoogleDrive sharedGoogleDrive] createFile:file data:data mimeType:DB_FILE_MIMETYPE callback:^(NSError* error)
        {
            if (error != nil)
                database.metadata[METADATA_FILE] = file;

            callback(error);
        }];
    }
    else
    {
        [[GoogleDrive sharedGoogleDrive] updateFile:file data:data mimeType:DB_FILE_MIMETYPE callback:callback];
    }
}

- (void)deleteDatabase:(Database*)database callback:(void (^) (NSError* error))callback;
{
    GTLDriveFile* file = database.metadata[METADATA_FILE];

    [[GoogleDrive sharedGoogleDrive] deleteFile:file callback:callback];
}

@end
