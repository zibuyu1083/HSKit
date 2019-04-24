//
//  UIFont+HSKit.h
//  CCTV6Film
//
//  Created by hejianyuan on 2018/6/9.
//  Copyright © 2018年 Chelio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (HSKit)

+ (UIFont *)hs_systemFontOfSize:(CGFloat)fontSize weight:(UIFontWeight)weight;

//返回单行文字的高度
+ (CGFloat)singleLineHeightWithFont:(UIFont *)font;
@end
