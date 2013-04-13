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
@property (nonatomic, strong) LoadMetadataCallback loadMetadataCallback;
@property (nonatomic, strong) LoadFileCallback loadFileCallback;
@property (nonatomic, strong) UploadFileCallback uploadFileCallback;
@property (nonatomic, strong) DeleteFileCallback deleteFileCallback;

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

- (void)loadMetadataForPath:(NSString*)path callback:(LoadMetadataCallback)callback;
{
    self.loadMetadataCallback = callback;
    
    [self.client loadMetadata:path];
}

- (void)restClient:(DBRestClient*)client loadedMetadata:(DBMetadata*)metadata
{
    self.loadMetadataCallback(metadata, nil);
}

- (void)restClient:(DBRestClient*)client loadMetadataFailedWithError:(NSError*)error
{
    self.loadMetadataCallback(nil, error);
}

- (void)loadFileAtPath:(NSString*)path callback:(LoadFileCallback)callback;
{
    self.loadFileCallback = callback;

    NSString* tempFile = [NSTemporaryDirectory() stringByAppendingPathComponent:[[NSProcessInfo processInfo] globallyUniqueString]];
    
    [self.client loadFile:path intoPath:tempFile];
}

-(void)restClient:(DBRestClient*)client loadedFile:(NSString*)destPath contentType:(NSString*)contentType metadata:(DBMetadata*)metadata
{
    NSData* data = [NSData dataWithContentsOfFile:destPath];

    [[NSFileManager defaultManager] removeItemAtPath:destPath error:nil];
    
    self.loadFileCallback(data, metadata, nil);
}

- (void)restClient:(DBRestClient*)client loadFileFailedWithError:(NSError*)error
{
    self.loadFileCallback(nil, nil, error);
}

- (void)uploadFileToPath:(NSString*)path withData:(NSData*)data withRevision:(NSString*)revision callback:(UploadFileCallback)callback
{
    self.uploadFileCallback = callback;
    
    NSString* tempFile = [NSTemporaryDirectory() stringByAppendingPathComponent:[[NSProcessInfo processInfo] globallyUniqueString]];
    [data writeToFile:tempFile atomically:YES];

    [self.client uploadFile:[path lastPathComponent] toPath:[path stringByDeletingLastPathComponent] withParentRev:revision fromPath:tempFile];
}

- (void)restClient:(DBRestClient*)client uploadedFile:(NSString*)destPath from:(NSString*)srcPath metadata:(DBMetadata*)metadata
{
    [[NSFileManager defaultManager] removeItemAtPath:srcPath error:nil];
    
    self.uploadFileCallback(metadata, nil);
}

- (void)restClient:(DBRestClient*)client uploadFileFailedWithError:(NSError*)error
{
    self.uploadFileCallback(nil, error);
}

- (void)deleteFileAtPath:(NSString*)path callback:(DeleteFileCallback)callback;
{
    self.deleteFileCallback = callback;
    
    [self.client deletePath:path];
}

- (void)restClient:(DBRestClient*)client deletedPath:(NSString*)path
{
    self.deleteFileCallback(nil);
}

- (void)restClient:(DBRestClient*)client deletePathFailedWithError:(NSError*)error
{
    self.deleteFileCallback(error);
}

@end
