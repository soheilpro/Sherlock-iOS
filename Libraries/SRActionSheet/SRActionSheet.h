//
//  SRActionSheet.h
//  SRActionSheet
//
//  Created by Tyler Durden on 6/19/12.
//  Copyright (c) 2012 Tyler Durden. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^actionBlock)(void);

typedef enum
{
    ActionSheetButtonTypeDefault = 0,
    ActionSheetButtonTypeDestructive,
    ActionSheetButtonTypeCancel,
} ActionSheetButtonType;

@interface SRActionSheet : NSObject<UIActionSheetDelegate>

@property (nonatomic, strong) NSString* title;

- (void)addButtonWithTitle:(NSString*)title selectBlock:(actionBlock)selectBlock;
- (void)addDestructiveButtonWithTitle:(NSString*)title selectBlock:(actionBlock)selectBlock;
- (void)addCancelButtonWithTitle:(NSString*)title selectBlock:(actionBlock)selectBlock;
- (void)addCancelButtonWithTitle:(NSString*)title;
- (void)presentInView:(UIView*)view;

+ (instancetype)actionSheet;

@end

@interface ActionSheetButton : NSObject

@property (nonatomic, strong) NSString* title;
@property (nonatomic) ActionSheetButtonType type;
@property (nonatomic, strong) actionBlock selectBlock;
@property (nonatomic) NSInteger index;

+ (instancetype)button;

@end
