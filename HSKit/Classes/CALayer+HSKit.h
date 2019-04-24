//
//  CALayer+HSKit.h
//  FilmSiteClient
//
//  Created by hejianyuan on 2018/11/10.
//  Copyright © 2018 M1905. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

typedef void(^HSKitCALayerVoidBlock)(void);

@interface CALayer (HSKit)

+ (void)updateLayerDisableAnimation:(HSKitCALayerVoidBlock)block;

@end


