//
//  PopoutClass.h
//  Case
//
//  Created by 栗子 on 2018/3/29.
//  Copyright © 2018年 http://www.cnblogs.com/Lrx-lizi/.     https://github.com/lrxlizi/. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PopoutClass : NSObject

//LEEAleart
/**
 * view : 自己写的view
 * W:宽度
 * H:高度
 * alpha:背景透明度
 * postionType :位置类型 --> 居中  靠左  靠右
 * openStyle : 开始时动画样式  --> 方向和效果 LEEAnimationStyleOrientationBottom | LEEAnimationStyleFade
 * closeStyle : 结束时动画样式  --> 方向和效果 LEEAnimationStyleOrientationBottom | LEEAnimationStyleFade
 * openDuration :展开用时
 * closeDuration : 关闭用时
 * yesorno :点击空白地方是否关闭
 
     [PopoutClass leeAleartCustomVIew:customview customW:SCREEN_WIDTH customH:SCREEN_HEIGHT alearAlpha:0.6 positionType:(LEECustomViewPositionTypeCenter) openAnimationStyle:LEEAnimationStyleOrientationBottom | LEEAnimationStyleFade closeAnimationStyle:LEEAnimationStyleOrientationBottom | LEEAnimationStyleFade openAnimDuration:0.3 closeAnimDuration:0.3 clickBackgroundClose:YES];
 
 */

+(void)leeAleartCustomVIew:(UIView *)view customW:(CGFloat )W customH:(CGFloat)H alearAlpha:(float)alpha positionType:(LEECustomViewPositionType)postionType openAnimationStyle:(LEEAnimationStyle)openStyle closeAnimationStyle:(LEEAnimationStyle)closeStyle openAnimDuration:(CGFloat)openDuration closeAnimDuration:(CGFloat)closeDuration clickBackgroundClose:(BOOL)yesorno;


@end
