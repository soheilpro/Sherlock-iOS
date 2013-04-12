//
//  Dropbox.m
//  Sherlock
//
//  Created by Soheil Rashidi on 4/5/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import "Dropbox.h"

@interface Dropbox ()

@property (nonatomic, strong) DBRestClient* client;
@property (nonatomic, strong) DBMetadata* metadata;
@property (nonatomic, strong) NSError* metadataError;
@property (nonatomic, strong) NSData* loadFileData;
@property (nonatomic, strong) NSError* loadFileError;
@property (nonatomic) BOOL didUploadFile;
@property (nonatomic, strong) NSError* uploadFileError;
@property (nonatomic) BOOL didDeleteFile;
@property (nonatomic, strong) NSError* deleteFileError;

@end

@implementation Dropbox

- (id)initWithSession:(DBSession*)session
{
    self = [super init];
    
    if (self)
    {
        self.client = [[DBRestClient alloc] initWithSession:session];
        self.client.delegate = self;
    }
    
    return self;
}

- (DBMetadata*)loadMetadataForPath:(NSString*)path;
{
    self.metadata = nil;
    self.metadataError = nil;

    [self.client loadMetadata:path];
    
    while (self.metadata == nil && self.metadataError == nil)
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    
    return self.metadata;
}

- (void)restClient:(DBRestClient*)client loadedMetadata:(DBMetadata*)metadata
{
    self.metadata = metadata;
}

- (void)restClient:(DBRestClient*)client loadMetadataFailedWithError:(NSError*)error
{
    self.metadataError = error;
}

- (NSData*)loadFileAtPath:(NSString*)path
{
    self.loadFileData = nil;
    self.loadFileError = nil;

    NSString* tempFile = [NSTemporaryDirectory() stringByAppendingPathExtension:[[NSProcessInfo processInfo] globallyUniqueString]];
    
    [self.client loadFile:path intoPath:tempFile];
    
    while (self.loadFileData == nil && self.loadFileError == nil)
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];

    if (self.loadFileData != nil)
        [[NSFileManager defaultManager] removeItemAtPath:tempFile error:nil];

    return self.loadFileData;
}

- (void)restClient:(DBRestClient*)client loadedFile:(NSString*)destPath
{
    self.loadFileData = [NSData dataWithContentsOfFile:destPath];
}

- (void)restClient:(DBRestClient*)client loadFileFailedWithError:(NSError*)error
{
    self.loadFileError = error;
}

- (BOOL)uploadFileToPath:(NSString*)path withData:(NSData*)data withRevision:(NSString*)revision;
{
    self.didUploadFile = NO;
    self.uploadFileError = nil;

    NSString* tempFile = [NSTemporaryDirectory() stringByAppendingPathExtension:[[NSProcessInfo processInfo] globallyUniqueString]];
    [data writeToFile:tempFile atomically:YES];

    [self.client uploadFile:[path lastPathComponent] toPath:[path stringByDeletingLastPathComponent] withParentRev:revision fromPath:tempFile];
    
    while (!self.didUploadFile && self.uploadFileError == nil)
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
   
    [[NSFileManager defaultManager] removeItemAtPath:tempFile error:nil];

    return self.didUploadFile;
}

- (void)restClient:(DBRestClient*)client uploadedFile:(NSString*)destPath from:(NSString*)srcPath
{
    self.didUploadFile = YES;
}

- (void)restClient:(DBRestClient*)client uploadFileFailedWithError:(NSError*)error
{
    self.uploadFileError = error;
}

-(BOOL)deleteFileAtPath:(NSString*)path
{
    self.didDeleteFile = NO;
    self.deleteFileError = nil;
    
    [self.client deletePath:path];
    
    while (!self.didDeleteFile && self.deleteFileError == nil)
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    
    return self.didUploadFile;
}

- (void)restClient:(DBRestClient*)client deletedPath:(NSString*)path
{
    self.didDeleteFile = YES;
}

- (void)restClient:(DBRestClient*)client deletePathFailedWithError:(NSError*)error
{
    self.deleteFileError = error;
}

@end
