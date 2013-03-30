//
//  ItemViewController.h
//  Sherlock
//
//  Created by Soheil Rashidi on 3/30/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemNode.h"

@interface ItemViewController : UIViewController

@property (nonatomic, strong) ItemNode* item;
@property (nonatomic, strong) IBOutlet UILabel* nameLabel;
@property (nonatomic, strong) IBOutlet UITextView* valueTextView;

- (IBAction)close:(id)sender;

@end
