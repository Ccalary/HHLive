//
//  NetUrlMacro.h
//  LiveHome
//
//  Created by chh on 2017/10/27.
//  Copyright © 2017年 chh. All rights reserved.
//

#ifndef NetUrlMacro_h
#define NetUrlMacro_h

/******************个人中心******************/
//意见反馈接口
#define FeedBack @"/FeedBack"

/****************登录注册模块*****************/
//登录接口
#define Login @"/Account/Login"

//注册接口
#define Register @"/Account/Register"

//忘记密码接口
#define ForgetPwd @"/Account/ForgetPwd"

//发送短信接口
#define SendSms @"/Sms/SendSms"

//图片验证码接口
#define ValidImage @"/Sms/ValidImage"

//绑定手机接口(更换手机号)
#define BangdingMobile @"/User/BangdingMobile"

#endif /* NetUrlMacro_h */
