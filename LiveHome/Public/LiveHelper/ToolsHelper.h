//
//  ToolsHelper.h
//  LiveHome
//
//  Created by chh on 2017/10/30.
//  Copyright © 2017年 chh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToolsHelper : NSObject
//字典转Json字符串
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;
//json转字典
+ (NSDictionary *)dictionaryFromJson:(NSString *)jsonString;

/**
 改变某些字体的颜色
 
 @param str 要改变的文本
 @param result 总文本
 @param color 要改变的文本的颜色
 @return 改变后的总文本
 */
+ (NSMutableAttributedString *)changeSomeText:(NSString *)str inText:(NSString *)result withColor:(UIColor *)color;
@end
