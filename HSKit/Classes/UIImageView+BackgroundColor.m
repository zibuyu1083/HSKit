//
//  UIImageView+BackgroundColor.m
//  FilmSiteClient
//
//  Created by wqj on 2017/6/10.
//  Copyright © 2017年 陈虎. All rights reserved.
//

#import "UIImageView+BackgroundColor.h"

@implementation UIImageView (BackgroundColor)

-(instancetype)initWithBackgroundColor:(UIColor*)color
{
    self = [super init];
    if (self) {
        self.backgroundColor = color;
    }
    return self;
}

-(instancetype)initWithBackgroundColor
{
    self = [super init];
    if (self) {
        self.backgroundColor = M1905_UIColorFromRGB(0xe1f2ff) ;
    }
    return self;
}

@end
