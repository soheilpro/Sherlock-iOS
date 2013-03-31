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

@interface Database : NSObject

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* password;
@property (nonatomic, strong) Folder* root;

+ (Database*)openDatabaseNamed:(NSString*)name fromData:(NSData*)encryptedData withPassword:(NSString*)password;

- (NSData*)save;

@end
