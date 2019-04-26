//
//  WKWebView+DYUserAgent.h
//  CCTV6Film
//
//  Created by hejianyuan on 2017/8/14.
//  Copyright © 2017年 Chelio. All rights reserved.
//

#import <WebKit/WebKit.h>

@interface WKWebView (DYUserAgent)

- (void)dy_getUserAgentWithResult:(void(^)(NSString * result))result;

- (void)dy_setCustomUserAgent:(NSString *)customUserAgent result:(void(^)(void))result;


/**
 添加UserAgent：CCTV6/5.0.xxxxxx
 */
- (void)dy_setCCTV6UserAgentWitResult:(void(^)(void))result;

@end
