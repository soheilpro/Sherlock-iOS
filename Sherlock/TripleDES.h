//
//  TripleDES.h
//  Sherlock
//
//  Created by Soheil Rashidi on 4/3/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>

@interface TripleDES : NSObject

+ (NSData*)transformData:(NSData*)inputData operation:(CCOperation)operation withPassword:(NSString*)password;

@end
