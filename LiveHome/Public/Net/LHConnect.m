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

#pragma mark - 直播模块
/**
 * 直播房间信息接口
 */
+(void)postLiveRoomInfo:(NSMutableDictionary *_Nullable) params loading:(NSString *_Nullable)text success:(void (^_Nullable)(ApiResultData * _Nullable data))success  failure:(void (^_Nullable)(ApiResultData * _Nullable data))failure{
    [[HttpUtility sharedInstance] POST:LiveRoomInfo loadingText:text parameters:params progress:nil success:^(ApiResultData * _Nullable data) {
        success(data);
    } failure:^(ApiResultData * _Nullable data) {
        failure(data);
    }];
}

/**
 * 直播推流接口
 */
+(void)postLiveGetAddress:(NSMutableDictionary *_Nullable) params loading:(NSString *_Nullable)text success:(void (^_Nullable)(ApiResultData * _Nullable data))success  failure:(void (^_Nullable)(ApiResultData * _Nullable data))failure{
    [[HttpUtility sharedInstance] POST:LiveGetAddress loadingText:text parameters:params progress:nil success:^(ApiResultData * _Nullable data) {
        success(data);
    } failure:^(ApiResultData * _Nullable data) {
        failure(data);
    }];
}

/**
 * 上传直播间信息
 */
+(void)postLiveUpdateMyRoom:(NSMutableDictionary *_Nullable) params loading:(NSString *_Nullable)text success:(void (^_Nullable)(ApiResultData * _Nullable data))success  failure:(void (^_Nullable)(ApiResultData * _Nullable data))failure{
    [[HttpUtility sharedInstance] POST:LiveUpdateMyRoom loadingText:text parameters:params progress:nil success:^(ApiResultData * _Nullable data) {
        success(data);
    } failure:^(ApiResultData * _Nullable data) {
        failure(data);
    }];
}

/**
 * 观众列表接口
 */
+(void)postLiveRoomUsers:(NSMutableDictionary *_Nullable) params loading:(NSString *_Nullable)text success:(void (^_Nullable)(ApiResultData * _Nullable data))success  failure:(void (^_Nullable)(ApiResultData * _Nullable data))failure{
    [[HttpUtility sharedInstance] POST:LiveRoomUsers loadingText:text parameters:params progress:nil success:^(ApiResultData * _Nullable data) {
        success(data);
    } failure:^(ApiResultData * _Nullable data) {
        failure(data);
    }];
}
#pragma mark - 个人中心模块

/**
 * 获取用户信息
 */
+(void)postUserInfo:(NSMutableDictionary *_Nullable) params loading:(NSString *_Nullable)text success:(void (^_Nullable)(ApiResultData * _Nullable data))success  failure:(void (^_Nullable)(ApiResultData * _Nullable data))failure{
    [[HttpUtility sharedInstance] POST:UserInfo loadingText:text parameters:params progress:nil success:^(ApiResultData * _Nullable data) {
        success(data);
    } failure:^(ApiResultData * _Nullable data) {
        failure(data);
    }];
}

/**
 * 更新用户信息
 */
+(void)postUpdateUserInfo:(NSMutableDictionary *_Nullable) params loading:(NSString *_Nullable)text success:(void (^_Nullable)(ApiResultData * _Nullable data))success  failure:(void (^_Nullable)(ApiResultData * _Nullable data))failure{
    [[HttpUtility sharedInstance] POST:UpdateUserInfo loadingText:text parameters:params progress:nil success:^(ApiResultData * _Nullable data) {
        success(data);
    } failure:^(ApiResultData * _Nullable data) {
        failure(data);
    }];
}

/**
 * 上传图片资源
 */
+(void)uploadImageResource:(NSMutableDictionary *_Nullable) params files:(NSArray *_Nullable)files success:(void (^_Nullable)(ApiResultData * _Nullable data))success  failure:(void (^_Nullable)(ApiResultData * _Nullable data))failure{
    
    [[HttpUtility sharedInstance] uploadImage:HomeResource parameters:params files:files progress:nil success:^(ApiResultData * _Nullable data) {
         success(data);
    } failure:^(ApiResultData * _Nullable data) {
        failure(data);
    }];
}

/**
 * 反馈
 */
+(void)postFeedback:(NSMutableDictionary *_Nullable) params loading:(NSString *_Nullable)text success:(void (^_Nullable)(ApiResultData * _Nullable data))success  failure:(void (^_Nullable)(ApiResultData * _Nullable data))failure{
    [[HttpUtility sharedInstance] POST:FeedBack loadingText:text parameters:params progress:nil success:^(ApiResultData * _Nullable data) {
        success(data);
    } failure:^(ApiResultData * _Nullable data) {
        failure(data);
    }];
}

