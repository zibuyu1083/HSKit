//
//  UINavigationBar+Gradient.m
//  FilmSiteClient
//
//  Created by HB on 2018/11/22.
//  Copyright © 2018 M1905. All rights reserved.
//

#import "UINavigationBar+Gradient.h"

@implementation UINavigationBar (Gradient)

- (void)startShadowImage {
    
//    self.translucent = YES;
    UIImageView *shadowImg = [self seekLineImageViewOn:self];
    shadowImg.hidden = YES;
}

- (void)resetShadowImage {
    
//    self.translucent = NO;
    UIImageView *shadowImg = [self seekLineImageViewOn:self];
    shadowImg.hidden = NO;
//    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
}

/**
 前提是已经设置translucent为YES,也去掉了那条线

 @param color 要设置的最终颜色
 @param offsetY 偏移量
 */
- (void)gradientColor:(UIColor *)color withOffsetY:(CGFloat)offsetY {
    
    if (offsetY < 0) {
        
        //下拉时导航栏隐藏
        self.hidden = YES;
    }else {
        
        self.hidden = NO;
        //计算透明度，
        CGFloat alpha = offsetY / 150 > 1.0f ? 1 : (offsetY / 150);
        
        //设置一个颜色并转化为图片
        UIImage *image = [self imageWithColor:[color colorWithAlphaComponent:alpha]];
        [self setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
        
    }
}

//寻找导航栏下的横线
- (UIImageView *)seekLineImageViewOn:(UIView *)view {
    
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) return (UIImageView *)view;
    
    for (UIView *subview in view.subviews) {
        
        UIImageView *imageView = [self seekLineImageViewOn:subview];
        if (imageView) return imageView;
    }
    return nil;
}

#pragma mark - Color To Image
- (UIImage *)imageWithColor:(UIColor *)color {
    //创建1像素区域并开始图片绘图
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    
    //创建画板并填充颜色和区域
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    //从画板上获取图片并关闭图片绘图
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
