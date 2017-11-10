//
//  StreamDirectionPopView.h
//  LiveHome
//
//  Created by chh on 2017/11/10.
//  Copyright © 2017年 chh. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, StreamDirPopViewBtnType) {
    StreamDirPopViewBtnTypePhoto         = 1,    //选择封面
    StreamDirPopViewBtnTypeHorizontal    = 2,    //横屏
    StreamDirPopViewBtnTypeVertical      = 3     //竖屏
};
@interface StreamDirectionPopView : UIView

@end
