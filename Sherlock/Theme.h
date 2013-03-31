//
//  Theme.h
//  Sherlock
//
//  Created by Soheil Rashidi on 10/10/12.
//  Copyright (c) 2012 Radset. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Theme : NSObject

+ (Theme*)defaultTheme;

@property (nonatomic, strong) NSString* textFontName;
@property (nonatomic, strong) NSString* textFontNameBold;
@property (nonatomic) NSInteger textFontSize;
@property (nonatomic, strong) UIFont* textFont;
@property (nonatomic, strong) UIFont* textFontBold;

@property (nonatomic, strong) NSString* headerTextFontName;
@property (nonatomic) NSInteger headerTextFontSize;
@property (nonatomic, strong) UIFont* headerTextFont;

@property (nonatomic, strong) NSString* menuItemFontName;
@property (nonatomic) NSInteger menuItemFontSize;

@property (nonatomic, strong) UIImage* buttonDarkBackgroundImage;
@property (nonatomic, strong) UIColor* buttonDarkTextColor;
@property (nonatomic, strong) UIFont* buttonFont;

@property (nonatomic, strong) UIColor* textFieldBackgroundColor;
@property (nonatomic, strong) UIColor* textFieldBorderColor;
@property (nonatomic, strong) UIFont* textFieldFont;

@property (nonatomic, strong) UIColor* viewBackgroundColor;

@property (nonatomic, strong) UIColor* menuBackgroundColor;
@property (nonatomic, strong) UIColor* menuItemBackgroundColor;
@property (nonatomic, strong) UIColor* menuItemBackgroundSelectedColor;
@property (nonatomic, strong) UIColor* menuItemTextColor;
@property (nonatomic, strong) UIFont* menuItemFont;
@property (nonatomic, strong) UIImage* menuItemAccessoryImage;
@property (nonatomic, strong) UIColor* menuSeparatorColor;
@property (nonatomic, strong) UIImage* menuLogo;

@property (nonatomic, strong) UIColor* tableBackgroundColor;
@property (nonatomic, strong) UIColor* tableItemBackgroundColor;
@property (nonatomic, strong) UIColor* tableItemBackgroundSelectedColor;
@property (nonatomic, strong) UIColor* tableItemTextColor;
@property (nonatomic, strong) UIColor* tableItemDetailTextColor;
@property (nonatomic, strong) UIFont* tableItemFont;
@property (nonatomic, strong) UIFont* tableItemDetailFont;
@property (nonatomic, strong) UIImage* tableItemAccessoryImage;
@property (nonatomic, strong) UIColor* tableSeparatorColor;

@property (nonatomic, strong) UIColor* navigationBarColor;
@property (nonatomic, strong) UIColor* navigationBarTitleTextColor;
@property (nonatomic, strong) UIColor* navigationBarTitleTextShadowColor;
@property (nonatomic) UIOffset navigationBarTitleTextShadowOffset;
@property (nonatomic, strong) UIFont* navigationBarTitleFont;

@property (nonatomic, strong) UIImage* barButtonItemBackgroundImage;
@property (nonatomic, strong) UIImage* barButtonItemBackButtonBackgroundImage;
@property (nonatomic, strong) UIImage* barButtonItemMenuButtonBackgroundImage;
@property (nonatomic, strong) UIColor* barButtonItemTitleTextColor;
@property (nonatomic, strong) UIColor* barButtonItemTitleTextShadowColor;
@property (nonatomic) UIOffset barButtonItemTitleTextShadowOffset;
@property (nonatomic, strong) UIFont* barButtonItemTitleFont;

- (void)apply;
- (UIFont*)textFontOfSizePlus:(NSInteger)size;
- (UIFont*)textFontBoldOfSizePlus:(NSInteger)size;

@end
