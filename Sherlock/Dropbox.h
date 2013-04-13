//
//  Dropbox.h
//  Sherlock
//
//  Created by Soheil Rashidi on 4/5/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import <DropboxSDK/DropboxSDK.h>
#import <Foundation/Foundation.h>

typedef void (^LoadMetadataCallback)(DBMetadata* metadata, NSError* error);
typedef void (^LoadFileCallback)(NSData* data, DBMetadata* metadata, NSError* error);
typedef void (^UploadFileCallback)(DBMetadata* metadata, NSError* error);
typedef void (^DeleteFileCallback)(NSError* error);

@interface Dropbox : NSObject<DBRestClientDelegate>

- initWithSession:(DBSession*)session;
- (void)loadMetadataForPath:(NSString*)path callback:(LoadMetadataCallback)callback;
- (void)loadFileAtPath:(NSString*)path callback:(LoadFileCallback)callback;
- (void)uploadFileToPath:(NSString*)path withData:(NSData*)data withRevision:(NSString*)revision callback:(UploadFileCallback)callback;
- (void)deleteFileAtPath:(NSString*)path callback:(DeleteFileCallback)callback;

@end
