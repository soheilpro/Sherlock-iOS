//
//  FolderCell.m
//  Sherlock
//
//  Created by Soheil Rashidi on 3/29/14.
//  Copyright (c) 2014 Softtool. All rights reserved.
//

#import "FolderCell.h"

@implementation FolderCell

#pragma mark - Methods

- (void)setFolder:(Folder*)folder
{
    _folder = folder;

    self.textLabel.text = folder.name;
}

@end
