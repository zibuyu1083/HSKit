//
//  UIViewController+UM.m
//  FilmSiteClient
//
//  Created by sam on 16/5/23.
//  Copyright © 2016年 陈虎. All rights reserved.
//

#import "UIViewController+UM.h"
#import "SNRuntimeUtil.h"
#import <UMAnalytics/MobClick.h>
#import "BaseViewController.h"
#import "ZFPlayer.h"

static NSArray *blackList;

@implementation UIViewController (UM)
+ (void)load {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		blackList = @[@"BaseNavigationController",
		              @"TabBarController",
		              @"UICompatibilityInputViewController",
		              @"_UIRemoteInputViewController",
                      @"UIInputWindowController"];

		SEL originalSelector = @selector(viewDidAppear:);
		SEL swizzledSelector = @selector(swiz_viewDidAppear:);

		SEL originalSelector1 = @selector(viewDidDisappear:);
		SEL swizzledSelector1 = @selector(swiz_viewDidDisappear:);
        
        SEL originalSelector2 = NSSelectorFromString(@"dealloc");
        SEL swizzledSelector2 = @selector(swiz_dealloc);

		[SNRuntimeUtil swizzlingInClass:[self class] originalSelector:originalSelector swizzledSelector:swizzledSelector];
		[SNRuntimeUtil swizzlingInClass:[self class] originalSelector:originalSelector1 swizzledSelector:swizzledSelector1];
        [SNRuntimeUtil swizzlingInClass:[self class] originalSelector:originalSelector2 swizzledSelector:swizzledSelector2];
	});
}

- (void)swiz_viewDidAppear:(BOOL)animated {
	NSString *clazzName = NSStringFromClass([self class]);
	if (![blackList containsObject:clazzName]) {
		[self injectViewDidAppear];
	}
	[self swiz_viewDidAppear:animated];
    
    if ([self isKindOfClass:BaseViewController.class]) {
        return;
    }
    
    if (@available(iOS 11.0, *)) {
        NSString *modelString = @"UIModalPresentationStyle";
        NSString *prefixString = @"MP";
        NSString *suffixString = @"Window";
        
        NSString *classString = [modelString stringByReplacingOccurrencesOfString:@"UI" withString:@"MP"];
        classString = [classString stringByReplacingOccurrencesOfString:@"Style" withString:@"Window"];
        
        NSString *className = NSStringFromClass(self.view.window.class);
        if ([className isEqualToString:classString]) {
            ZFPlayerView.isSystemRouteViewControllerAppear = YES;
        }
    }else{
        NSString *modelString = @"UIViewController";
        NSString *prefixString = @"MPAV";
        NSString *suffixString = @"Routing";
        
        NSString *classString = [modelString stringByReplacingOccurrencesOfString:@"UI" withString:@"Routing"];
        classString = [prefixString stringByAppendingString:classString];
        
        
        NSString *className = NSStringFromClass(self.class);
        if ([className isEqualToString:classString]) {
            ZFPlayerView.isSystemRouteViewControllerAppear = YES;
        }
    }
}

- (void)swiz_dealloc{
    NSString *clazzName = NSStringFromClass([self class]);
    NSLog(@"================%@页面被释放=========",clazzName);
    [self swiz_dealloc];
}

- (void)swiz_viewDidDisappear:(BOOL)animated {
	NSString *clazzName = NSStringFromClass([self class]);
	if (![blackList containsObject:clazzName]) {
		[self injectViewDidDisappear];
	}
	[self swiz_viewDidDisappear:animated];
    
    if ([self isKindOfClass:BaseViewController.class]) {
        return;
    }
    
    
    if (@available(iOS 11.0, *)) {
        NSString *modelString = @"UIModalPresentationStyle";
        NSString *prefixString = @"MP";
        NSString *suffixString = @"Window";
        
        NSString *classString = [modelString stringByReplacingOccurrencesOfString:@"UI" withString:@"MP"];
        classString = [classString stringByReplacingOccurrencesOfString:@"Style" withString:@"Window"];
        
        NSString *className = NSStringFromClass(self.view.window.class);
        if ([className isEqualToString:classString]) {
            ZFPlayerView.isSystemRouteViewControllerAppear = NO;
        }
    }else{
        NSString *modelString = @"UIViewController";
        NSString *prefixString = @"MPAV";
        NSString *suffixString = @"Routing";
        
        NSString *classString = [modelString stringByReplacingOccurrencesOfString:@"UI" withString:@"Routing"];
        classString = [prefixString stringByAppendingString:classString];
        
        
        NSString *className = NSStringFromClass(self.class);
        if ([className isEqualToString:classString]) {
            ZFPlayerView.isSystemRouteViewControllerAppear = NO;
        }
    }
}

/**
 *  代码注入 统计页面的开始
 */
- (void)injectViewDidAppear {
	NSString *pageName = NSStringFromClass([self class]);
	if (![pageName isNotEmpty]) {
		return;
	}
    if ([pageName isEqualToString:@"SSDKAuthViewController"]) {
        [self postNotification:AppDidEnterBackgroundNotification];
    }
	[MobClick beginLogPageView:pageName];
}

/**
 *  代码注入 统计页面的结束
 */
- (void)injectViewDidDisappear {
	NSString *pageName = NSStringFromClass([self class]);
	if (![pageName isNotEmpty]) {
		return;
	}
    if ([pageName isEqualToString:@"SSDKAuthViewController"]) {
        [self postNotification:AppWillEnterForegroundNotification];
    }
	[MobClick endLogPageView:pageName];
}

@end
