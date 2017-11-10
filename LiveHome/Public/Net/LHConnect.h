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
 * 获取用户信息
 */
+(void)postUserInfo:(NSMutableDictionary *_Nullable) params loading:(NSString *_Nullable)text success:(void (^_Nullable)(ApiResultData * _Nullable data))success  failure:(void (^_Nullable)(ApiResultData * _Nullable data))failure;

/**
 * 更新用户信息
 */
+(void)postUpdateUserInfo:(NSMutableDictionary *_Nullable) params loading:(NSString *_Nullable)text success:(void (^_Nullable)(ApiResultData * _Nullable data))success  failure:(void (^_Nullable)(ApiResultData * _Nullable data))failure;

/**
 * 上传图片资源
 */
+(void)uploadImageResource:(NSMutableDictionary *_Nullable) params files:(NSArray *_Nullable)files success:(void (^_Nullable)(ApiResultData * _Nullable data))success  failure:(void (^_Nullable)(ApiResultData * _Nullable data))failure;

/**
 * 反馈
 */
+(void)postFeedback:(NSMutableDictionary *_Nullable) params loading:(NSString *_Nullable)text success:(void (^_Nullable)(ApiResultData * _Nullable data))success  failure:(void (^_Nullable)(ApiResultData * _Nullable data))failure;

/**
 * 实名认证
 */
+(void)postCertification:(NSMutableDictionary *_Nullable) params loading:(NSString *_Nullable)text success:(void (^_Nullable)(ApiResultData * _Nullable data))success  failure:(void (^_Nullable)(ApiResultData * _Nullable data))failure;

/**
 * 余额信息
 */
+(void)postWalletWalletMoney:(NSMutableDictionary *_Nullable) params loading:(NSString *_Nullable)text success:(void (^_Nullable)(ApiResultData * _Nullable data))success  failure:(void (^_Nullable)(ApiResultData * _Nullable data))failure;

/**
 * 钱包账单
 */
+(void)postWalletWalletMoneyLog:(NSMutableDictionary *_Nullable) params loading:(NSString *_Nullable)text success:(void (^_Nullable)(ApiResultData * _Nullable data))success  failure:(void (^_Nullable)(ApiResultData * _Nullable data))failure;

/**
 * 添加银行卡
 */
+(void)postWalletAddBankCard:(NSMutableDictionary *_Nullable) params loading:(NSString *_Nullable)text success:(void (^_Nullable)(ApiResultData * _Nullable data))success  failure:(void (^_Nullable)(ApiResultData * _Nullable data))failure;

/**
 * 获取银行卡类型
 */
+(void)postWalletGetCardType:(NSMutableDictionary *_Nullable) params loading:(NSString *_Nullable)text success:(void (^_Nullable)(ApiResultData * _Nullable data))success  failure:(void (^_Nullable)(ApiResultData * _Nullable data))failure;

/**
 * 获取银行卡列表
 */
+(void)postWalletBankCard:(NSMutableDictionary *_Nullable) params loading:(NSString *_Nullable)text success:(void (^_Nullable)(ApiResultData * _Nullable data))success  failure:(void (^_Nullable)(ApiResultData * _Nullable data))failure;

/**
 * 提现
 */
+(void)postWalletWithdrawals:(NSMutableDictionary *_Nullable) params loading:(NSString *_Nullable)text success:(void (^_Nullable)(ApiResultData * _Nullable data))success  failure:(void (^_Nullable)(ApiResultData * _Nullable data))failure;

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
