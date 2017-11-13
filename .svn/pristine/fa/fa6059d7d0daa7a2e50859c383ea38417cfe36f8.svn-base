//
//  UserHelper.m
//  LiveHome
//
//  Created by chh on 2017/10/27.
//  Copyright © 2017年 chh. All rights reserved.
//

#import "UserHelper.h"

@implementation UserHelper

#pragma mark - 登录信息
//是否登录
+(BOOL)isLogin{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *isLogin = [defaults objectForKey:@"isLogin"];
    return [isLogin isEqualToString:@"1"];
}
//保存登录信息
+(void)setLogInfo:(NSDictionary *)dic{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"1" forKey:@"isLogin"];//登录
    [defaults setObject:[dic objectForKey:@"auth"] forKey:@"auth"];//auth
    [defaults setObject:[dic objectForKey:@"id"] forKey:@"userId"];//id
    [defaults setObject:[dic objectForKey:@"t"] forKey:@"RongCloudToken"];//融云token
    [defaults synchronize];
}

//保存用户信息
+(void)setUserInfo:(NSDictionary *)dic{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:dic forKey:@"userInfo"];//UserInfoModel 信息
    [defaults synchronize];
}

//退出
+(void)logout{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"0" forKey:@"isLogin"];
    [defaults setObject:@""  forKey:@"auth"];
    [defaults setObject:@""  forKey:@"userId"];
    [defaults setObject:@""  forKey:@"RongCloudToken"];
    [defaults setObject:nil forKey:@"userInfo"];
    [defaults synchronize];
}

/** 获得用户信息 */
+ (NSDictionary *)getUserInfo{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userInfo = [defaults objectForKey:@"userInfo"];
    return userInfo;
}

/** 获得auth */
+ (NSString *)getMemberAuth{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *auth = [defaults objectForKey:@"auth"];
    return auth;
}

/** 获得userId*/
+ (NSString *)getMemberId{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userId = [defaults objectForKey:@"userId"];
    return userId;
}

/** 获得融云Token */
+ (NSString *)getRongCloudToken{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:@"RongCloudToken"];
    return token;
}
@end
