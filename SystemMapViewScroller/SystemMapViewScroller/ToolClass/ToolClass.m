//
//  ToolClass.m
//  Case
//
//  Created by 栗子 on 2018/3/26.
//  Copyright © 2018年 http://www.cnblogs.com/Lrx-lizi/.     https://github.com/lrxlizi/. All rights reserved.
//

#import "ToolClass.h"

@implementation ToolClass

/*设置一个圆角
 适用于label imageView view
 [EncapsulationClass viewBeizerRect:imageView.bounds view:imageView corner:UIRectCornerBottomRight cornerRadii:CGSizeMake(20, 20)];
 
 */
+(void)viewBeizerRect:(CGRect)rect view:(UIView *)view corner:(UIRectCorner)corner cornerRadii:(CGSize)radii{
    UIBezierPath  *maskPath= [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corner cornerRadii:radii];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame =view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
    
}
/*设置一个圆角
 适用于button
 
 */
+(void)ControlBeizerRect:(CGRect)rect Control:(UIControl *)Control  corner:(UIRectCorner)corner cornerRadii:(CGSize)radii{
    UIBezierPath  *maskPath= [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corner cornerRadii:radii];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame =Control.bounds;
    maskLayer.path = maskPath.CGPath;
    Control.layer.mask = maskLayer;
}
+(UIAlertController *)UIAlertControllerStyle:(UIAlertControllerStyle)style  title:(NSString *)titleStr message:(NSString *)messageStr  actionsStyle:(UIAlertActionStyle)actionsStyle  actionTextArr:(NSArray *)array otherActionStyle:(UIAlertActionStyle)otherStyle otherText:(NSString *)text actionsHandler:(void (^)(UIAlertAction * actions,NSString *text))handler  otherHandler:(void (^)(UIAlertAction * other))otherHandler viewController:(UIViewController *)vc{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:titleStr message:messageStr preferredStyle:style];
    [alertController addAction:[UIAlertAction actionWithTitle:text style:otherStyle handler:^(UIAlertAction * _Nonnull action) {
        otherHandler(action);
    }]];
    for (NSInteger i=0; i<array.count; i++) {
        NSString *titleStr = [NSString stringWithFormat:@"%@",array[i]];
        [alertController addAction:[UIAlertAction actionWithTitle:titleStr style:actionsStyle handler:^(UIAlertAction * _Nonnull action) {
            handler(action,titleStr);
        }]];
    }
    [vc presentViewController:alertController animated:YES completion:nil];
    return alertController;
}

//设置毛玻璃效果
+(void)blurEffect:(UIView *)view{
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectVIew = [[UIVisualEffectView alloc]initWithEffect:effect];
    effectVIew.frame = view.bounds;
    [view addSubview:effectVIew];
    
}

//判断颜色是不是亮色
+(BOOL) isLightColor:(UIColor*)clr {
    CGFloat components[3];
    [ToolClass getRGBComponents:components forColor:clr];
    //        NSLog(@"%f %f %f", components[0], components[1], components[2]);
    
    CGFloat num = components[0] + components[1] + components[2];//rgb之和<382 是暗色  (255/2)*3
    if(num < 382)return NO;
    else return YES;
}



