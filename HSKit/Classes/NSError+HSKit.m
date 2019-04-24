//
//  NSError+HSKit.m
//  CCTV6Film
//
//  Created by hejianyuan on 2018/3/15.
//  Copyright © 2018年 Chelio. All rights reserved.
//

#import "NSError+HSKit.h"

@implementation NSError (HSKit)

+ (NSError *)errorWithDomain:(NSErrorDomain)domain
                           code:(NSInteger)code
                    description:(NSString *)description
                         reason:(NSString *)reason{
    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    if (description) [userInfo setObject:description forKey:NSLocalizedDescriptionKey];
    if (reason) [userInfo setObject:description forKey:NSLocalizedFailureReasonErrorKey];
    NSError *error = [[NSError alloc] initWithDomain:domain code:code userInfo:userInfo];
    return error;
}



@end
