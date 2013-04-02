//
//  UIView+Animation.m
//  Sherlock
//
//  Created by Soheil Rashidi on 4/3/13.
//  Copyright (c) 2013 Softtool. All rights reserved.
//

#import "UIView+Animation.h"

@implementation UIView (Animation)

-(void)shake
{
    const int reset = 5;
    const int maxShakes = 6;
    
    static int shakes = 0;
    static int translate = reset;
    
    [UIView animateWithDuration:0.09 - (shakes * .01) delay:0.01f options:(enum UIViewAnimationOptions) UIViewAnimationCurveEaseInOut animations:^
    {
        self.transform = CGAffineTransformMakeTranslation(translate, 0);
    }
                    completion:^(BOOL finished)
    {
        if (shakes < maxShakes)
        {
            shakes++;
            
            if (translate > 0)
                translate--;
            
            translate *= -1;
            
            [self shake];
        }
        else
        {
            self.transform = CGAffineTransformIdentity;
            shakes = 0;
            translate = reset;
            return;
        }
    }];
}

@end
