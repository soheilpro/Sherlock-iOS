//
//  Dropbox.h
//  Sherlock
//
//  Created by Soheil Rashidi on 4/5/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import <DropboxSDK/DropboxSDK.h>
#import <Foundation/Foundation.h>

@interface Dropbox : NSObject<DBRestClientDelegate>

- initWithSession:(DBSession*)session;
- (DBMetadata*)loadMetadataForPath:(NSString*)path;
- (NSData*)loadFileAtPath:(NSString*)path;
- (BOOL)uploadFileToPath:(NSString*)path withData:(NSData*)data withRevision:(NSString*)revision;
- (BOOL)deleteFileAtPath:(NSString*)path;

@end
