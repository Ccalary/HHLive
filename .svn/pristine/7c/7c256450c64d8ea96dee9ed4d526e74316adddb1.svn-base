//
//  ToolsHelper.m
//  LiveHome
//
//  Created by chh on 2017/10/30.
//  Copyright © 2017年 chh. All rights reserved.
//

#import "ToolsHelper.h"

@implementation ToolsHelper

//字典转Json字符串
+ (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+ (NSDictionary *)dictionaryFromJson:(NSString *)jsonString
{
    if([jsonString isKindOfClass:[NSDictionary class]])
        return (NSDictionary *)jsonString;
    if([jsonString isKindOfClass:[NSMutableDictionary class]])
        return (NSDictionary *)jsonString;
    
    NSDictionary* dict;
    if (jsonString && ![jsonString isKindOfClass:[NSNull class]] && ![jsonString isEqualToString:@""]) {
        NSError * parseError = nil;
        dict = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&parseError];
        return dict;
    }else {
        return dict;
    }
}

///改变某些字的颜色
+ (NSMutableAttributedString *)changeSomeText:(NSString *)str inText:(NSString *)result withColor:(UIColor *)color {
    
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:result];
    if (str.length){
        NSRange colorRange = NSMakeRange([[attributeStr string] rangeOfString:str].location,[[attributeStr string] rangeOfString:str].length);
        [attributeStr addAttribute:NSForegroundColorAttributeName value:color range:colorRange];
    }
    return attributeStr;
}
@end
