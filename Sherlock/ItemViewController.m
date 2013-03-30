//
//  ItemViewController.m
//  Sherlock
//
//  Created by Soheil Rashidi on 3/30/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import "ItemViewController.h"

@implementation ItemViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.nameLabel.text = self.item.name;
    self.valueTextView.text = self.item.value;
}

- (void)close:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

@end
