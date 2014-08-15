//
//  StorageWithCache.m
//  Sherlock
//
//  Created by Soheil Rashidi on 8/15/14.
//  Copyright (c) 2014 Softtool. All rights reserved.
//

#import "LocalStorage.h"
#import "StorageWithCache.h"

@interface StorageWithCache ()

@property (nonatomic, strong) NSArray* databases;
@property (nonatomic, strong) LocalStorage* cache;

@end

@implementation StorageWithCache

- (instancetype)init
{
    self = [super init];

    if (self)
    {
        self.databases = @[];
        self.cache = [[LocalStorage alloc] initWithRootDirectory:self.name];
    }

    return self;
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

    [self fetchRemoteDatabasesWithCallback:^(NSArray* databases, NSError* error)
     {
         if (error != nil)
         {
             NSError* remoteError = error;

             [self.cache fetchDatabasesWithCallback:^(NSArray* databases, NSError* error)
              {
                  if (error != nil)
                  {
                      callback(nil, remoteError);
                      return;
                  }

                  for (Database* database in databases)
                      database.isReadOnly = YES;

                  self.databases = databases;

                  callback(self.databases, nil);
              }];

             return;
         }

         self.databases = databases;

         callback(self.databases, nil);
     }];
}

- (void)fetchRemoteDatabasesWithCallback:(void (^) (NSArray* database, NSError* error))callback;
{
}

- (void)readDatabase:(Database*)database callback:(void (^) (NSData* data, NSError* error))callback;
{
    if (database.isReadOnly)
    {
        [self.cache readDatabase:database callback:callback];
        return;
    }

    [self readRemoteDatabase:database callback:^(NSData* data, NSError* error)
     {
         if (error != nil)
         {
             callback(nil, error);
             return;
         }

         [self.cache saveDatabase:database withData:data callback:^(NSError* error) {}];

         callback(data, nil);
     }];
}

- (void)readRemoteDatabase:(Database*)database callback:(void (^) (NSData* data, NSError* error))callback;
{
}

- (void)saveDatabase:(Database*)database withData:(NSData*)data callback:(void (^) (NSError* error))callback
{
    if (database.isReadOnly)
        @throw [[NSException alloc] initWithName:@"NotSupported" reason:@"Not Supported" userInfo:nil];

    [self saveRemoteDatabase:database withData:data callback:^(NSError* error)
     {
         if (error != nil)
         {
             callback(error);
             return;
         }

         [self.cache saveDatabase:database withData:data callback:^(NSError* error) {}];

         callback(nil);
     }];
}

- (void)saveRemoteDatabase:(Database*)database withData:(NSData*)data callback:(void (^) (NSError* error))callback
{
}

- (void)deleteDatabase:(Database*)database callback:(void (^) (NSError* error))callback;
{
    if (database.isReadOnly)
        @throw [[NSException alloc] initWithName:@"NotSupported" reason:@"Not Supported" userInfo:nil];

    [self deleteRemoteDatabase:database callback:^(NSError* error)
     {
         if (error != nil)
         {
             callback(error);
             return;
         }

         [self.cache deleteDatabase:database callback:^(NSError* error) {}];

         callback(nil);
     }];
}

- (void)deleteRemoteDatabase:(Database*)database callback:(void (^) (NSError* error))callback
{
}

@end
