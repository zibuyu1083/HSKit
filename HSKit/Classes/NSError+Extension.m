//
//  NSError+Extension.m
//  FilmSiteClient
//
//  Created by hejianyuan on 2018/3/29.
//  Copyright © 2018年 陈虎. All rights reserved.
//

#import "NSError+Extension.h"

@implementation NSError (Extension)

+ (instancetype)errorWithDomain:(NSErrorDomain)domain code:(NSInteger)code description:(NSString *)description{
    NSDictionary *userInfo = @{NSLocalizedDescriptionKey:description?:@""};
    NSError *error = [[NSError alloc] initWithDomain:domain
                                                code:code
                                            userInfo:userInfo];
    
    return error;
}

@end
