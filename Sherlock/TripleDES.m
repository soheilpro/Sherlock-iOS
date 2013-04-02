//
//  TripleDES.m
//  Sherlock
//
//  Created by Soheil Rashidi on 4/3/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import "TripleDES.h"

@implementation TripleDES

+ (NSData*)transformData:(NSData*)inputData operation:(CCOperation)operation withPassword:(NSString*)password
{
    NSData* key = [self keyFromPassword:password];
    NSData* iv = [self ivFromPassword:password];
    NSMutableData* outputData = [NSMutableData dataWithLength:(inputData.length + kCCBlockSize3DES)];
    
    size_t outLength;
    CCCryptorStatus result = CCCrypt(operation, kCCAlgorithm3DES, kCCOptionPKCS7Padding, key.bytes, key.length, iv.bytes, inputData.bytes, inputData.length, outputData.mutableBytes, outputData.length, &outLength);
    
    if (result != kCCSuccess)
        return nil;
    
    [outputData setLength:outLength];
    
    return outputData;
}

+ (NSData*)keyFromPassword:(NSString*)password
{
    NSString* key = [password copy];
    int length = kCCKeySize3DES;
    
    while (key.length < length)
        key = [key stringByAppendingString:password];
    
    if (key.length > length)
        key = [key substringToIndex:length];
    
    return [key dataUsingEncoding:NSUTF8StringEncoding];
}

+ (NSData*)ivFromPassword:(NSString*)password
{
    NSString* key = [password copy];
    int length = 8;
    
    while (key.length < length)
        key = [key stringByAppendingString:password];
    
    if (key.length > length)
        key = [key substringToIndex:length];
    
    return [key dataUsingEncoding:NSUTF8StringEncoding];
}

@end
