//
//  UIView+Popup.m
//  SystemMapViewScroller
//
//  Created by zitang on 2018/8/30.
//  Copyright © 2018年 http://www.cnblogs.com/Lrx-lizi/.     https://github.com/lrxlizi/     https://blog.csdn.net/qq_33608748. All rights reserved.
//

#import "UIView+Popup.h"
#import <objc/runtime.h>

static char *showKey = "showkey";

@interface UIView ()

/**
 是否展示了
 */
@property (nonatomic, assign) BOOL isShow;

@end


@implementation UIView (Popup)

-(void)setIsShow:(BOOL)isShow{
    objc_setAssociatedObject(self, showKey, @(isShow), OBJC_ASSOCIATION_ASSIGN);
}


-(BOOL)isShow{
    NSNumber *show = (NSNumber*)objc_getAssociatedObject(self, showKey);
    return show.boolValue;
}

#pragma mark - public
- (void)show
{
    if(self.isShow) return;
    
    self.isShow = YES;
    
    [UIView animateWithDuration:0.35f delay:0 usingSpringWithDamping:0.9f initialSpringVelocity:0.7f options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionLayoutSubviews animations:^{
        
        [[[[UIApplication sharedApplication] delegate] window] addSubview:self];

    } completion:NULL];
}

- (void)dismiss
{
    self.isShow = NO;
    
    [UIView animateWithDuration:0.35f delay:0 usingSpringWithDamping:0.9f initialSpringVelocity:0.7f options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionLayoutSubviews animations:^{
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
