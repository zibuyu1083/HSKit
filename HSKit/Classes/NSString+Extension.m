//
//  NSString+Extension.m
//  Dingding
//
//  Created by 陈欢 on 14-2-27.
//  Copyright (c) 2014年 陈欢. All rights reserved.
//

#import "NSString+Extension.h"
#import <CommonCrypto/CommonDigest.h>
#import "sys/utsname.h"
#import "sys/sysctl.h"

#define NLSystemVersionGreaterOrEqualThan(version) ([[[UIDevice currentDevice] systemVersion] floatValue] >= version)
#define IOS7_OR_LATER NLSystemVersionGreaterOrEqualThan(7.0)

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1

#endif

@implementation NSString (Extension)

- (NSString *)replaceCharactersAtIndexes:(NSArray *)indexes withString:(NSString *)aString {
	NSAssert(indexes != nil, @"%s: indexes 不可以为nil", __PRETTY_FUNCTION__);
	NSAssert(aString != nil, @"%s: aString 不可以为nil", __PRETTY_FUNCTION__);

	NSUInteger offset = 0;
	NSMutableString *raw = [self mutableCopy];

	NSInteger prevLength = 0;
	for (NSInteger i = 0; i < [indexes count]; i++) {
		@autoreleasepool {
			NSRange range = [[indexes objectAtIndex:i] rangeValue];
			prevLength = range.length;

			range.location -= offset;
			[raw replaceCharactersInRange:range withString:aString];
			offset = offset + prevLength - [aString length];
		}
	}

	return raw;
}

- (NSString *)urlencode {
	NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
	                                                            NULL,
	                                                            (CFStringRef)self,
	                                                            NULL,
	                                                            (CFStringRef)@"!*'();:@&=+$,/?%#[]",
	                                                            kCFStringEncodingUTF8));
	if (encodedString) {
		return encodedString;
	}
	return @"";
}

- (NSString *)md5String {
	if (!self) {
		return nil;
	}
	const char *original_str = [self UTF8String];
	unsigned char digist[CC_MD5_DIGEST_LENGTH]; //CC_MD5_DIGEST_LENGTH = 16
	CC_MD5(original_str, (unsigned int)strlen(original_str), digist);
	NSMutableString *outPutStr = [NSMutableString stringWithCapacity:10];
	for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
		[outPutStr appendFormat:@"%02x", digist[i]];//小写x表示输出的是小写MD5，大写X表示输出的是大写MD5
	}
	return [outPutStr lowercaseString];
}

+ (NSString *)getCurrentDeviceModel {
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G (A1203)";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G (A1241/A1324)";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS (A1303/A1325)";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4 (A1349)";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4s (A1387/A1431)";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5 (A1428)";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (A1429/A1442)";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c (A1456/A1532)";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c (A1507/A1516/A1526/A1529)";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s (A1453/A1533)";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s (A1457/A1518/A1528/A1530)";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus (A1522/A1524)";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6 (A1549/A1586)";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G (A1213)";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G (A1288)";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G (A1318)";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G (A1367)";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G (A1421/A1509)";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G (A1219/A1337)";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2 (A1395)";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2 (A1396)";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2 (A1397)";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2 (A1395+New Chip)";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G (A1432)";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G (A1454)";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G (A1455)";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3 (A1416)";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3 (A1403)";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3 (A1430)";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4 (A1458)";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4 (A1459)";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4 (A1460)";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air (A1474)";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air (A1475)";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air (A1476)";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G (A1489)";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G (A1490)";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G (A1491)";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    return platform;
}

+ (BOOL)isEmptyString:(NSString *)string {
	if (string != nil && (id)string != [NSNull null]) {
		return [string isEmpty];
	}
	return YES;
}

+ (BOOL)isNotEmptyString:(NSString *)string {
	return ![NSString isEmptyString:string];
}

+ (NSString *)fromInt:(int)value {
	return [NSString stringWithFormat:@"%d", value];
}

+ (NSString *)fromLonglongInt:(long long int)value {
	return [NSString stringWithFormat:@"%lld", (long long int)value];
}

+ (NSString *)fromInteger:(NSInteger)value {
	return [NSString stringWithFormat:@"%ld", (long)value];
}

