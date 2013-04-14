//
//  Database.h
//  Sherlock
//
//  Created by Soheil Rashidi on 3/30/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Node.h"
#import "Folder.h"
#import "Item.h"
#import "Storage.h"

@interface Database : NSObject

@property (nonatomic, strong) id storage;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* password;
@property (nonatomic) BOOL isReadOnly;
@property (nonatomic, strong) NSMutableDictionary* metadata;
@property (nonatomic, strong) Folder* root;

- (BOOL)openWithData:(NSData*)data andPassword:(NSString*)password;
- (void)saveWithCallback:(void(^)(NSError* error))callback;

@end
