//
//  LHConnect.m
//  LiveHome
//
//  Created by chh on 2017/11/6.
//  Copyright © 2017年 chh. All rights reserved.
//

#import "LHConnect.h"


@implementation LHConnect
+ (NSMutableDictionary *_Nullable)getBaseRequestParams
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    return params;
}

/****************************注册登录*************************/
/**
 * 登录
 */
+(void)postLogin:(NSMutableDictionary *_Nullable) params loading:(NSString *_Nullable)text success:(void (^_Nullable)(ApiResultData * _Nullable data))success  failure:(void (^_Nullable)(ApiResultData * _Nullable data))failure{
    [[HttpUtility sharedInstance] POST:Login loadingText:text parameters:params progress:nil success:^(ApiResultData * _Nullable data) {
        success(data);
    } failure:^(ApiResultData * _Nullable data) {
        failure(data);
    }];
}

/**
 * 注册
 */
+(void)postRegister:(NSMutableDictionary *_Nullable) params loading:(NSString *_Nullable)text success:(void (^_Nullable)(ApiResultData * _Nullable data))success  failure:(void (^_Nullable)(ApiResultData * _Nullable data))failure{
    [[HttpUtility sharedInstance] POST:Register loadingText:text parameters:params progress:nil success:^(ApiResultData * _Nullable data) {
        success(data);
    } failure:^(ApiResultData * _Nullable data) {
        failure(data);
    }];
}

/**
 * 忘记密码
 */
+(void)postForgetPsd:(NSMutableDictionary *_Nullable) params loading:(NSString *_Nullable)text success:(void (^_Nullable)(ApiResultData * _Nullable data))success  failure:(void (^_Nullable)(ApiResultData * _Nullable data))failure{
    [[HttpUtility sharedInstance] POST:ForgetPwd loadingText:text parameters:params progress:nil success:^(ApiResultData * _Nullable data) {
        success(data);
    } failure:^(ApiResultData * _Nullable data) {
        failure(data);
    }];
}

/**
 发送短信验证码
 */
+(void)postSendSms:(NSMutableDictionary *_Nullable) params loading:(NSString *_Nullable)text success:(void (^_Nullable)(ApiResultData * _Nullable data))success  failure:(void (^_Nullable)(ApiResultData * _Nullable data))failure
{
    [[HttpUtility sharedInstance] POST:SendSms loadingText:text parameters :params progress:nil
                               success:^(ApiResultData * _Nullable data) {
                                   success(data);
                               }failure:^(ApiResultData * _Nullable data) {
                                   failure(data);
                               }];
}

@end
