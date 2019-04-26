//
//  NSURL+DYQuery.m
//  CCTV6Film
//
//  Created by hejianyuan on 2017/8/22.
//  Copyright © 2017年 Chelio. All rights reserved.
//

#import "NSURL+DYQuery.h"

@implementation NSURL (DYQuery)

- (NSDictionary *)dy_queryDictionary{
    if (self.query == nil) {
        return nil;
    }
    
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
    NSString * query = self.query;
    NSArray * pairsArray = [query componentsSeparatedByString:@"&"];
    
    for (NSString * pairString in pairsArray) {
        NSArray * pair = [pairString componentsSeparatedByString:@"="];
        if (pair.count != 2) {
            continue;
        }
        
        NSString * key = [pair[0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSString * value = [pair[1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        key = [NSURL dy_URLDecodedString:key];
        value = [NSURL dy_URLDecodedString:value];
        
        [dict setObject:value forKey:key];
    }
    
    return dict;
}

+ (NSString *)dy_URLDecodedString:(NSString *)string{
    
    if (string.length == 0) {
        return nil;
    }

    NSString * decodedString =  (__bridge_transfer NSString *)
    CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                            (__bridge CFStringRef)string,
                                                            CFSTR(""),
                                                            CFStringConvertNSStringEncodingToEncoding
                                                            (NSUTF8StringEncoding));
    return decodedString;
}


+ (NSString *)dy_URLEncodedString:(NSString *)string{    
    if (string.length == 0) {
        return nil;
    }

    NSString * encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)string,
                                                              NULL,
                                                              (CFStringRef)@"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ",
                                                              kCFStringEncodingUTF8));

    return encodedString;
}


@end
