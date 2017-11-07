//
//  NSObject+Extend.h
//  JzyTest
//
//  Created by 姜志远 on 2017/5/27.
//  Copyright © 2017年 姜志远. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject(Json)

/**
 json 序列化

 @return json序列化字符串
 */
- (NSString*)jsonSerialize;

@end



