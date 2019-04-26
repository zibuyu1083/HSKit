//
//  NSString+HSKit.h
//  DSCloudVision
//
//  Created by hejianyuan on 2016/10/18.
//  Copyright © 2016年 ThinkCode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (HSKit)

/**
 * 用于版本号比较需要字符串都是【点分十进制】比如 "2.0.4" "1.0"等
 *  @return 如果都不是点分十进制，返回 NSNotFound
 */
- (NSComparisonResult)versionCompare:(NSString *)aVersionString;


/**
 *  是否是空的字符串
 *  @return YES:空字符串  NO:非空字符串
 */
+ (BOOL)isBlankString:(NSString *)aString;


/**
 *  是否是特殊字符串
 *  @return YES:特殊字符串  NO:非特殊字符串
 */
+ (BOOL)isSpecialString:(NSString *)sString;


/**
 *  是否是手机号码
 *  @return YES:是手机号码  NO:非手机号码
 */
+ (BOOL)isPhoneString:(NSString *)pString;

/**
 *  是否是数字
 *  @return YES:是数字  NO:非数字
 */
+ (BOOL)isDigitalString:(NSString *)dString;


/**
 *  计算文字的显示大小和宽度
 */

- (CGFloat)textHeightWithFont:(UIFont *)font
                lineBreakMode:(NSLineBreakMode)lineBreakMode
                     maxWidth:(CGFloat)maxWidth;

- (CGFloat)textHeightWithFont:(UIFont *)font
                  lineSpacing:(CGFloat)lineSpacing
                     maxWidth:(CGFloat)maxWidth;


- (CGFloat)textHeightWithFont:(UIFont *)font
                   lineHeight:(CGFloat)lineHeight
                     maxWidth:(CGFloat)maxWidth;

- (CGFloat)textHeightWithFont:(UIFont *)font
                lineBreakMode:(NSLineBreakMode)lineBreakMode
               paragraphStyle:(NSParagraphStyle *)paragraphStyle
                      axWidth:(CGFloat)maxWidth;

- (CGFloat)textWidthWithFont:(UIFont *)font;

- (CGFloat)textWidthWithFont:(UIFont *)font
               lineBreakMode:(NSLineBreakMode)lineBreakMode;

- (NSAttributedString *)attributedStringWithFont:(UIFont*)font
                                           color:(UIColor *)color
                                     lineSpacing:(CGFloat)lineSpacing
                                        maxWidth:(CGFloat)maxWidth;


- (NSAttributedString *)attributedStringWithFont:(UIFont*)font
                                           color:(UIColor *)color
                                     lineSpacing:(CGFloat)lineSpacing;


- (NSAttributedString *)attributedStringWithFont:(UIFont*)font
                                           color:(UIColor *)color
                                      lineHeight:(CGFloat)lineHeight
                                   lineBreakMode:(NSLineBreakMode)lineBreakMode;


- (NSAttributedString *)attributedStringWithFont:(UIFont*)font
                                           color:(UIColor *)color;


/**
 * 生成评分9.6-->可以设置整数部分的大小和小数部分的大小
 */
- (NSAttributedString *)attributedScoreForStringWithIntegerFont:(UIFont *)integerFont
                                                    decimalFont:(UIFont *)decimalFont
                                                          color:(UIColor *)color;




@end
