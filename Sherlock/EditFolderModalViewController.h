//
//  EditFolderModalViewController.h
//  Sherlock
//
//  Created by Soheil Rashidi on 3/29/14.
//  Copyright (c) 2014 Softtool. All rights reserved.
//

#import "Database.h"
#import "EditFolderViewController.h"
#import <UIKit/UIKit.h>

@interface EditFolderModalViewController : UINavigationController

@property (nonatomic, strong) Folder* folder;
@property (nonatomic, weak) id<EditFolderDelegate> editFolderDelegate;

+ (instancetype)instantiate;

@end
