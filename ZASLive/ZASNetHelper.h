//
//  ZASNetHelper.h
//  BLBYJSDK
//
//  Created by ashen on 2018/8/14.
//  Copyright © 2018年 <http://www.devashen.com>. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ZASSuccessBlock)(id response);
typedef void (^ZASFailureBlock)(NSError * error);

@interface ZASNetHelper : NSObject

+ (void)requestPlatFormListWithParames:(NSDictionary *)parameters success:(ZASSuccessBlock)success
                               failure:(ZASFailureBlock)failure;

+ (void)requestPlatFormRoomsWithParames:(NSString *)parameters success:(ZASSuccessBlock)success
                                failure:(ZASFailureBlock)failure;

@end
