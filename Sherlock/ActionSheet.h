//
//  ActionSheet.h
//  Sherlock
//
//  Created by Soheil Rashidi on 6/19/12.
//  Copyright (c) 2012 Radset. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^actionBlock)(void);

typedef enum
{
    ActionSheetButtonTypeDefault = 0,
    ActionSheetButtonTypeDestructive,
    ActionSheetButtonTypeCancel,
} ActionSheetButtonType;

@interface ActionSheet : NSObject<UIActionSheetDelegate>

@property (nonatomic, strong) NSString* title;

+ (ActionSheet*)actionSheet;

- (void)addButtonWithTitle:(NSString*)title selectBlock:(actionBlock)selectBlock;
- (void)addDestructiveButtonWithTitle:(NSString*)title selectBlock:(actionBlock)selectBlock;
- (void)addCancelButtonWithTitle:(NSString*)title selectBlock:(actionBlock)selectBlock;
- (void)addCancelButtonWithTitle:(NSString*)title;
- (void)presentInView:(UIView*)view;

@end

@interface ActionSheetButton : NSObject

@property (nonatomic, strong) NSString* title;
@property (nonatomic) ActionSheetButtonType type;
@property (nonatomic, strong) actionBlock selectBlock;
@property (nonatomic) NSInteger index;

+ (ActionSheetButton*)button;

@end
