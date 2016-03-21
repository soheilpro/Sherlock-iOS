//
//  GoogleDrive.h
//  Sherlock
//
//  Created by Soheil Rashidi on 8/15/14.
//  Copyright (c) 2014 Softtool. All rights reserved.
//

#import "GTLDrive.h"
#import "GTL/GTMOAuth2ViewControllerTouch.h"
#import <Foundation/Foundation.h>

@interface GoogleDrive : NSObject

- (BOOL)isLinked;
- (void)linkWithViewController:(UIViewController*)viewController callback:(void (^)())callback;
- (void)unlink;
- (void)findFilesWithQuery:(NSString*)query callback:(void (^)(GTLDriveFileList* files, NSError* error))callback;
- (void)readFile:(GTLDriveFile*)file callback:(void (^)(NSData* data, NSError* error))callback;
- (void)createFile:(GTLDriveFile*)file data:(NSData*)data mimeType:(NSString*)mimeType callback:(void (^)(NSError* error))callback;
- (void)updateFile:(GTLDriveFile*)file data:(NSData*)data mimeType:(NSString*)mimeType callback:(void (^)(NSError* error))callback;
- (void)deleteFile:(GTLDriveFile*)file callback:(void (^)(NSError* error))callback;

+ (instancetype)sharedGoogleDrive;

@end
