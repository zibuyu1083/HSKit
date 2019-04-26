//
//  UIAlertView+Runtime.m
//  cccc
//
//  Created by sam on 16/5/9.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "UIAlertView+Runtime.h"
#import <objc/runtime.h>
#import "FullScreenViewController.h"

@implementation UIAlertView (Runtime)
+ (void)load {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		Method oldShow = class_getInstanceMethod(self, @selector(show));
		Method newShow = class_getInstanceMethod(self, @selector(newshow));
		if (oldShow != nil && newShow != nil) {
            NSLog(@"方法替换成功");
		    method_exchangeImplementations(oldShow, newShow);
		}
		else {
		    NSLog(@"方法获取失败");
		}
	});
}

- (void)newshow {
    UIViewController *vc = [[UIApplication sharedApplication].keyWindow.rootViewController presentedViewController];
    
    if (vc == nil || ![vc isKindOfClass:[FullScreenViewController class]]) {
        [self newshow];
    }
}
@end
