//
//  NetUrlMacro.h
//  LiveHome
//
//  Created by chh on 2017/10/27.
//  Copyright © 2017年 chh. All rights reserved.
//

#ifndef NetUrlMacro_h
#define NetUrlMacro_h

#pragma mark - ******************个人中心******************
//用户详细信息接口
#define UserInfo @"/User/UserInfo"

//更新用户信息接口
#define UpdateUserInfo @"/User/UpdateUserInfo"

//上传图片资源
#define HomeResource @"/Home/Resource"

//意见反馈接口
#define FeedBack @"/FeedBack"

//实名认证接口
#define Certification @"/User/Certification"

//余额
#define WalletWalletMoney @"/Wallet/WalletMoney"

//我的钱包账单
#define WalletWalletMoneyLog @"/Wallet/WalletMoneyLog"

//添加银行卡
#define WalletAddBankCard @"/Wallet/AddBankCard"

//获取银行卡的类型
#define WalletGetCardType @"/Wallet/GetCardType"

//我的银行卡列表
#define WalletBankCard @"/Wallet/BankCard"

//我的钱包提现
#define WalletWithdrawals @"/Wallet/Withdrawals"

#pragma mark - ****************登录注册模块*****************
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
