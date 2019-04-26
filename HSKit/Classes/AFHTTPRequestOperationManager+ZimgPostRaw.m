//
//  AFHTTPRequestOperationManager+ZimgPostRaw.m
//  ZimgUploadDemo
//
//  Created by hejianyuan on 15/11/6.
//  Copyright © 2015年 thinkcode. All rights reserved.
//

#import "AFHTTPRequestOperationManager+ZimgPostRaw.h"

@implementation AFHTTPSessionManager (ZimgPostRaw)

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                     contentType:(NSString *)contentType
        constructingBodyWithData:(NSData *)data
                         success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
                         failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];
    //[request setValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    
//    __block NSURLSessionDataTask *task = [self uploadTaskWithStreamedRequest:request progress:uploadProgress completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
    __block NSURLSessionDataTask *task = [self uploadTaskWithStreamedRequest:request progress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            if (failure) {
                failure(task, error);
            }
        } else {
            if (success) {
                success(task, responseObject);
            }
        }
    }];
    
    [task resume];
    
    return task;
}


//- (NSURLSessionTask *)downloadData:(NSString *)URLString
//                           success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
//                           failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure{
//
//    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLString]];
//    [request setHTTPMethod:@"GET"];
//
//    __block NSURLSessionDataTask * task = [self dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//        if (error) {
//            if (failure) {
//                failure(task, error);
//            }
//        } else {
//            if (success) {
//                success(task, responseObject);
//            }
//        }
//    }];
//
//    [task resume];
//    return task;
//}

- (NSURLSessionTask *)downloadData:(NSMutableURLRequest *)URLRequest
                           success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
                           failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure{
    [URLRequest setHTTPMethod:@"GET"];
    
    __block NSURLSessionDataTask * task = [self dataTaskWithRequest:URLRequest completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            if (failure) {
                failure(task, error);
            }
        } else {
            if (success) {
                success(task, responseObject);
            }
        }
    }];
    
    [task resume];
    return task;

}

@end
