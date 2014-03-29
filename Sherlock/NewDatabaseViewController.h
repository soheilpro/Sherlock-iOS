//
//  NewDatabaseViewController.h
//  Sherlock
//
//  Created by Soheil Rashidi on 3/31/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import "Database.h"
#import "Storage.h"
#import <UIKit/UIKit.h>

@protocol NewDatabaseDelegate<NSObject>

@required
- (void)didCreateDatabase:(Database*)database;

@end

@interface NewDatabaseViewController : UITableViewController<UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) id<Storage> storage;
@property (nonatomic, weak) id<NewDatabaseDelegate> delegate;

+ (instancetype)instantiate;

@end
