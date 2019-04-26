//
//  NSString+DYChangYanEmoji.m
//  CCTV6Film
//
//  Created by hejianyuan on 2017/7/25.
//  Copyright © 2017年 Chelio. All rights reserved.
//

#import "NSString+DYChangYanEmoji.h"

@implementation NSString (DYChangYanEmoji)

/**更换畅言评论里面的[emoji:d83dde02]为emoji表情*/
- (NSString *)dy_replaceChangYanEmoji{
    
    if (self.length == 0) {
        return self;
    }
    
    NSError *error = NULL;
    NSString *regexStr = @"\\[emoji:([a-f0-9A-F]+)\\]";
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexStr options: NSRegularExpressionCaseInsensitive error:&error];
    if (error) {
        return self;
    }
    
    NSInteger offset = 0;
    NSMutableString *mutableString = [self mutableCopy];
    NSArray *resultArray = [regex matchesInString:self
                                          options:0
                                            range:NSMakeRange(0, [self length])];
 
    for (NSTextCheckingResult *result in resultArray) {
        if ([result numberOfRanges] != 2) {
            continue;
        }
        NSRange resultRange = [result range];
        resultRange.location += offset;
        NSString *component = [self substringWithRange:[result rangeAtIndex:1]];
        NSString* emoji = [self dy_unicodeHex2String:component];
        [mutableString replaceCharactersInRange:resultRange withString:emoji];
    
        offset += ([emoji length] - resultRange.length);
    }
    
    return mutableString;
}

- (NSString *)dy_unicodeHex2String:(NSString *)hexString{
    if (hexString.length == 0) {
        return @"";
    }

    if (hexString.length % 4 != 0) {
        return @"";
    }
    
    NSString *hexStr = hexString.lowercaseString;
    for (int i = 0; i < hexStr.length; i++) {
        unichar uchar = [hexStr characterAtIndex:i];
        if (!((uchar >= '0' && uchar <= '9') || (uchar >= 'a' && uchar <= 'f'))) {
            return @"";
        }
    }
    
    uint32_t value = 0;
    NSScanner *scaner = [[NSScanner alloc] initWithString:hexStr];
    BOOL ret = [scaner scanHexInt:&value];
    if (!ret) {
        return @"";
    }
    value = ntohl(value);
    
    NSMutableData *data = [[NSMutableData alloc] initWithCapacity:6];
    //uint16_t uniHeader = 0xfffe;
    //[data appendBytes:&uniHeader length:2];
    [data appendBytes:&value length:4];
    
    return [[NSString alloc] initWithData:data encoding:NSUnicodeStringEncoding];
}


@end
