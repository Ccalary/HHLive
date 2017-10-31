//
//  UserHelper.h
//  LiveHome
//
//  Created by chh on 2017/10/27.
//  Copyright © 2017年 chh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserHelper : NSObject
//是否登录
+(BOOL)IsLogin;
//保存登录信息
+(void)setLogInfo:(NSDictionary *)dic;
//退出
+(void)logout;
@end
