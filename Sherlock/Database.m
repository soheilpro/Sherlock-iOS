//
//  Database.m
//  Sherlock
//
//  Created by Soheil Rashidi on 3/30/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import "Database.h"
#import "GDataXMLNode.h"
#import "TripleDES.h"

@implementation Database

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

- (BOOL)openWithData:(NSData*)data andPassword:(NSString*)password;
{
    if (password != nil)
        data = [TripleDES transformData:data operation:kCCDecrypt withPassword:password];
    
    NSError* error;
    GDataXMLDocument* document = [[GDataXMLDocument alloc] initWithData:data options:0 error:&error];
    
    if (error != nil)
        return NO;
    
    self.password = password;
    self.root = [self folderFromElement:document.rootElement withParent:nil inDatabase:self];
    
    return YES;
}

- (Folder*)folderFromElement:(GDataXMLElement*)element withParent:(Folder*)parent inDatabase:(Database*)database;
{
    Folder* folder = [[Folder alloc] init];
    folder.name = [[element attributeForName:@"name"] stringValue];
    folder.parent = parent;
    folder.database = database;
    
    for (GDataXMLElement* categoryElement in [element elementsForName:@"category"])
        [folder.folders addObject:[self folderFromElement:categoryElement withParent:folder inDatabase:database]];
    
    for (GDataXMLElement* itemElement in [element elementsForName:@"item"])
        [folder.items addObject:[self itemFromElement:itemElement withParent:folder inDatabase:database]];
    
    [folder.folders sortUsingComparator:[Folder sortingComparator]];
    [folder.items sortUsingComparator:[Item sortingComparator]];

    return folder;
}

- (Item*)itemFromElement:(GDataXMLElement*)element withParent:(Folder*)parent inDatabase:(Database*)database;
{
    Item* item = [[Item alloc] init];
    item.name = [[element attributeForName:@"name"] stringValue];
    item.value = [element stringValue];
    item.isSecret = [[[element attributeForName:@"type"] stringValue] isEqualToString:@"password"];
    item.parent = parent;
    item.database = database;
    
    return item;
}

- (void)save
{
    NSData* data = [self data];
    
    if (self.password != nil)
        data = [TripleDES transformData:data operation:kCCEncrypt withPassword:self.password];
    
    [self.storage saveDatabase:self withData:data];
}

- (NSData*)data
{
    GDataXMLElement* rootElement = [self rootElementFromFolder:self.root];
    GDataXMLDocument* document = [[GDataXMLDocument alloc] initWithRootElement:rootElement];
    
    return [document XMLData];
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
