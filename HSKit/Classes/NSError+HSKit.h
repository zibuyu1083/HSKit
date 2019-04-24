//
//  NSError+HSKit.h
//  CCTV6Film
//
//  Created by hejianyuan on 2018/3/15.
//  Copyright © 2018年 Chelio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (HSKit)

+ (NSError *)errorWithDomain:(NSErrorDomain)domain
                           code:(NSInteger)code
                    description:(NSString *)description
                         reason:(NSString *)reason;
@end
