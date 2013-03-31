//
//  Database.m
//  Sherlock
//
//  Created by Soheil Rashidi on 3/30/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import <CommonCrypto/CommonCryptor.h>
#import "Database.h"
#import "GDataXMLNode.h"

@implementation Database

+ (Database*)openDatabaseNamed:(NSString*)name fromData:(NSData*)encryptedData withPassword:(NSString*)password;
{
    NSData* xmlData = [self tripleDESTransformData:encryptedData operation:kCCDecrypt withPassword:password];
    
    if (xmlData == nil)
        return nil;
    
    NSError* error;
    GDataXMLDocument* document = [[GDataXMLDocument alloc] initWithData:xmlData options:0 error:&error];
    
    if (error != nil)
        return nil;
    
    Database* database = [[Database alloc] init];
    database.name = name;
    database.root = [self folderFromElement:document.rootElement withParent:nil inDatabase:database];
    
    return database;
}

+ (Folder*)folderFromElement:(GDataXMLElement*)element withParent:(Folder*)parent inDatabase:(Database*)database;
{
    Folder* folder = [[Folder alloc] init];
    folder.name = [[element attributeForName:@"name"] stringValue];
    folder.parent = parent;
    folder.database = database;
    
    for (GDataXMLElement* categoryElement in [element elementsForName:@"category"])
        [folder.folders addObject:[self folderFromElement:categoryElement withParent:folder inDatabase:database]];
    
    for (GDataXMLElement* itemElement in [element elementsForName:@"item"])
        [folder.items addObject:[self itemFromElement:itemElement withParent:folder inDatabase:database]];
    
    id nodeComparer = ^NSComparisonResult(id obj1, id obj2)
    {
        Item* item1 = (Item*)obj1;
        Item* item2 = (Item*)obj2;
        
        return [item1.name compare:item2.name options:NSCaseInsensitiveSearch];
    };
    
    [folder.folders sortUsingComparator:nodeComparer];
    [folder.items sortUsingComparator:nodeComparer];

    return folder;
}

+ (Item*)itemFromElement:(GDataXMLElement*)element withParent:(Folder*)parent inDatabase:(Database*)database;
{
    Item* item = [[Item alloc] init];
    item.name = [[element attributeForName:@"name"] stringValue];
    item.value = [element stringValue];
    item.isSecret = [[[element attributeForName:@"type"] stringValue] isEqualToString:@"password"];
    item.parent = parent;
    item.database = database;
    
    return item;
}

+ (NSData*)tripleDESTransformData:(NSData*)inputData operation:(CCOperation)operation withPassword:(NSString*)password
{
    NSData* key = [self tripleDESKeyFromPassword:password];
    NSData* iv = [self tripleDESIVFromPassword:password];
    NSMutableData* outputData = [NSMutableData dataWithLength:(inputData.length + kCCBlockSize3DES)];
    
    size_t outLength;
    CCCryptorStatus result = CCCrypt(operation, kCCAlgorithm3DES, kCCOptionPKCS7Padding, key.bytes, key.length, iv.bytes, inputData.bytes, inputData.length, outputData.mutableBytes, outputData.length, &outLength);
    
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

- (id)init
{
    self = [super init];
    
    if (self)
    {
        self.root = [[Folder alloc] init];
        self.root.parent = nil;
        self.root.database = self;
    }
    
    return self;
}

- (NSData*)save
{
    GDataXMLElement* rootElement = [self rootElementFromFolder:self.root];
    GDataXMLDocument* document = [[GDataXMLDocument alloc] initWithRootElement:rootElement];
    
    NSData* xmlData = [document XMLData];
    NSData* encryptedData = [[self class] tripleDESTransformData:xmlData operation:kCCEncrypt withPassword:self.password];
    
    return encryptedData;
}

- (GDataXMLElement*)rootElementFromFolder:(Folder*)folder
{
    GDataXMLElement* element = [GDataXMLElement elementWithName:@"data"];
    
    for (Folder* subFolder in folder.folders)
        [element addChild:[self elementFromFolder:subFolder]];
    
    for (Item* item in folder.items)
        [element addChild:[self elementFromItem:item]];
    
    return element;
}

- (GDataXMLElement*)elementFromFolder:(Folder*)folder
{
    GDataXMLElement* element = [GDataXMLElement elementWithName:@"category"];
    [element addAttribute:[GDataXMLNode attributeWithName:@"name" stringValue:folder.name]];
    
    for (Folder* subFolder in folder.folders)
        [element addChild:[self elementFromFolder:subFolder]];

    for (Item* item in folder.items)
        [element addChild:[self elementFromItem:item]];

    return element;
}

- (GDataXMLElement*)elementFromItem:(Item*)item
{
    GDataXMLElement* element = [GDataXMLElement elementWithName:@"item"];
    [element addAttribute:[GDataXMLNode attributeWithName:@"name" stringValue:item.name]];
    [element addAttribute:[GDataXMLNode attributeWithName:@"type" stringValue:item.isSecret ? @"password" : @"text"]];
    [element setStringValue:item.value];
    
    return element;
}

@end
