//
//  LocalStorage.m
//  Sherlock
//
//  Created by Soheil Rashidi on 3/31/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import "LocalStorage.h"

@interface LocalStorage ()

@property (nonatomic, strong) NSArray* databases;

@end

@implementation LocalStorage

- (id)initWithRootDirectory:(NSString*)rootDirectory
{
    self = [super init];
    
    if (self)
    {
        self.rootDirectory = rootDirectory;
        self.databases = @[];
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

- (void)fetchDatabasesWithCallback:(void (^) (NSArray* databases, NSError* error))callback;
{
    if (![self isAvailable])
    {
        callback(@[], nil);
        return;
    }

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
    {
        self.databases = [self fetchDatabaseInternal];

        dispatch_async(dispatch_get_main_queue(), ^
        {
            callback(self.databases, nil);
        });
    });
}

- (NSArray*)fetchDatabaseInternal
{
    NSString* documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* localDirectory = [documentDirectory stringByAppendingPathComponent:self.rootDirectory];
    NSMutableArray* databases = [NSMutableArray array];
    
    [self addDatabasesInPath:localDirectory relativeTo:@"" toArray:databases];
    
    return [Database sortDatabases:databases];
}

- (void)addDatabasesInPath:(NSString*)path relativeTo:(NSString*)relativePath toArray:(NSMutableArray*)databases
{
    for (NSString* file in [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil])
    {
        NSDictionary* attributres = [[NSFileManager defaultManager] attributesOfItemAtPath:[path stringByAppendingPathComponent:file] error:nil];
        
        if ([attributres objectForKey:NSFileType] == NSFileTypeDirectory)
        {
            [self addDatabasesInPath:[path stringByAppendingPathComponent:file] relativeTo:[relativePath stringByAppendingPathComponent:file] toArray:databases];
        }
        else if ([[file pathExtension] isEqualToString:DB_FILE_EXTENSION])
        {
            Database* database = [[Database alloc] init];
            database.storage = self;
            database.name = [relativePath stringByAppendingPathComponent:file];
            
            [databases addObject:database];
        }
    }
}

- (void)readDatabase:(Database*)database callback:(void (^) (NSData* data, NSError* error))callback;
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
    {
        NSString* file = [self fileForDatabase:database];
        NSData* data = [NSData dataWithContentsOfFile:file];
        
        dispatch_async(dispatch_get_main_queue(), ^
        {
            callback(data, nil);
        });
    });
}

- (void)saveDatabase:(Database*)database withData:(NSData*)data callback:(void (^) (NSError* error))callback;
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
    {
        NSString* file = [self fileForDatabase:database];
        NSString* diretory = [file stringByDeletingLastPathComponent];
        
        [[NSFileManager defaultManager] createDirectoryAtPath:diretory withIntermediateDirectories:YES attributes:nil error:nil];
        [data writeToFile:file atomically:YES];
        
        dispatch_async(dispatch_get_main_queue(), ^
        {
            callback(nil);
        });
    });
}

- (void)deleteDatabase:(Database*)database callback:(void (^) (NSError* error))callback
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
    {
        NSString* file = [self fileForDatabase:database];
    
        [[NSFileManager defaultManager] removeItemAtPath:file error:nil];
    
        dispatch_async(dispatch_get_main_queue(), ^
        {
            callback(nil);
        });
    });
}

- (NSString*)fileForDatabase:(Database*)database
{
    NSString* documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* localDirectory = [documentDirectory stringByAppendingPathComponent:self.rootDirectory];
    NSString* file = [localDirectory stringByAppendingPathComponent:database.name];
    
    return file;
}

@end
