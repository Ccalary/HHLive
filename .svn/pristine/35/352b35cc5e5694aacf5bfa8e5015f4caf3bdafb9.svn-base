//
//  NSObject+Extend.m
//  JzyTest
//
//  Created by 姜志远 on 2017/5/27.
//  Copyright © 2017年 姜志远. All rights reserved.
//

#import "NSObject+Extend.h"

@implementation NSObject(Json)
//字典转Json字符串
- (NSString*)jsonSerialize
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end



