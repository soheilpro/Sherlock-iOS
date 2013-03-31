//
//  Theme.m
//  Sherlock
//
//  Created by Soheil Rashidi on 10/10/12.
//  Copyright (c) 2012 Radset. All rights reserved.
//

#import "Theme.h"

#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@implementation Theme

+ (Theme*)defaultTheme
{
    static Theme* instance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^
    {
        instance = [[self alloc] init];
    });
    
    return instance;
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
        self.textFontName = @"GillSans";
        self.textFontNameBold = @"PTSans-Bold";
        self.textFontSize = 16;
        self.textFont = [UIFont fontWithName:self.textFontName size:self.textFontSize];
        self.textFontBold = [UIFont fontWithName:self.textFontNameBold size:self.textFontSize];

        self.headerTextFontName = @"PTSans-CaptionBold";
        self.headerTextFontSize = 14;
        self.headerTextFont = [UIFont fontWithName:self.headerTextFontName size:self.headerTextFontSize];
        
        self.menuItemFontName = @"PTSans-CaptionBold";
        self.menuItemFontSize = 17;

        self.buttonDarkBackgroundImage = [[UIImage imageNamed:@"ButtonDark"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)];
        self.buttonDarkTextColor = RGB(255, 255, 255);
        self.buttonFont = [UIFont fontWithName:self.textFontNameBold size:15];
        
        self.textFieldBackgroundColor = RGB(255, 255, 255);
        self.textFieldBorderColor = RGB(218, 218, 216);
        self.textFieldFont = [UIFont fontWithName:self.textFontName size:self.textFontSize + 1];

        self.viewBackgroundColor = RGB(238, 238, 236);

        self.menuBackgroundColor = RGB(50, 50, 50);
        self.menuItemBackgroundColor = nil;
        self.menuItemBackgroundSelectedColor = RGB(61, 148, 184);
        self.menuItemTextColor = RGB(255, 255, 255);
        self.menuItemFont = [UIFont fontWithName:self.menuItemFontName size:self.menuItemFontSize];
        self.menuItemAccessoryImage = [UIImage imageNamed:@"MenuAccessoryLight"];
        self.menuSeparatorColor = RGB(60, 60, 60);
        self.menuLogo = [UIImage imageNamed:@"MenuLogo"];
        
        self.tableBackgroundColor = self.viewBackgroundColor;
        self.tableItemBackgroundColor = RGB(255, 255, 255);
        self.tableItemBackgroundSelectedColor = RGB(61, 148, 184);
        self.tableItemTextColor = RGB(50, 50, 50);
        self.tableItemDetailTextColor = RGB(200, 100, 100);
        self.tableItemFont = [UIFont fontWithName:self.menuItemFontName size:self.menuItemFontSize - 1];
        self.tableItemDetailFont = [UIFont fontWithName:self.menuItemFontName size:self.menuItemFontSize - 4];
        self.tableItemAccessoryImage = [UIImage imageNamed:@"MenuAccessoryDark"];
        self.tableSeparatorColor = RGB(238, 238, 236);
        
        self.navigationBarColor = RGB(61, 148, 184);
        self.navigationBarTitleTextColor = RGB(255, 255, 255);
        self.navigationBarTitleTextShadowColor = RGBA(0, 0, 0, .25);
        self.navigationBarTitleTextShadowOffset = UIOffsetMake(1, 1);
        self.navigationBarTitleFont = [UIFont fontWithName:@"PTSans-CaptionBold" size:18];
        
        self.barButtonItemBackgroundImage = [[UIImage imageNamed:@"ButtonBarItem"] resizableImageWithCapInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
        self.barButtonItemBackButtonBackgroundImage = [[UIImage imageNamed:@"ButtonBarItemBack"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 15, 0, 5)];
        self.barButtonItemMenuButtonBackgroundImage = [UIImage imageNamed:@"ButtonBarItemMenu"];
        self.barButtonItemTitleTextColor = RGB(255, 255, 255);
        self.barButtonItemTitleTextShadowColor = RGBA(0, 0, 0, .25);
        self.barButtonItemTitleTextShadowOffset = UIOffsetMake(1, 1);
        self.barButtonItemTitleFont = [UIFont fontWithName:@"PTSans-Bold" size:14];
        
        self.hudFont = [UIFont fontWithName:self.textFontName size:self.textFontSize];
    }
    
    return self;
}

- (void)apply
{
    NSDictionary* navigationBarTitleTextAttributes =
    @{
        UITextAttributeTextColor: self.navigationBarTitleTextColor,
        UITextAttributeTextShadowColor: self.navigationBarTitleTextShadowColor,
        UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:self.navigationBarTitleTextShadowOffset],
        UITextAttributeFont: self.navigationBarTitleFont,
    };
    
    NSDictionary* barButtonItemTitleTextAttributes =
    @{
        UITextAttributeTextColor: self.barButtonItemTitleTextColor,
        UITextAttributeTextShadowColor: self.barButtonItemTitleTextShadowColor,
        UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:self.barButtonItemTitleTextShadowOffset],
        UITextAttributeFont: self.barButtonItemTitleFont,
    };

    [[UINavigationBar appearance] setTintColor:self.navigationBarColor];
    [[UINavigationBar appearance] setTitleTextAttributes:navigationBarTitleTextAttributes];

    [[UIBarButtonItem appearance] setBackgroundImage:self.barButtonItemBackgroundImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:self.barButtonItemBackButtonBackgroundImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setTitleTextAttributes:barButtonItemTitleTextAttributes forState:UIControlStateNormal];
}

- (UIFont*)textFontOfSizePlus:(NSInteger)size
{
    return [UIFont fontWithName:self.textFontName size:self.textFontSize + size];
}

- (UIFont*)textFontBoldOfSizePlus:(NSInteger)size
{
    return [UIFont fontWithName:self.textFontNameBold size:self.textFontSize + size];
}

@end
