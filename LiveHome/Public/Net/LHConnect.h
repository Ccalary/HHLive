//
//  LHConnect.h
//  LiveHome
//
//  Created by chh on 2017/11/6.
//  Copyright © 2017年 chh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpUtility.h"

@interface LHConnect : NSObject
+ (NSMutableDictionary *_Nullable)getBaseRequestParams;
#pragma mark - 个人中心模块
/**
 * 反馈
 */
+(void)postFeedback:(NSMutableDictionary *_Nullable) params loading:(NSString *_Nullable)text success:(void (^_Nullable)(ApiResultData * _Nullable data))success  failure:(void (^_Nullable)(ApiResultData * _Nullable data))failure;

#pragma mark - /***********************注册登录***************************/
/**
 * 登录
 */
+(void)postLogin:(NSMutableDictionary *_Nullable) params loading:(NSString *_Nullable)text success:(void (^_Nullable)(ApiResultData * _Nullable data))success  failure:(void (^_Nullable)(ApiResultData * _Nullable data))failure;

/**
 * 注册
 */
+(void)postRegister:(NSMutableDictionary *_Nullable) params loading:(NSString *_Nullable)text success:(void (^_Nullable)(ApiResultData * _Nullable data))success  failure:(void (^_Nullable)(ApiResultData * _Nullable data))failure;

/**
 * 忘记密码
 */
+(void)postForgetPsd:(NSMutableDictionary *_Nullable) params loading:(NSString *_Nullable)text success:(void (^_Nullable)(ApiResultData * _Nullable data))success  failure:(void (^_Nullable)(ApiResultData * _Nullable data))failure;

/**
 * 发送短信验证码
 */
+(void)postSendSms:(NSMutableDictionary *_Nullable) params loading:(NSString *_Nullable)text success:(void (^_Nullable)(ApiResultData * _Nullable data))success  failure:(void (^_Nullable)(ApiResultData * _Nullable data))failure;

/**
 更改手机号
 */
+(void)postChangeMobile:(NSMutableDictionary *_Nullable) params loading:(NSString *_Nullable)text success:(void (^_Nullable)(ApiResultData * _Nullable data))success  failure:(void (^_Nullable)(ApiResultData * _Nullable data))failure;
@end
