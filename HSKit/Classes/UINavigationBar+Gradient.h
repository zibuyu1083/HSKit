//
//  UINavigationBar+Gradient.h
//  FilmSiteClient
//
//  Created by HB on 2018/11/22.
//  Copyright © 2018 M1905. All rights reserved.
//

//渐变导航栏
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationBar (Gradient)

/**
 *  设置导航栏
 */
- (void)startShadowImage;

/**
 *  还原导航栏
 */
- (void)resetShadowImage;

- (void)gradientColor:(UIColor *)color withOffsetY:(CGFloat)offsetY;
@end

NS_ASSUME_NONNULL_END
