//
//  NSURL+DYQuery.h
//  CCTV6Film
//
//  Created by hejianyuan on 2017/8/22.
//  Copyright © 2017年 Chelio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (DYQuery)

@property (nonatomic, strong, readonly) NSDictionary * dy_queryDictionary;

+ (NSString *)dy_URLDecodedString:(NSString *)string;

+ (NSString *)dy_URLEncodedString:(NSString *)string;

@end
