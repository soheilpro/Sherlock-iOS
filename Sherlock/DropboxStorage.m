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

@end

@implementation DropboxStorage

- (id)init
{
    self = [super init];
    
    if (self)
    {
        self.files = @[];
    }
    
    return self;
}

- (NSString*)name
{
    return @"Dropbox";
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
    
    if ([DBFilesystem sharedFilesystem] == nil)
        [DBFilesystem setSharedFilesystem:[[DBFilesystem alloc] initWithAccount:account]];
    
    NSMutableArray* files = [NSMutableArray array];
    
    for (DBFileInfo* file in [[DBFilesystem sharedFilesystem] listFolder:[DBPath root] error:nil])
        if ([[[file.path stringValue] pathExtension] isEqualToString:@"sdb"])
            [files addObject:[file.path stringValue]];
    
    return files;
}

- (NSData*)readDatabaseFile:(NSString*)file
{
    DBPath* dbPath = [[DBPath alloc] initWithString:file];
    DBFile* dbFile = [[DBFilesystem sharedFilesystem] openFile:dbPath error:nil];
    
    return [dbFile readData:nil];
}

@end
