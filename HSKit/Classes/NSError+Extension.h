//
//  NSError+Extension.h
//  FilmSiteClient
//
//  Created by hejianyuan on 2018/3/29.
//  Copyright © 2018年 陈虎. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (Extension)

+ (instancetype)errorWithDomain:(NSErrorDomain)domain code:(NSInteger)code description:(NSString *)description;


@end
