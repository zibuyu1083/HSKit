//
//  CALayer+HSKit.m
//  FilmSiteClient
//
//  Created by hejianyuan on 2018/11/10.
//  Copyright © 2018 M1905. All rights reserved.
//

#import "CALayer+HSKit.h"


@implementation CALayer (HSKit)

+ (void)updateLayerDisableAnimation:(HSKitCALayerVoidBlock)block{
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    if (block) {
        block();
    }
    [CATransaction commit];
}


@end
