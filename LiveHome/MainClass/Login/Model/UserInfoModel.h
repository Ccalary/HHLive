//
//  UserInfoModel.h
//  LiveHome
//
//  Created by chh on 2017/11/10.
//  Copyright © 2017年 chh. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface UserInfoModel : NSObject

/** 用户ID */
@property (nonatomic,copy) NSString *userid;

/** 用户头像 */
@property (nonatomic,copy) NSString *userimage;

/** 用户昵称 */
@property (nonatomic,copy) NSString *username;

/** 用户等级 */
@property (nonatomic,copy) NSString *level;

/** 属性*/
@property (nonatomic,copy) NSString *prop;

/** 用户性别 1-男 2-女*/
@property (nonatomic,copy) NSString *sex;

/** 账户id */
@property (nonatomic,copy) NSString *findid;

/** 个性签名 */
@property (nonatomic,copy) NSString *ownsign;

/** 省 */
@property (nonatomic,copy) NSString *hprovince;

/** 市 */
@property (nonatomic,copy) NSString *hcity;

/** 出生日期 */
@property (nonatomic,copy) NSString *birthday;

/** 关注人数 */
@property (nonatomic,copy) NSString *attentioncount;

/** 粉丝数量 */
@property (nonatomic,copy) NSString *fanscount;

/** 实名认证状态 -1-未申请认证 0-待审核 1-审核通过 其他-审核不通过*/
@property (nonatomic,copy) NSString *cer;

@end