/**
 * 实名认证
 */
+(void)postCertification:(NSMutableDictionary *_Nullable) params loading:(NSString *_Nullable)text success:(void (^_Nullable)(ApiResultData * _Nullable data))success  failure:(void (^_Nullable)(ApiResultData * _Nullable data))failure{
    [[HttpUtility sharedInstance] POST:Certification loadingText:text parameters:params progress:nil success:^(ApiResultData * _Nullable data) {
        success(data);
    } failure:^(ApiResultData * _Nullable data) {
        failure(data);
    }];
}

/**
 * 余额信息
 */
+(void)postWalletWalletMoney:(NSMutableDictionary *_Nullable) params loading:(NSString *_Nullable)text success:(void (^_Nullable)(ApiResultData * _Nullable data))success  failure:(void (^_Nullable)(ApiResultData * _Nullable data))failure{
    [[HttpUtility sharedInstance] POST:WalletWalletMoney loadingText:text parameters:params progress:nil success:^(ApiResultData * _Nullable data) {
        success(data);
    } failure:^(ApiResultData * _Nullable data) {
        failure(data);
    }];
}

/**
 * 钱包账单
 */
+(void)postWalletWalletMoneyLog:(NSMutableDictionary *_Nullable) params loading:(NSString *_Nullable)text success:(void (^_Nullable)(ApiResultData * _Nullable data))success  failure:(void (^_Nullable)(ApiResultData * _Nullable data))failure{
    [[HttpUtility sharedInstance] POST:WalletWalletMoneyLog loadingText:text parameters:params progress:nil success:^(ApiResultData * _Nullable data) {
        success(data);
    } failure:^(ApiResultData * _Nullable data) {
        failure(data);
    }];
}

/**
 * 添加银行卡
 */
+(void)postWalletAddBankCard:(NSMutableDictionary *_Nullable) params loading:(NSString *_Nullable)text success:(void (^_Nullable)(ApiResultData * _Nullable data))success  failure:(void (^_Nullable)(ApiResultData * _Nullable data))failure{
    [[HttpUtility sharedInstance] POST:WalletAddBankCard loadingText:text parameters:params progress:nil success:^(ApiResultData * _Nullable data) {
        success(data);
    } failure:^(ApiResultData * _Nullable data) {
        failure(data);
    }];
}

/**
 * 获取银行卡类型
 */
+(void)postWalletGetCardType:(NSMutableDictionary *_Nullable) params loading:(NSString *_Nullable)text success:(void (^_Nullable)(ApiResultData * _Nullable data))success  failure:(void (^_Nullable)(ApiResultData * _Nullable data))failure{
    [[HttpUtility sharedInstance] POST:WalletGetCardType loadingText:text parameters:params progress:nil success:^(ApiResultData * _Nullable data) {
        success(data);
    } failure:^(ApiResultData * _Nullable data) {
        failure(data);
    }];
}

/**
 * 获取银行卡列表
 */
+(void)postWalletBankCard:(NSMutableDictionary *_Nullable) params loading:(NSString *_Nullable)text success:(void (^_Nullable)(ApiResultData * _Nullable data))success  failure:(void (^_Nullable)(ApiResultData * _Nullable data))failure{
    [[HttpUtility sharedInstance] POST:WalletBankCard loadingText:text parameters:params progress:nil success:^(ApiResultData * _Nullable data) {
        success(data);
    } failure:^(ApiResultData * _Nullable data) {
        failure(data);
    }];
}

/**
 * 提现
 */
+(void)postWalletWithdrawals:(NSMutableDictionary *_Nullable) params loading:(NSString *_Nullable)text success:(void (^_Nullable)(ApiResultData * _Nullable data))success  failure:(void (^_Nullable)(ApiResultData * _Nullable data))failure{
    [[HttpUtility sharedInstance] POST:WalletWithdrawals loadingText:text parameters:params progress:nil success:^(ApiResultData * _Nullable data) {
        success(data);
    } failure:^(ApiResultData * _Nullable data) {
        failure(data);
    }];
}
#pragma mark - ****************************注册登录*************************
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

/**
 更改手机号
 */
+(void)postChangeMobile:(NSMutableDictionary *_Nullable) params loading:(NSString *_Nullable)text success:(void (^_Nullable)(ApiResultData * _Nullable data))success  failure:(void (^_Nullable)(ApiResultData * _Nullable data))failure
{
    [[HttpUtility sharedInstance] POST:BangdingMobile loadingText:text parameters :params progress:nil
                               success:^(ApiResultData * _Nullable data) {
                                   success(data);
                               }failure:^(ApiResultData * _Nullable data) {
                                   failure(data);
                               }];
}
@end
