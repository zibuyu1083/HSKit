//
//  WKWebView+DYUserAgent.m
//  CCTV6Film
//
//  Created by hejianyuan on 2017/8/14.
//  Copyright © 2017年 Chelio. All rights reserved.
//

#import "WKWebView+DYUserAgent.h"


@implementation WKWebView (DYUserAgent)

- (void)dy_getUserAgentWithResult:(void(^)(NSString * result))result{

    [self evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id  userAgent, NSError * __nullable error) {
        if (result) {
            return result(userAgent);
        }
    }];
}

- (void)dy_setCustomUserAgent:(NSString *)customUserAgent result:(void(^)(void))result{
    
    if ([[UIDevice currentDevice].systemVersion integerValue] < 9.f) { //iOS8
        [self evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id userAgent, NSError *error) {
            
            NSString *oldAgent = customUserAgent;
            NSString *newAgent = [NSString stringWithFormat:@"%@;%@", oldAgent, @"extra_user_agent"];
            
            NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:newAgent, @"UserAgent", nil];
            [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
            [[NSUserDefaults standardUserDefaults] synchronize];
            if (result) {
                result();
            }
        }];
        
    } else { //iOS9
        self.customUserAgent = customUserAgent;
        if (result) {
            result();
        }
    }
}


- (void)dy_setCCTV6UserAgentWitResult:(void(^)(void))result{
    [self dy_getUserAgentWithResult:^(NSString *userAgent) {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
         [self dy_setCustomUserAgent:[NSString stringWithFormat:@"%@ M1905/%@",userAgent, appVersion] result:result];
    }];
}

@end
