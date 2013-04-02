//
//  ItemViewController.h
//  Sherlock
//
//  Created by Soheil Rashidi on 3/30/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Database.h"

@interface ItemViewController : UIViewController

@property (nonatomic, strong) Item* item;
@property (nonatomic, weak) IBOutlet UILabel* nameLabel;
@property (nonatomic, weak) IBOutlet UITextView* valueTextView;

- (IBAction)close:(id)sender;

@end
