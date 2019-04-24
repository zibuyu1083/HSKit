//
//  NSString+Extension.h
//  Dingding
//
//  Created by 陈欢 on 14-2-27.
//  Copyright (c) 2014年 陈欢. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

/**
 *  替换字符串
 *
 *  @param indexes indexes
 *  @param aString 字符串
 *
 *  @return 替换后的字符串
 */
- (NSString *)replaceCharactersAtIndexes:(NSArray *)indexes withString:(NSString *)aString;

/**
 *  urlencode
 *
 *  @return urlencode值
 */
- (NSString *)urlencode;

/**
 *  md5字符串
 *
 *  @return md5加密后的字符串
 */
- (NSString *)md5String;

/**
 *  获得设备型号
 *
 *  @return 设备型号
 */
+ (NSString *)getCurrentDeviceModel;

/**
 *  是否是空字符串
 *
 *  @param string 字符串
 *
 *  @return 是否是空字符串
 */
+ (BOOL)isEmptyString:(NSString *)string;

/**
 *  是否不是空字符串
 *
 *  @param string 字符串
 *
 *  @return 是否不是空字符串
 */
+ (BOOL)isNotEmptyString:(NSString *)string;

/**
 *  Int->NSString
 *
 *  @param value Int值
 *
 *  @return 转换之后的字符串
 */
+ (NSString *)fromInt:(int)value;

/**
 *  LonglongInt->NSString
 *
 *  @param value LonglongInt值
 *
 *  @return 转换之后的字符串
 */
+ (NSString *)fromLonglongInt:(long long int)value;

/**
 *  Integer->NSString
 *
 *  @param value Integer值
 *
 *  @return 转换之后的字符串
 */
+ (NSString *)fromInteger:(NSInteger)value;

/**
 *  UInteger->NSString
 *
 *  @param value UInteger值
 *
 *  @return 转换之后的字符串
 */
+ (NSString *)fromUInteger:(NSUInteger)value;

/**
 *  Float->NSString
 *
 *  @param value Float值
 *
 *  @return 转换之后的字符串
 */
+ (NSString *)fromFloat:(float)value;

/**
 *  Double->NSString
 *
 *  @param value Double值
 *
 *  @return 转换之后的字符串
 */
+ (NSString *)fromDouble:(double)value;

/**
 *  BOOL->NSString
 *
 *  @param value BOOL值
 *
 *  @return 转换之后的字符串
 */
+ (NSString *)fromBool:(BOOL)value;

/**
 *  获得字体高度
 *
 *  @param font 字体
 *
 *  @return 返回字体高度
 */
+ (CGFloat)fontHeight:(UIFont *)font;

/**
 *  计算字体宽度
 *
 *  @param font 字体
 *
 *  @return 返回字体宽度
 */
- (CGFloat)getDrawWidthWithFont:(UIFont *)font;

/**
 *  根据宽度计算字体高度
 *
 *  @param font  字体
 *  @param width 宽度
 *
 *  @return 返回字体高度
 */
- (CGFloat)getDrawHeightWithFont:(UIFont *)font Width:(CGFloat)width;

/**
 *  是否为空
 *
 *  @return 是否为空
 */
- (BOOL)isEmpty;

/**
 *  是否不为空
 *
 *  @return 是否不为空
 */
- (BOOL)isNotEmpty;

/**
 *  是否中文
 *
 *  @return 是否中文
 */
- (BOOL)isChinese;

/**
 *  是否匹配正则表达式
 *
 *  @param regex 正则表达式
 *
 *  @return 是否匹配
 */
- (BOOL)isMatchesRegularExp:(NSString *)regex;

/**
 *  是否是电话号码
 *
 *  @return 是否是电话号码
 */
- (BOOL)isCellPhoneNumber;

/**
 *  是否是手机号
 *
 *  @return 是否是手机号
 */
- (BOOL)isPhoneNumber;
/**
 *  计算字符串的尺寸
 *
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxsize;
/**
 *  字符串转换成时间格式
 */
-(NSString *)stringCoverToTime;

/**
 *  通过字符串的字号和字符串的长度来确定文本框的大小
 *
 *  @return 文本框的大小
 */
//通过文字设定文本框的大小(适配ios9字体的问题)
- (CGSize)calculateSizeWithText:(CGFloat)font;

/**
 *  替换字符串中的关键字
 *
 *  @param regString    正则表达式
 *  @param str          替换成目标字符
 *
 *  @return 替换完成的字符串
 */
- (NSString *)replaceWithKeyWord:(NSString *)regString replace:(NSString *)str;
/**
 *  去掉空格
 */
- (NSString *)replaceSpace;
@end
