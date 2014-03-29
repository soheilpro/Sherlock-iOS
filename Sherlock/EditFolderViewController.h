//
//  NewFolderViewController.h
//  Sherlock
//
//  Created by Soheil Rashidi on 4/1/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import "Database.h"
#import <UIKit/UIKit.h>

@protocol EditFolderDelegate<NSObject>

@required
- (void)didUpdateFolder:(Folder*)folder;

@end

@interface EditFolderViewController : UITableViewController<UITextFieldDelegate>

@property (nonatomic, strong) Folder* folder;
@property (nonatomic, weak) id<EditFolderDelegate> delegate;

+ (instancetype)instantiate;

@end
