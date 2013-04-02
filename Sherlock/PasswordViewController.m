//
//  PasswordViewController.m
//  Sherlock
//
//  Created by Soheil Rashidi on 3/30/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import "PasswordViewController.h"
#import "Database.h"

@implementation PasswordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem2.title = [self.database.name stringByReplacingOccurrencesOfString:@"/" withString:@" / "];
    self.passwordTextField.delegate = self;
    
    [self toggleOpenButton];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toggleOpenButton) name:UITextFieldTextDidChangeNotification object:self.passwordTextField];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.passwordTextField becomeFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField
{
    if (textField == self.passwordTextField)
        [self go:textField];
    
    return YES;
}

- (void)toggleOpenButton
{
    self.navigationItem.rightBarButtonItem.enabled = self.passwordTextField.text.length > 0;
}

- (void)go:(id)sender
{
    BOOL isPasswordCorrect = [self.delegate didEnterPassword:self.passwordTextField.text inViewController:self];

    if (!isPasswordCorrect)
        [self shakeView:self.passwordTextField];
}

- (void)cancel:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

-(void)shakeView:(UIView*)view
{
    const int reset = 5;
    const int maxShakes = 6;
    
    static int shakes = 0;
    static int translate = reset;
    
    [UIView animateWithDuration:0.09 - (shakes * .01) delay:0.01f options:(enum UIViewAnimationOptions) UIViewAnimationCurveEaseInOut animations:^
    {
        view.transform = CGAffineTransformMakeTranslation(translate, 0);
    }
    completion:^(BOOL finished)
    {
        if (shakes < maxShakes)
        {
            shakes++;

            if (translate > 0)
                translate--;

            translate *= -1;
            
            [self shakeView:view];
        }
        else
        {
            view.transform = CGAffineTransformIdentity;
            shakes = 0;
            translate = reset;
            return;
        }
    }];
}

@end
