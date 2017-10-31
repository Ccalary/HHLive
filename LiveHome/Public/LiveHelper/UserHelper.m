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
+(BOOL)IsLogin{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *isLogin=[defaults objectForKey:@"isLogin"];
    return [isLogin isEqualToString:@"1"];
}
//保存登录信息
+(void)setLogInfo:(NSDictionary *)dic{
    NSUserDefaults *de=[NSUserDefaults standardUserDefaults];
    [de setObject:@"1" forKey:@"isLogin"];//登录
    [de setObject:[dic objectForKey:@"portrait"] forKey:@"portrait"];//头像
    [de setObject:[dic objectForKey:@"addressId"] forKey:@"addressId"];
    [de setObject:[dic objectForKey:@"isTouGaoRen"] forKey:@"isTouGaoRen"];//是否进行投稿认证 0 否 1是
    [de setObject:[dic objectForKey:@"memberName"] forKey:@"memberName"];//名字
    [de setObject:[dic objectForKey:@"isDaShi"] forKey:@"isDaShi"];//是否大师 1是 0否
    [de setObject:[dic objectForKey:@"memberId"] forKey:@"memberId"];//id
    [de setObject:[dic objectForKey:@"mobilePhone"] forKey:@"mobilePhone"];//电话
    [de synchronize];
}
//退出
+(void)logout{
    NSUserDefaults *de=[NSUserDefaults standardUserDefaults];
    [de setObject:@"0" forKey:@"isLogin"];
    [de setObject:@"" forKey:@"portrait"];
    [de setObject:@"" forKey:@"addressId"];
    [de setObject:@"" forKey:@"isTouGaoRen"];
    [de setObject:@"" forKey:@"memberName"];
    [de synchronize];
}

@end
