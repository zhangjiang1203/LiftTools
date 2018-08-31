//
//  PopoutClass.m
//  Case
//
//  Created by 栗子 on 2018/3/29.
//  Copyright © 2018年 http://www.cnblogs.com/Lrx-lizi/.     https://github.com/lrxlizi/. All rights reserved.
//

#import "PopoutClass.h"

@implementation PopoutClass

//LEEAleart
+(void)leeAleartCustomVIew:(UIView *)view customW:(CGFloat )W customH:(CGFloat)H alearAlpha:(float)alpha positionType:(LEECustomViewPositionType)postionType openAnimationStyle:(LEEAnimationStyle)openStyle closeAnimationStyle:(LEEAnimationStyle)closeStyle openAnimDuration:(CGFloat)openDuration closeAnimDuration:(CGFloat)closeDuration clickBackgroundClose:(BOOL)yesorno{
    
    UIView *view1 = [UIView new];
    view1.frame = CGRectMake(0, 0, W, H);
    [view1 addSubview:view];
    
    [LEEAlert alert].config.LeeAddCustomView(^(LEECustomView *custom) {
        custom.view = view1;
        custom.positionType = postionType;
    })
    .LeeOpenAnimationStyle(LEEAnimationStyleOrientationBottom | LEEAnimationStyleFade)
    .LeeCloseAnimationStyle(openStyle)
    .LeeOpenAnimationDuration(openDuration)
    .LeeCloseAnimationDuration(closeDuration)
    .LeeHeaderColor([UIColor clearColor])
    .LeeMaxWidth(W)
    .LeeMaxHeight(H)
    .LeeCornerRadius(5.0f)
    .LeeBackgroundStyleTranslucent(alpha)
    .LeeHeaderInsets(UIEdgeInsetsMake(0, 0, 0, 0))
    .LeeItemInsets(UIEdgeInsetsMake(0, 0, 0, 0))
    .LeeClickBackgroundClose(yesorno)
    .LeeShow();
}



@end
