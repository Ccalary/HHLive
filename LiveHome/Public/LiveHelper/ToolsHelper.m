//
//  ToolsHelper.m
//  LiveHome
//
//  Created by chh on 2017/10/30.
//  Copyright © 2017年 chh. All rights reserved.
//

#import "ToolsHelper.h"

@implementation ToolsHelper
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
