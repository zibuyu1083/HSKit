//
//  AFHTTPRequestOperationManager+ZimgPostRaw.h
//  ZimgUploadDemo
//
//  Created by hejianyuan on 15/11/6.
//  Copyright © 2015年 thinkcode. All rights reserved.
//

#import "AFNetworking.h"

@interface AFHTTPSessionManager (ZimgPostRaw)

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                      contentType:(NSString *)contentType
        constructingBodyWithData:(NSData *)data
                         success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
                         failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

//- (NSURLSessionTask *)downloadData:(NSString *)URLString
//                           success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
//                           failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

- (NSURLSessionTask *)downloadData:(NSMutableURLRequest *)URLRequest
                           success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
                           failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;
@end


