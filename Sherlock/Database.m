//
//  Database.m
//  Sherlock
//
//  Created by Soheil Rashidi on 3/30/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import "Database.h"
#import "GDataXMLNode.h"
#import <CommonCrypto/CommonCryptor.h>

@implementation Database

+ (Database*)openDatabaseFromData:(NSData*)data withPassword:(NSString *)password
{
    NSData* decryptedData = [self tripleDESDecryptData:data withPassword:password];
    
    if (decryptedData == nil)
        return nil;
    
    NSError* error;
    GDataXMLDocument* document = [[GDataXMLDocument alloc] initWithData:decryptedData options:0 error:&error];
    
    if (error != nil)
        return nil;
    
    Database* database = [[Database alloc] init];
    database.root = [self categooryFromElement:document.rootElement];
    
    return database;
}

+ (CategoryNode*)categooryFromElement:(GDataXMLElement*)element
{
    CategoryNode* category = [[CategoryNode alloc] init];
    category.name = [[element attributeForName:@"name"] stringValue];
    
    for (GDataXMLElement* categoryElement in [element elementsForName:@"category"])
        [category.categories addObject:[self categooryFromElement:categoryElement]];
    
    for (GDataXMLElement* itemElement in [element elementsForName:@"item"])
        [category.items addObject:[self itemFromElement:itemElement]];
    
    id nodeComparer = ^NSComparisonResult(id obj1, id obj2)
    {
        ItemNode* item1 = (ItemNode*)obj1;
        ItemNode* item2 = (ItemNode*)obj2;
        
        return [item1.name compare:item2.name];
    };
    
    [category.categories sortUsingComparator:nodeComparer];
    [category.items sortUsingComparator:nodeComparer];

    return category;
}

+ (ItemNode*)itemFromElement:(GDataXMLElement*)element
{
    ItemNode* item = [[ItemNode alloc] init];
    item.name = [[element attributeForName:@"name"] stringValue];
    item.value = [element stringValue];
    
    return item;
}

+ (NSData*)tripleDESDecryptData:(NSData*)inputData withPassword:(NSString*)password
{
    NSData* key = [self tripleDESKeyFromPassword:password];
    NSData* iv = [self tripleDESIVFromPassword:password];
    NSMutableData* outputData = [NSMutableData dataWithLength:(inputData.length + kCCBlockSize3DES)];
    
    size_t outLength;
    CCCryptorStatus result = CCCrypt(kCCDecrypt, kCCAlgorithm3DES, kCCOptionPKCS7Padding, key.bytes, key.length, iv.bytes, inputData.bytes, inputData.length, outputData.mutableBytes, outputData.length, &outLength);
    
    if (result != kCCSuccess)
        return nil;
    
    [outputData setLength:outLength];
    
    return outputData;
}

+ (NSData*)tripleDESKeyFromPassword:(NSString*)password
{
    NSString* key = [password copy];
    int length = kCCKeySize3DES;
    
    while (key.length < length)
        key = [key stringByAppendingString:password];
    
    if (key.length > length)
        key = [key substringToIndex:length];
    
    return [key dataUsingEncoding:NSASCIIStringEncoding];
}

+ (NSData*)tripleDESIVFromPassword:(NSString*)password
{
    NSString* key = [password copy];
    int length = 8;
    
    while (key.length < length)
        key = [key stringByAppendingString:password];
    
    if (key.length > length)
        key = [key substringToIndex:length];
    
    return [key dataUsingEncoding:NSASCIIStringEncoding];
}

@end
