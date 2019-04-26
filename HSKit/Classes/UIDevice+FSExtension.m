//
//  UIDevice+FSExtension.m
//  FilmSiteClient
//
//  Created by hejianyuan on 2018/7/30.
//  Copyright © 2018年 M1905. All rights reserved.
//

#import "UIDevice+FSExtension.h"

@implementation UIDevice (FSExtension)

+ (BOOL) isIPhoneX{
    return [UIDevice currentDevice].isIPhoneX;
}

+ (BOOL) isIPhonePlus{
    return [UIDevice currentDevice].isIPhonePlus;
}

- (BOOL)isIPhoneX{
    return [self isIPhoneXSeries];
}

- (BOOL)isIPhonePlus{
    static BOOL s_isIPhonePlus = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (((NSInteger)[UIScreen mainScreen].bounds.size.height) == 736) {
            s_isIPhonePlus = YES;
        }
    });
    
    return s_isIPhonePlus;
}

- (BOOL)isIPhoneXSeries{
    static BOOL s_isIPhoneXSeries = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (@available(iOS 11.0, *)) {
            UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
            if (mainWindow.safeAreaInsets.bottom > 0.0) {
                s_isIPhoneXSeries = YES;
            }
        }
    });
    
    return s_isIPhoneXSeries;
}

@end
