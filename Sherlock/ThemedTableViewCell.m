//
//  ThemedTableViewCell.m
//  Sherlock
//
//  Created by Soheil Rashidi on 1/13/13.
//  Copyright (c) 2013 Radset. All rights reserved.
//

#import "ThemedTableViewCell.h"
#import "Theme.h"

@implementation ThemedTableViewCell

- (void)awakeFromNib
{
    self.backgroundColor = [Theme defaultTheme].tableItemBackgroundColor;
    self.textLabel.font = [Theme defaultTheme].tableItemFont;
    self.textLabel.textColor = [Theme defaultTheme].tableItemTextColor;
    self.detailTextLabel.font = [Theme defaultTheme].tableItemDetailFont;
    self.detailTextLabel.textColor = [Theme defaultTheme].tableItemDetailTextColor;
    self.detailTextLabel.lineBreakMode = NSLineBreakByClipping;
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
    self.selectedBackgroundView.backgroundColor = [Theme defaultTheme].tableItemBackgroundSelectedColor;
    
    if (self.accessoryType == UITableViewCellAccessoryDisclosureIndicator)
        self.accessoryView = [[UIImageView alloc] initWithImage:[Theme defaultTheme].tableItemAccessoryImage];
}

@end
