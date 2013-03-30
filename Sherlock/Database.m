//
//  Database.m
//  Sherlock
//
//  Created by Soheil Rashidi on 3/30/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import "Database.h"
#import "GDataXMLNode.h"

@implementation Database

+ (Database*)openDatabaseFromFile:(NSString*)file;
{
    NSData* data = [NSData dataWithContentsOfFile:file];
    GDataXMLDocument* document = [[GDataXMLDocument alloc] initWithData:data options:0 error:nil]; // TODO
    
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

@end
