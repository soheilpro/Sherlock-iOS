//
//  SRActionSheet.m
//  SRActionSheet
//
//  Created by Tyler Durden on 6/19/12.
//  Copyright (c) 2012 Tyler Durden. All rights reserved.
//

#import "SRActionSheet.h"

@interface SRActionSheet ()

@property (nonatomic, strong) NSMutableArray* buttons;

@end

@implementation SRActionSheet

static SRActionSheet* currentInstance;

#pragma mark - Init

- (id)init
{
    self = [super init];

    if (self)
    {
        self.buttons = [NSMutableArray array];
    }

    return self;
}

#pragma mark - Methods

- (void)addButtonWithTitle:(NSString*)title selectBlock:(actionBlock)selectBlock
{
    [self addButton:title selectBlock:selectBlock type:ActionSheetButtonTypeDefault];
}

- (void)addDestructiveButtonWithTitle:(NSString*)title selectBlock:(actionBlock)selectBlock
{
    [self addButton:title selectBlock:selectBlock type:ActionSheetButtonTypeDestructive];
}

- (void)addCancelButtonWithTitle:(NSString*)title selectBlock:(actionBlock)selectBlock
{
    [self addButton:title selectBlock:selectBlock type:ActionSheetButtonTypeCancel];
}

- (void)addCancelButtonWithTitle:(NSString*)title
{
    [self addCancelButtonWithTitle:title selectBlock:^{}];
}

- (void)addButton:(NSString*)title selectBlock:(actionBlock)selectBlock type:(ActionSheetButtonType)type
{
    ActionSheetButton* button = [ActionSheetButton button];
    button.title = title;
    button.selectBlock = selectBlock;
    button.type = type;

    [self.buttons addObject:button];
}

- (void)presentInView:(UIView*)view
{
    UIActionSheet* actionSheet = [[UIActionSheet alloc] init];
    actionSheet.title = self.title;
    actionSheet.delegate = self;

    for (ActionSheetButton* button in self.buttons)
    {
        button.index = [actionSheet addButtonWithTitle:button.title];

        if (button.type == ActionSheetButtonTypeDestructive)
        {
            actionSheet.destructiveButtonIndex = button.index;
        }
        else if (button.type == ActionSheetButtonTypeCancel)
        {
            actionSheet.cancelButtonIndex = button.index;
        }
    }

    [actionSheet showInView:view];

    currentInstance = self; // Only to make sure this instance stays aournd
}

- (void)actionSheet:(UIActionSheet*)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    for (ActionSheetButton* button in self.buttons)
    {
        if (buttonIndex == button.index)
        {
            button.selectBlock();
            break;
        }
    }

    // currentInstance = nil; // Enabling this line causes the app to crash iOS
}

#pragma mark - Class methods

+ (instancetype)actionSheet
{
    return [[self alloc] init];
}

@end

@implementation ActionSheetButton

+ (instancetype)button
{
    return [[self alloc] init];
}

@end