+ (NSString *)fromUInteger:(NSUInteger)value {
	return [NSString stringWithFormat:@"%lu", (unsigned long)value];
}

+ (NSString *)fromFloat:(float)value {
	return [NSString stringWithFormat:@"%f", value];
}

+ (NSString *)fromDouble:(double)value {
	return [NSString stringWithFormat:@"%f", value];
}

+ (NSString *)fromBool:(BOOL)value {
	return [NSString stringWithFormat:@"%d", value];
}

- (CGFloat)getDrawWidthWithFont:(UIFont *)font {
	CGFloat width = 0.f;

	CGSize textSize = CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX);
	NSDictionary *tdic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
	CGRect sizeWithFont = [self boundingRectWithSize:textSize
	                                         options:NSStringDrawingUsesLineFragmentOrigin
	                                      attributes:tdic
	                                         context:nil];

#if defined(__LP64__) && __LP64__
	width = ceil(CGRectGetWidth(sizeWithFont));
#else
	width = ceilf(CGRectGetWidth(sizeWithFont));
#endif

	return width;
}

- (CGFloat)getDrawHeightWithFont:(UIFont *)font Width:(CGFloat)width {
	CGFloat height = 0.f;

	CGSize textSize = CGSizeMake(width, CGFLOAT_MAX);
	NSDictionary *tdic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];

	CGRect sizeWithFont = [self boundingRectWithSize:textSize
	                                         options:NSStringDrawingUsesLineFragmentOrigin
	                                      attributes:tdic
	                                         context:nil];

#if defined(__LP64__) && __LP64__
	height = ceil(CGRectGetHeight(sizeWithFont));
#else
	height = ceilf(CGRectGetHeight(sizeWithFont));
#endif

	return height;
}

+ (CGFloat)fontHeight:(UIFont *)font {
	CGFloat height = 0.f;

	NSString *fontString = @"臒";
	CGSize textSize = CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX);
	NSDictionary *tdic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
	CGRect sizeWithFont = [fontString boundingRectWithSize:textSize
	                                               options:NSStringDrawingUsesLineFragmentOrigin
	                                            attributes:tdic
	                                               context:nil];

#if defined(__LP64__) && __LP64__
	height = ceil(CGRectGetHeight(sizeWithFont));
#else
	height = ceilf(CGRectGetHeight(sizeWithFont));
#endif

	return height;
}

- (BOOL)isEmpty {
	return ![self isNotEmpty];
}

- (BOOL)isNotEmpty {
	if (self != nil
	    && ![self isKindOfClass:[NSNull class]]
	    && (id)self != [NSNull null]
	    && [[self trimWhitespace] length] > 0) {
		return YES;
	}
	return NO;
}

- (NSInteger)actualLength {
	NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
	NSData *data = [self dataUsingEncoding:encoding];
	return [data length];
}

- (NSString *)trimWhitespace {
	NSString *string = [self stringByReplacingOccurrencesOfString:@"\n" withString:@""];
	string = [string stringByReplacingOccurrencesOfString:@"\t" withString:@""];
	string = [string stringByReplacingOccurrencesOfString:@"\r" withString:@""];
	string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
	return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)trimLeftAndRightWhitespace {
	return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)trimHTMLTag {
	NSString *html = self;

	NSScanner *scanner = [NSScanner scannerWithString:html];
	NSString *text = nil;

	while (![scanner isAtEnd]) {
		[scanner scanUpToString:@"<" intoString:NULL];
		[scanner scanUpToString:@">" intoString:&text];

		html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text]
		                                       withString:@""];
	}
	return [html trimWhitespace];
}

- (BOOL)isWhitespace {
	return [self isEmpty];
}

- (BOOL)isChinese {
	NSString *chineseRegEx = @"[^x00-xff]";
	if (![self isMatchesRegularExp:chineseRegEx]) {
		return NO;
	}
	return YES;
}

- (BOOL)isMatchesRegularExp:(NSString *)regex {
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
	return [predicate evaluateWithObject:self];
}

- (BOOL)isEmail {
	NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
	NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
	return [emailTest evaluateWithObject:self];
}

- (NSString *)URLRegularExp {
	static NSString *urlRegEx = @"((https?|ftp|gopher|telnet|file|notes|ms-help):((//)|(\\\\))+[\\w\\d:#@%/;$()~_?\\+-=\\\\.&]*)";
	return urlRegEx;
}

