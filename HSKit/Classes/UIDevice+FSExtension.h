//
//  UIDevice+FSExtension.h
//  FilmSiteClient
//
//  Created by hejianyuan on 2018/7/30.
//  Copyright © 2018年 M1905. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (FSExtension)

+ (BOOL) isIPhoneX;

+ (BOOL) isIPhonePlus;

@property (nonatomic, assign, readonly) BOOL isIPhoneX;

@property (nonatomic, assign, readonly) BOOL isIPhonePlus;

@end
