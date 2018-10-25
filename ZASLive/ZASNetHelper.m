//
//  ZASNetHelper.m
//  BLBYJSDK
//
//  Created by ashen on 2018/8/14.
//  Copyright © 2018年 <http://www.devashen.com>. All rights reserved.
//

#import "ZASNetHelper.h"
#import "AFNetworking.h"


@implementation ZASNetHelper

+ (void)request:(NSString *)url parameters:(NSDictionary *)parameters success:(ZASSuccessBlock)success
            failure:(ZASFailureBlock)failure {
 
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)requestPlatFormListWithParames:(NSDictionary *)parameters success:(ZASSuccessBlock)success
                failure:(ZASFailureBlock)failure {
    [self request:@"http://www.quanmin.tv/json/categories/list.json" parameters:nil success:success failure:failure];
}

+ (void)requestPlatFormRoomsWithParames:(NSString *)plat success:(ZASSuccessBlock)success
                            failure:(ZASFailureBlock)failure {
    NSString *url = [NSString stringWithFormat:@"http://www.quanmin.tv/json/categories/%@/list.json",plat];
    [self request:url parameters:nil success:success failure:failure];
}

@end
