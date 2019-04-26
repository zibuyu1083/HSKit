//
//  UIFont+HSKit.m
//  CCTV6Film
//
//  Created by hejianyuan on 2018/6/9.
//  Copyright © 2018年 Chelio. All rights reserved.
//

#import "UIFont+HSKit.h"
#import "NSString+Extension.h"

@implementation UIFont (HSKit)

+ (UIFont *)hs_systemFontOfSize:(CGFloat)fontSize weight:(UIFontWeight)weight{
    return [UIFont boldSystemFontOfSize:fontSize];
}

+ (CGFloat)singleLineHeightWithFont:(UIFont *)font{
    static CGFloat s_singleHeight = 0.f;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString * str = @"中文";
        s_singleHeight = [str getDrawHeightWithFont:font Width:CGFLOAT_MAX];
    });
    
    if (s_singleHeight < 0.1) {
        NSString * str = @"中文";
        s_singleHeight = [str getDrawHeightWithFont:font Width:CGFLOAT_MAX];
    }
    return s_singleHeight;
}

@end