- (BOOL)isURL {
	NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", [self URLRegularExp]];
	return [urlTest evaluateWithObject:self];
}

- (NSArray *)URLList {
	NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:[self URLRegularExp]
	                                                                     options:NSRegularExpressionAnchorsMatchLines | NSRegularExpressionDotMatchesLineSeparators
	                                                                       error:nil];
	NSArray *matches = [reg matchesInString:self
	                                options:NSMatchingReportCompletion
	                                  range:NSMakeRange(0, self.length)];

	NSMutableArray *URLs = [[NSMutableArray alloc] init];
	for (NSTextCheckingResult *result in matches) {
		[URLs addObject:[self substringWithRange:result.range]];
	}
	return URLs;
}

- (BOOL)isCellPhoneNumber {
	NSString *cellPhoneRegEx = @"^1(3[0-9]|4[0-9]|5[0-9]|8[0-9])\\d{8}$";
	NSPredicate *cellPhoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", cellPhoneRegEx];
	return [cellPhoneTest evaluateWithObject:self];
}

- (BOOL)isPhoneNumber {
	NSString *phoneRegEx = @"((^0(10|2[0-9]|\\d{2,3})){0,1}-{0,1}(\\d{6,8}|\\d{6,8})$)";
	NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegEx];
	return [phoneTest evaluateWithObject:self];
}

- (BOOL)isZipCode {
	NSString *zipCodeRegEx = @"[1-9]\\d{5}$";
	NSPredicate *zipCodeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", zipCodeRegEx];
	return [zipCodeTest evaluateWithObject:self];
}

- (id)jsonObject:(NSError **)error {
	return [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding]
	                                       options:NSJSONReadingMutableContainers
	                                         error:error];
}

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxsize {
	NSDictionary *attrs = @{ NSFontAttributeName : font };
	return [self boundingRectWithSize:maxsize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (NSString *)stringCoverToTime {
	if (![self isNotEmpty]) {
		return @"";
	}

	NSInteger mins = [self integerValue];
    
    NSInteger hours = mins / 3600;
    NSInteger minss = (mins - hours * 3600) / 60;
    NSInteger ss = (mins - hours * 3600 - minss * 60) % 60;
	NSDateFormatter *formatter = [NSDateFormatter new];
	[formatter setDateFormat:@"mm:ss"];
	//NSDate *date = [NSDate dateWithTimeIntervalSinceNow:mins];
    NSMutableString *timeString = [NSMutableString string];
    if (hours <=0) {
        
    }else{
        [timeString appendFormat:@"0%ld:",hours];
    }
    
    if (minss < 10 && minss > 0) {
        [timeString appendFormat:@"0%ld:",minss];
    }else if (minss >= 10){
        [timeString appendFormat:@"%ld:",minss];
    }else{
        [timeString appendString:@"00:"];
    }
    
    if (ss < 10 && ss > 0) {
        [timeString appendFormat:@"0%ld",ss];
    }else if (ss >= 10){
        [timeString appendFormat:@"%ld",ss];
    }else if (ss == 0){
        [timeString appendString:@"00"];
    }
    
//    NSDate *date = [NSDate dateWithTimeInterval:mins sinceDate:[NSDate dateWithTimeIntervalSinceReferenceDate:0]];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
//    if (mins / 3600 >= 1) {
//        [formatter setDateFormat:@"HH:mm:ss"];
//    }else{
//        [formatter setDateFormat:@"mm:ss"];
//    }
	return timeString;
}

- (CGSize)calculateSizeWithText:(CGFloat)font
{
    CGSize size = [self sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:font]}];
    CGSize adjustedSize = CGSizeMake(ceilf(size.width), ceilf(size.height));
    return adjustedSize;
}
- (NSString *)replaceWithKeyWord:(NSString *)regString replace:(NSString *)str {
    NSRegularExpression *regExpression = [NSRegularExpression regularExpressionWithPattern:regString options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *resultString =  [regExpression stringByReplacingMatchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, self.length) withTemplate:str];
    return resultString;
}
- (NSString *)replaceSpace{
    if (![self isKindOfClass:[NSString class]]) {
        return nil;
    }
    if (self.length <= 0) {
        return nil;
    }
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}
@end
