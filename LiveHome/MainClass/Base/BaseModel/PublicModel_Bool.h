//
//  PublicModel_Bool.h
//  Find
//
//  Created by nie on 2017/6/26.
//  Copyright © 2017年 FindTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PublicModel_Bool : NSObject

@property (nonatomic,copy) NSString * resultcode;

@property (nonatomic,copy) NSString * code;
/* 返回的信息 */
@property (nonatomic,copy) NSString * message;
/* 共用数据字典 */
@property (nonatomic,assign) BOOL  data;

@end
