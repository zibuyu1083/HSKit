//
//  UINavigationBar+FSAppearance.h
//  FilmSiteClient
//
//  Created by hejianyuan on 2018/7/30.
//  Copyright © 2018年 M1905. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (FSAppearance)

// 设置背景颜色和导航栏底部线条颜色
- (void)setBackgroundColor:(UIColor *)backgroundColor
               shadowColor:(UIColor *)shadowColor;

// 设置字体大小和颜色
- (void)setTitleFont:(UIFont *)font color:(UIColor *)color;

@end


@interface UINavigationBar (FSTransparent)

@property (nonatomic, strong) UIView *fs_overlay;

- (void)setBackgroundColorWithOverlay:(UIColor *)backgroundColor;

- (void)setElementsAlpha:(CGFloat)alpha;

- (void)setTranslationY:(CGFloat)translationY;

- (void)reset;

@end

