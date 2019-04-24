//
//  NSString+HSKit.m
//  DSCloudVision
//
//  Created by hejianyuan on 2016/10/18.
//  Copyright © 2016年 东电创新. All rights reserved.
//

#import "NSString+HSKit.h"

@implementation NSString (HSKit)


- (NSComparisonResult)versionCompare:(NSString *)aVersionString{
    
    return [self compare:aVersionString options:NSNumericSearch];
}

+ (BOOL)isBlankString:(NSString *) aString{
    
    if (aString == nil || aString == NULL) {
        return YES;
    }
    
    if ([aString isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if ([[aString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) {
        return YES;
    }
    return NO;
    
}

+ (BOOL)isSpecialString:(NSString *)sString{
    
    NSString *pattern = @"^[\\w-:\\.\\(\\)!@#\\$%\\^&\\*_\\+=;:]{1,12}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:sString];
    return isMatch;
    
}

+ (BOOL)isPhoneString:(NSString *)pString{
    
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         *
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:pString] == YES)
        || ([regextestcm evaluateWithObject:pString] == YES)
        || ([regextestct evaluateWithObject:pString] == YES)
        || ([regextestcu evaluateWithObject:pString] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
}

+(BOOL)isDigitalString:(NSString *)dString{
    
    for (int i = 0 ; i < dString.length ; i++) {
        if (!isdigit([dString characterAtIndex:i])) {
            return NO;
        }
    }
    return YES;

}


- (CGFloat)textHeightWithFont:(UIFont *)font lineBreakMode:(NSLineBreakMode)lineBreakMode maxWidth:(CGFloat)maxWidth{
    CGSize size;

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    NSDictionary * dict = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle};
    paragraphStyle.lineBreakMode = lineBreakMode;
    
    size = [self boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading  attributes:dict context:nil].size;
    
    return ceil(size.height);
}

- (CGFloat)textHeightWithFont:(UIFont *)font lineSpacing:(CGFloat)lineSpacing maxWidth:(CGFloat)maxWidth{
    CGSize size;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    NSDictionary * dict = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle};
    paragraphStyle.lineSpacing = lineSpacing;
    
    size = [self boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading  attributes:dict context:nil].size;
    
    NSInteger line = size.height / font.lineHeight;
    if (line == 1) {
        size.height -= lineSpacing;
    }
    
    return ceil(size.height);
}

- (CGFloat)textHeightWithFont:(UIFont *)font lineHeight:(CGFloat)lineHeight maxWidth:(CGFloat)maxWidth{
    CGSize size;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    NSDictionary * dict = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle};
    paragraphStyle.maximumLineHeight = lineHeight;
    paragraphStyle.minimumLineHeight = lineHeight;

    
    size = [self boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading  attributes:dict context:nil].size;
    
    return ceil(size.height);
}


- (CGFloat)textHeightWithFont:(UIFont *)font lineBreakMode:(NSLineBreakMode)lineBreakMode paragraphStyle:(NSParagraphStyle *)paragraphStyle maxWidth:(CGFloat)maxWidth{

    CGSize size;
    
    NSMutableParagraphStyle *mutableParagraphStyle;
    if (paragraphStyle) {
        mutableParagraphStyle = [paragraphStyle mutableCopy];
    }else{
        mutableParagraphStyle = [[NSMutableParagraphStyle alloc]init];
    }
    mutableParagraphStyle.lineBreakMode = lineBreakMode;
    
    NSDictionary * dict = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:mutableParagraphStyle};
   
    
    size = [self boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading  attributes:dict context:nil].size;
    
    return ceil(size.height);
}

- (CGFloat)textWidthWithFont:(UIFont *)font
{
    CGSize size;
 
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    NSDictionary * dict = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle};
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    size = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX,CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading  attributes:dict context:nil].size;
    
    return ceil(size.width);
}

- (CGFloat)textWidthWithFont:(UIFont *)font lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    CGSize size;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    NSDictionary * dict = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle};
    paragraphStyle.lineBreakMode = lineBreakMode;
    
    size = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX,CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading  attributes:dict context:nil].size;
    
    return ceil(size.width);
}


- (NSAttributedString *)attributedStringWithFont:(UIFont*)font color:(UIColor *)color lineSpacing:(CGFloat)lineSpacing maxWidth:(CGFloat)maxWidth;{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    NSMutableDictionary *dict = [@{NSFontAttributeName:font,
                            NSForegroundColorAttributeName:color
                            } mutableCopy];
    
    CGSize size = [self boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading  attributes:dict context:nil].size;
    
    NSInteger line = size.height / font.lineHeight;
    if (line > 1) {
        paragraphStyle.lineSpacing = lineSpacing;
        paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
        [dict setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
    }
    
    NSAttributedString * attriString = [[NSAttributedString alloc] initWithString:self attributes:dict];
    return attriString;
}

- (NSAttributedString *)attributedStringWithFont:(UIFont*)font
                                           color:(UIColor *)color
                                     lineSpacing:(CGFloat)lineSpacing{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing;
    NSDictionary * dict = @{NSFontAttributeName:font,
                            NSParagraphStyleAttributeName:paragraphStyle,
                            NSForegroundColorAttributeName:color
                            };
    
    NSAttributedString * attriString = [[NSAttributedString alloc] initWithString:self attributes:dict];
    return attriString;
}

- (NSAttributedString *)attributedStringWithFont:(UIFont*)font color:(UIColor *)color{
    NSDictionary * dict = @{NSFontAttributeName:font,
                            NSForegroundColorAttributeName:color
                            };
    
    NSAttributedString * attriString = [[NSAttributedString alloc] initWithString:self attributes:dict];
    return attriString;
}

- (NSAttributedString *)attributedStringWithFont:(UIFont*)font color:(UIColor *)color lineHeight:(CGFloat)lineHeight lineBreakMode:(NSLineBreakMode)lineBreakMode{
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.maximumLineHeight = lineHeight;
    paragraphStyle.minimumLineHeight = lineHeight;
    paragraphStyle.lineBreakMode = lineBreakMode;
    
    NSDictionary * dict = @{NSFontAttributeName:font,
                            NSParagraphStyleAttributeName:paragraphStyle,
                            NSForegroundColorAttributeName:color
                            };
    
    NSAttributedString * attriString = [[NSAttributedString alloc] initWithString:self attributes:dict];
    return attriString;
}

/**
 * 生成评分9.6-->可以设置整数部分的大小和小数部分的大小
 */
- (NSAttributedString *)attributedScoreForStringWithIntegerFont:(UIFont *)integerFont
                                                    decimalFont:(UIFont *)decimalFont
                                                          color:(UIColor *)color{
    NSArray *array = [self componentsSeparatedByString:@"."];
    NSString *integerPart = @"";
    NSString *decimalPart = @"";
    if (array.count == 2) {
        integerPart = array[0];
        decimalPart = array[1];
    }else if (array.count == 1){
        integerPart = array[0];
        decimalPart = @"0";
    }else{
        return nil;
    }
    
    integerPart = [integerPart stringByAppendingString:@"."];
    NSMutableAttributedString *integerPartAttrString = [[integerPart attributedStringWithFont:integerFont color:color] mutableCopy];
    
    NSAttributedString *decimalPartAttrString = [decimalPart attributedStringWithFont:decimalFont color:color];
    [integerPartAttrString appendAttributedString:decimalPartAttrString];
    
    return integerPartAttrString;
}


#pragma mark - private
#pragma mark helper


@end

