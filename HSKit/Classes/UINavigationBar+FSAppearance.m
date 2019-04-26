//
//  UINavigationBar+FSAppearance.m
//  FilmSiteClient
//
//  Created by hejianyuan on 2018/7/30.
//  Copyright © 2018年 M1905. All rights reserved.
//

#import "UINavigationBar+FSAppearance.h"
#import "UIImage+Extension.h"
#import "UIDevice+FSExtension.h"
static const char* fs_overlayKey = "fs_overlayKey";

@implementation UINavigationBar (FSAppearance)

- (void)setBackgroundColor:(UIColor *)backgroundColor
               shadowColor:(UIColor *)shadowColor{
    CGFloat height = [UIApplication sharedApplication].statusBarFrame.size.height + self.frame.size.height;
    
    [self setBackgroundImage:[UIImage imageWithColor:backgroundColor size:CGSizeMake(M1905_SCREEN_WIDTH, height)] forBarMetrics:UIBarMetricsDefault];
    [self setShadowImage:[UIImage imageWithColor:shadowColor size:CGSizeMake(M1905_SCREEN_WIDTH, 0.5)]];
}

- (void)setTitleFont:(UIFont *)font color:(UIColor *)color{
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                             color,
                             NSForegroundColorAttributeName,
                             font,NSFontAttributeName,
                             nil];
    self.titleTextAttributes = attributes;
}

@end



@implementation UINavigationBar (FSTransparent)

- (UIView *)fs_overlay{
    return objc_getAssociatedObject(self, fs_overlayKey);
}

- (void)setFs_overlay:(UIView *)overlay{
    objc_setAssociatedObject(self, fs_overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setBackgroundColorWithOverlay:(UIColor *)backgroundColor{
    if (!self.fs_overlay) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.fs_overlay = [[UIView alloc] initWithFrame:CGRectMake(0, -M1905_STATUS_BAR_HEIGHT, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + M1905_STATUS_BAR_HEIGHT)];
        self.fs_overlay.userInteractionEnabled = NO;
        self.fs_overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self insertSubview:self.fs_overlay atIndex:0];
        [self sendSubviewToBack:self.fs_overlay];
    }
    self.fs_overlay.backgroundColor = backgroundColor;
    if (self.subviews.firstObject != self.fs_overlay ) {
        [self sendSubviewToBack:self.fs_overlay];
    }
}

- (void)setTranslationY:(CGFloat)translationY{
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}

- (void)setElementsAlpha:(CGFloat)alpha{
    [[self valueForKey:@"_leftViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    [[self valueForKey:@"_rightViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    UIView *titleView = [self valueForKey:@"_titleView"];
    titleView.alpha = alpha;
    //    when viewController first load, the titleView maybe nil
    [[self subviews] enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:NSClassFromString(@"UINavigationItemView")]) {
            obj.alpha = alpha;
            *stop = YES;
        }
    }];
}

- (void)reset{
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.fs_overlay removeFromSuperview];
    self.fs_overlay = nil;
}

@end
