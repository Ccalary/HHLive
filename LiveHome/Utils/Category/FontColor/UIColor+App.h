//
//  UIColor+App.h
//  HHFramework
//
//  Created by chh on 2017/7/31.
//  Copyright © 2017年 chh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (App)
//主题颜色
+ (UIColor *)themeColor;

//背景颜色
//／主背景色-灰色
+ (UIColor *)bgColorMain;
+ (UIColor *)bgColorWhite;//白色
+ (UIColor *)bgColorLine; //分隔线(浅)
+ (UIColor *)bgColorLineDarkGray;//分隔线(深)

//字体颜色
+ (UIColor *)fontColorBlack;//黑色
+ (UIColor *)fontColorDarkGray; //深灰
+ (UIColor *)fontColorLightGray;//浅灰
//按钮颜色
+ (UIColor *)buttonColorTheme;

//随机颜色
+ (UIColor*)randomColor;

//十六进制颜色
+ (UIColor *)colorWithHex:(NSInteger)hexValue;
@end