//获取RGB值
+ (void)getRGBComponents:(CGFloat [3])components forColor:(UIColor *)color {
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
#else
    int bitmapInfo = kCGImageAlphaPremultipliedLast;
#endif
    
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char resultingPixel[4];
    CGContextRef context = CGBitmapContextCreate(&resultingPixel,
                                                 1,
                                                 1,
                                                 8,
                                                 4,
                                                 rgbColorSpace,
                                                 bitmapInfo);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
    CGContextRelease(context);
    CGColorSpaceRelease(rgbColorSpace);
    
    for (int component = 0; component < 3; component++) {
        components[component] = resultingPixel[component];
    }
}
//获得某个范围内的屏幕图像
+ (UIImage *)imageFromView: (UIView *) theView   atFrame:(CGRect)r
{
    UIGraphicsBeginImageContext(theView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    UIRectClip(r);
    [theView.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return  theImage;//[self getImageAreaFromImage:theImage atFrame:r];
}
//判断是否为空
+ (BOOL)isNullOrNilWithObject:(id)object;
{
    if (object == nil || [object isEqual:[NSNull null]]) {
        return YES;
    } else if ([object isKindOfClass:[NSString class]]) {
        if ([object isEqualToString:@""]||[object isEqualToString:@"(null)"]) {
            return YES;
        } else {
            return NO;
        }
    }
    else if ([object isKindOfClass:[NSNumber class]]) {
        if ([object isEqualToNumber:@0]) {
            return YES;
        } else {
            return NO;
        }
    }
    return NO;
}
//设置圆角
+(void)setViewRadius:(UIView *)view radius:(CGFloat)ra maskToBounds:(BOOL)mask{
    view.layer.cornerRadius = ra;
    view.layer.masksToBounds = mask;
}

//设置圆角和边框
+(void)setViewRadiusAndBorder:(UIView *)view radius:(CGFloat)ra maskToBounds:(BOOL)mask borderColor:(UIColor *)color borderWidth:(CGFloat)width{
    view.layer.cornerRadius  = ra;
    view.layer.masksToBounds = mask;
    view.layer.borderColor   = color.CGColor;
    view.layer.borderWidth   = width;
}
//设置label属性 
+(void)setLabelProperty:(UILabel *)label backgroundColor:(UIColor *)color textColor:(UIColor *)tColor textFont:(UIFont *)font textAlignment:(NSTextAlignment )alignment{
    label.backgroundColor = color;
    label.textColor       = tColor;
    label.font            = font;
    label.textAlignment   = alignment;
}

//button属性
+(void)setButtonProperty:(UIButton *)btn backgroundColor:(UIColor *)color title:(NSString *)titleStr  titleColor:(UIColor *)tColor titleFont:(UIFont *)font {
    btn.backgroundColor = color;
    [btn setTitle:titleStr forState:UIControlStateNormal];
    [btn setTitleColor:tColor forState:UIControlStateNormal];
    btn.titleLabel.font = font;
}

//设置view阴影
+(void)setViewShodow:(UIView *)view shadowColor:(UIColor *)sColor shadowOffset:(CGSize)sSize shadowRadius:(CGFloat)ra shadowOpacity:(float)opacity{
    view.layer.shadowColor = sColor.CGColor;
    view.layer.shadowOffset = sSize;
    view.layer.shadowRadius = ra;
    view.layer.shadowOpacity = opacity;
}



// 图片变灰
+(UIImage*)grayImage:(UIImage*)sourceImage {
        int width = sourceImage.size.width;
        int height = sourceImage.size.height;
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
        CGContextRef context = CGBitmapContextCreate (nil, width, height,8,0, colorSpace,kCGImageAlphaNone);
        CGColorSpaceRelease(colorSpace);
        if (context ==NULL) {
            return nil;
        }
        CGContextDrawImage(context,CGRectMake(0,0, width, height), sourceImage.CGImage);
        UIImage *grayImage = [UIImage imageWithCGImage:CGBitmapContextCreateImage(context)];
        CGContextRelease(context);
        return grayImage;

}

+(NSArray *)cutUpImage:(UIImage *)image{
    
    NSMutableArray *imageArray = [NSMutableArray array];
    for (int row = 0; row < 3; row ++) {
        for (int col = 0; col < 3; col ++) {
            CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(col * 82, row * 82, 82, 82));
            UIImage *image = [UIImage imageWithCGImage:imageRef];
            CGImageRelease(imageRef);
            // 将图片添加到图片数组
            [imageArray addObject:image];
        }
    }
    return imageArray;
}

+(NSArray *)cutUpImage:(UIImage *)image rowMax:(int)rowM colMax:(int)colM imageWidth:(CGFloat)W imageHeight:(CGFloat)H{
    
    NSMutableArray *imageArray = [NSMutableArray array];
    for (int row = 0; row < rowM; row ++) {
        for (int col = 0; col < colM; col ++) {
            CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(col * W, row * H, W, H));
            UIImage *image = [UIImage imageWithCGImage:imageRef];
            CGImageRelease(imageRef);
            // 将图片添加到图片数组
            [imageArray addObject:image];
        }
    }
    return imageArray;
}
//修改图片的大小
+ (UIImage *)compressOriginalImage:(UIImage *)image toSize:(CGSize)size{
    UIImage * resultImage;
    if (image.size.width != image.size.height) {
        resultImage = [[self new] cutCenterSquareImage:image];
    } else {
        resultImage = image;
    }
    UIGraphicsBeginImageContext(size);
    [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newimage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimage;
}
-(UIImage *)cutCenterSquareImage:(UIImage *)image{
    CGSize imageSize = image.size;
    
    // 中间最大正方形尺寸
    CGRect centerRect;
    CGFloat centerRectWH;
    
    //根据图片的大小计算出图片中间矩形区域的位置与大小
    if (imageSize.width > imageSize.height) {
        centerRectWH = imageSize.height;
        float leftMargin = (imageSize.width - imageSize.height) * 0.5;
        centerRect = CGRectMake(leftMargin,0,centerRectWH,centerRectWH);
    } else {
        centerRectWH = imageSize.width;
        float topMargin = (imageSize.height - imageSize.width)*0.5;
        centerRect = CGRectMake(0,topMargin,centerRectWH,centerRectWH);
    }
    
    CGImageRef imageRef = image.CGImage;
    //在最大正方形尺寸范围内截取
    CGImageRef imageRefRect = CGImageCreateWithImageInRect(imageRef, centerRect);
    UIImage *tmp = [[UIImage alloc] initWithCGImage:imageRefRect];
    CGImageRelease(imageRefRect);// tmp是截取之后的image
    
    return tmp;
}
//缩放动画
+(CAKeyframeAnimation *)smithereensBtnAnim:(UIView *)view{
    CAKeyframeAnimation * rectangleTransformAnim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    rectangleTransformAnim.values   = @[[NSValue valueWithCATransform3D:CATransform3DIdentity],
                                        [NSValue valueWithCATransform3D:CATransform3DMakeScale(5, 5, 1)]];
    rectangleTransformAnim.keyTimes = @[@0, @0.79];
    rectangleTransformAnim.duration = 0.8;
    rectangleTransformAnim.repeatCount = 1;
    rectangleTransformAnim.removedOnCompletion = NO;
    rectangleTransformAnim.fillMode = kCAFillModeForwards;
    
    return rectangleTransformAnim;
}
//碎片动画
+(CAAnimationGroup *)smithereensViewAnim:(UIView *)view compareView:(CGRect)cview{
    CAKeyframeAnimation *keyFrameAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    keyFrameAnim.values = @[[NSValue valueWithCGPoint:view.center],[NSValue valueWithCGPoint:CGPointMake(cview.origin.x+(cview.size.width/2), cview.origin.y+(cview.size.height/2))]];
    keyFrameAnim.duration = 0.3;
    keyFrameAnim.repeatCount = 1;
    keyFrameAnim.removedOnCompletion = NO;
    keyFrameAnim.fillMode = kCAFillModeForwards;
    
//    CAKeyframeAnimation * rectangleTransformAnim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
//    rectangleTransformAnim.values   = @[[NSValue valueWithCATransform3D:CATransform3DIdentity],
//                                        [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0, 0.0, 1)]];
//    rectangleTransformAnim.keyTimes = @[@0, @1];
//    rectangleTransformAnim.duration = 0.3;
//    rectangleTransformAnim.removedOnCompletion = NO;
//    rectangleTransformAnim.fillMode = kCAFillModeForwards;
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = [NSArray arrayWithObjects:keyFrameAnim, nil];
    animGroup.duration = 0.5;
    animGroup.repeatCount = 1;
    animGroup.removedOnCompletion = NO;
    animGroup.fillMode = kCAFillModeForwards;
    
    return animGroup;
}

+(CAKeyframeAnimation *)moveAnimationStarPoint:(CGPoint)statPoint endPoint:(CGPoint)endPoint
{
    CAKeyframeAnimation *keyFrameAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyFrameAnim.values = @[[NSValue valueWithCGPoint:statPoint],[NSValue valueWithCGPoint:endPoint]];
    keyFrameAnim.duration = .5;
    keyFrameAnim.repeatCount = 1;
    keyFrameAnim.removedOnCompletion = NO;
    keyFrameAnim.fillMode = kCAFillModeForwards;
    return keyFrameAnim;
}

//计算文本的宽度
+ (float)getStringWidth:(NSString *)text andFont:(float)font{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:font] forKey:NSFontAttributeName];
    CGSize size = [text boundingRectWithSize:CGSizeMake(320, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.width+1;
}

//计算文本的高度
+ (float)getStringHeight:(NSString *)text andFont:(float)font andWidth:(float)width{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:font] forKey:NSFontAttributeName];
    CGSize size = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height+1;
}


@end
