//
//  NewItemViewController.h
//  Sherlock
//
//  Created by Soheil Rashidi on 4/2/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import "Database.h"
#import <UIKit/UIKit.h>

@protocol EditItemDelegate<NSObject>

@required
- (void)didUpdateItem:(Item*)item;

@end

@interface EditItemViewController : UITableViewController<UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, strong) Item* item;
@property (nonatomic, weak) id<EditItemDelegate> delegate;

+ (instancetype)instantiate;

@end
