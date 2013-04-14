//
//  Database+Display.m
//  Sherlock
//
//  Created by Soheil Rashidi on 4/3/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import "Database+Display.h"

@implementation Database (Display)

- (NSString*)displayName
{
    return [[self.name stringByReplacingOccurrencesOfString:@"/" withString:@" / "] stringByDeletingPathExtension];
}

@end
