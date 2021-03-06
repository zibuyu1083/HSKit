//
//  UITabBarController+HideTabbar.m
//  FilmSiteClient
//
//  Created by hejianyuan on 2018/8/17.
//  Copyright © 2018年 M1905. All rights reserved.
//

#import "UITabBarController+HideTabbar.h"
#import "UIDevice+FSExtension.h"


// 状态栏高度
#define KStatusHeight ([UIDevice currentDevice].isIPhoneX ? 44.f : 20.f)
// 导航栏高度
#define KNavbarHeight ([UIDevice currentDevice].isIPhoneX ? 88.f : 64.f)
// tabBar高度
#define KTabBarHeight ([UIDevice currentDevice].isIPhoneX ? (49.f+34.f) : 49.f)


@implementation UITabBarController (HideTabbar)

#pragma mark 是否隐藏tabBar
- (void)hideTabBar:(BOOL)hide animated:(BOOL)animated{
    
    if (hide == YES){
        if (self.tabBar.frame.origin.y == self.view.frame.size.height) return;
    } else {
        if (self.tabBar.alpha == 0) {
            self.tabBar.alpha = 1;
        }
        if (self.tabBar.frame.origin.y == self.view.frame.size.height - KTabBarHeight) return;
    }
    
    if (animated == YES){
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3f];
        if (hide == YES){
            self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y + KTabBarHeight, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
            self.tabBar.alpha =0.0;
        }
        else{
            self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y - KTabBarHeight, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
            self.tabBar.alpha =1.0;
        }
        [UIView commitAnimations];
    } else {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3f];
        if (hide == YES){
            self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y + KTabBarHeight, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
        }else{
            self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y - KTabBarHeight, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
        }
        [UIView commitAnimations];
    }
}
@end
