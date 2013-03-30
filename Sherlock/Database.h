//
//  Database.h
//  Sherlock
//
//  Created by Soheil Rashidi on 3/30/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Node.h"
#import "CategoryNode.h"
#import "ItemNode.h"

@interface Database : NSObject

@property (nonatomic, strong) CategoryNode* root;

+ (Database*)openDatabaseFromData:(NSData*)data withPassword:(NSString*)password;

@end
