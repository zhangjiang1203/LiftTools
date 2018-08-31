//
//  ToolClass.h
//  Case
//
//  Created by 栗子 on 2018/3/26.
//  Copyright © 2018年 http://www.cnblogs.com/Lrx-lizi/.     https://github.com/lrxlizi/. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToolClass : NSObject

/*设置一个圆角
 适用于label imageView view
 [EncapsulationClass viewBeizerRect:imageView.bounds view:imageView corner:UIRectCornerBottomRight cornerRadii:CGSizeMake(20, 20)];
 
 */
+(void)viewBeizerRect:(CGRect)rect view:(UIView *)view corner:(UIRectCorner)corner cornerRadii:(CGSize)radii;

/*设置一个圆角
 适用于button
 */
+(void)ControlBeizerRect:(CGRect)rect Control:(UIControl *)Control  corner:(UIRectCorner)corner cornerRadii:(CGSize)radii;



/***
 UIAlertController封装
 style : alert的类型 UIAlertControllerStyleActionSheet UIAlertControllerStyleAlert
 titleStr           : 标题
 messageStr         : 提示信息
 actionsStyle       : 多个按钮的style
 array              : 多个按钮名字
 otherStyle         : 单个按钮style 一般用cancel
 text               : 单个按钮名字
 handler            : 多个按钮点击事件
 otherHandler       : 一个按钮点击事件
 
 */
/*
 [HealpClass UIAlertControllerStyle:(UIAlertControllerStyleActionSheet) title:nil message:nil actionsStyle:(UIAlertActionStyleDefault) actionTextArr:@[@"警告",@"提示"] otherActionStyle:(UIAlertActionStyleCancel) otherText:@"取消" actionsHandler:^(UIAlertAction *actions, NSString *text) {
 NSLog(@"点击了%@",text);
 } otherHandler:^(UIAlertAction *other) {
 NSLog(@"点击了取消");
 } viewController:self];
 */
+(UIAlertController *)UIAlertControllerStyle:(UIAlertControllerStyle)style  title:(NSString *)titleStr message:(NSString *)messageStr  actionsStyle:(UIAlertActionStyle)actionsStyle  actionTextArr:(NSArray *)array otherActionStyle:(UIAlertActionStyle)otherStyle otherText:(NSString *)text actionsHandler:(void (^)(UIAlertAction * actions,NSString *text))handler  otherHandler:(void (^)(UIAlertAction * other))otherHandler viewController:(UIViewController *)vc;

//设置毛玻璃效果
+(void)blurEffect:(UIView *)view;
//判断颜色是不是亮色
+(BOOL) isLightColor:(UIColor*)clr;
//获取RGB值
+ (void)getRGBComponents:(CGFloat [3])components forColor:(UIColor *)color;

//获得某个范围内的屏幕图像
+ (UIImage *)imageFromView: (UIView *) theView   atFrame:(CGRect)r;
//判断是否为空
+ (BOOL)isNullOrNilWithObject:(id)object;
//设置圆角
+(void)setViewRadius:(UIView *)view radius:(CGFloat)ra maskToBounds:(BOOL)mask;
//设置圆角和边框
+(void)setViewRadiusAndBorder:(UIView *)view radius:(CGFloat)ra maskToBounds:(BOOL)mask borderColor:(UIColor *)color borderWidth:(CGFloat)width;
//设置label属性
+(void)setLabelProperty:(UILabel *)label backgroundColor:(UIColor *)color textColor:(UIColor *)tColor textFont:(UIFont *)font textAlignment:(NSTextAlignment )alignment;
//设置view阴影
+(void)setViewShodow:(UIView *)view shadowColor:(UIColor *)sColor shadowOffset:(CGSize)sSize shadowRadius:(CGFloat)ra shadowOpacity:(float)opacity;
// 图片变灰
+(UIImage*)grayImage:(UIImage*)sourceImage;
//图片分割
+(NSArray *)cutUpImage:(UIImage *)image;

+(NSArray *)cutUpImage:(UIImage *)image rowMax:(int)rowM colMax:(int)colM imageWidth:(CGFloat)W imageHeight:(CGFloat)H;
//修改图片的大小
+ (UIImage *)compressOriginalImage:(UIImage *)image toSize:(CGSize)size;
//收集碎片按钮动画
+(CAKeyframeAnimation *)smithereensBtnAnim:(UIView *)view;

+(CAKeyframeAnimation *)moveAnimationStarPoint:(CGPoint)statPoint endPoint:(CGPoint)endPoint;

//计算文本的宽度
+ (float)getStringWidth:(NSString *)text andFont:(float)font;
//计算文本的高度
+ (float)getStringHeight:(NSString *)text andFont:(float)font andWidth:(float)width;


@end
