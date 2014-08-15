//
//  GoogleDrive.m
//  Sherlock
//
//  Created by Soheil Rashidi on 8/15/14.
//  Copyright (c) 2014 Softtool. All rights reserved.
//

#import "GoogleDrive.h"

@interface GoogleDrive ()

@property (nonatomic, retain) GTLServiceDrive* service;

@end

@implementation GoogleDrive

NSString *const kKeychainItemName = @"GoogleDrive";
NSString *const kClientID = @"YOUR_CLINET_ID";
NSString *const kClientSecret = @"YOUR_CLIENT_SECRET";

#pragma mark - Init

- (instancetype)init
{
    self = [super init];

    if (self)
    {
        self.service = [[GTLServiceDrive alloc] init];
        self.service.authorizer = [GTMOAuth2ViewControllerTouch authForGoogleFromKeychainForName:kKeychainItemName clientID:kClientID clientSecret:kClientSecret];
    }

    return self;
}

#pragma mark - Methods

- (BOOL)isLinked
{
    return [((GTMOAuth2Authentication*)self.service.authorizer) canAuthorize];
}

- (void)linkWithViewController:(UIViewController*)viewController callback:(void (^)())callback
{
    GTMOAuth2ViewControllerTouch* authController = [[GTMOAuth2ViewControllerTouch alloc] initWithScope:kGTLAuthScopeDrive clientID:kClientID clientSecret:kClientSecret keychainItemName:kKeychainItemName delegate:self finishedSelector:@selector(viewController:finishedWithAuth:error:)];
    authController.navigationItem.title = @"Log In";
    authController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:viewController action:@selector(dismissModalViewControllerAnimated:)];

    UINavigationController* navigationController = [[UINavigationController alloc] init];
    navigationController.viewControllers = @[authController];

    [viewController presentModalViewController:navigationController animated:YES];

    authController.popViewBlock = ^
    {
        [viewController dismissModalViewControllerAnimated:YES];

        callback();
    };
}

- (void)unlink
{
    // TODO
}

- (void)findFilesWithQuery:(NSString*)q callback:(void (^)(GTLDriveFileList* files, NSError* error))callback;
{
    GTLQueryDrive *query = [GTLQueryDrive queryForFilesList];
    query.q = q;
    query.maxResults = NSIntegerMax;

    [self.service executeQuery:query completionHandler:^(GTLServiceTicket* ticket, GTLDriveFileList* files, NSError* error)
    {
        callback(files, error);
    }];
}

- (void)readFile:(GTLDriveFile*)file callback:(void (^)(NSData* data, NSError* error))callback
{
    GTMHTTPFetcher *fetcher = [self.service.fetcherService fetcherWithURLString:file.downloadUrl];

    [fetcher beginFetchWithCompletionHandler:callback];
}

- (void)createFile:(GTLDriveFile*)file data:(NSData*)data mimeType:(NSString*)mimeType callback:(void (^)(NSError* error))callback;
{
    GTLUploadParameters* uploadParameters = [GTLUploadParameters uploadParametersWithData:data MIMEType:mimeType];

    GTLQueryDrive* query = [GTLQueryDrive queryForFilesInsertWithObject:file uploadParameters:uploadParameters];
    [self.service executeQuery:query completionHandler:^(GTLServiceTicket* ticket, GTLDriveFile* updatedFile, NSError* error)
    {
        callback(error);
    }];
}

- (void)updateFile:(GTLDriveFile*)file data:(NSData*)data mimeType:(NSString*)mimeType callback:(void (^)(NSError* error))callback;
{
    GTLUploadParameters* uploadParameters = [GTLUploadParameters uploadParametersWithData:data MIMEType:mimeType];

    GTLQueryDrive* query = [GTLQueryDrive queryForFilesUpdateWithObject:file fileId:file.identifier uploadParameters:uploadParameters];
    [self.service executeQuery:query completionHandler:^(GTLServiceTicket* ticket, GTLDriveFile* updatedFile, NSError* error)
    {
        callback(error);
    }];
}

- (void)deleteFile:(GTLDriveFile*)file callback:(void (^)(NSError* error))callback
{
    GTLQueryDrive* query = [GTLQueryDrive queryForFilesDeleteWithFileId:file.identifier];

    [self.service executeQuery:query completionHandler:^(GTLServiceTicket* ticket, id object, NSError* error)
    {
        callback(error);
    }];
}

#pragma mark -

- (void)viewController:(GTMOAuth2ViewControllerTouch*)viewController finishedWithAuth:(GTMOAuth2Authentication*)authResult error:(NSError*)error
{
    if (error != nil)
    {
        return;
    }

    [GoogleDrive sharedGoogleDrive].service.authorizer = authResult;
}

#pragma mark - Class methods

+ (instancetype)sharedGoogleDrive
{
    static GoogleDrive* instance;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^
    {
        instance = [[self alloc] init];
    });

    return instance;
}

@end
