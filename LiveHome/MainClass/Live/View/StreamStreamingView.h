//
//  StreamStreamingView.h
//  LiveHome
//
//  Created by chh on 2017/11/5.
//  Copyright © 2017年 chh. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, StreamStreamingViewBtnType){
    StrStreamingViewBtnTypeClose        = 0,    //关闭
    StrStreamingViewBtnTypeShare        = 1,    //分享
    StrStreamingViewBtnTypeChat         = 2,    //聊天
    StrStreamingViewBtnTypeBeauty       = 3,    //美颜
    StrStreamingViewBtnTypeApp          = 4,    //应用
    StrStreamingViewBtnTypeMsg          = 5,    //信息
};
@protocol StreamStreamingViewDelegate <NSObject>
- (void)streamingViewBtnAction:(StreamStreamingViewBtnType)type;
@end

@interface StreamStreamingView : UIView
@property (nonatomic, weak) id<StreamStreamingViewDelegate> delegate;

//根据开关状态更改图片
- (void)showBeautyBtnImageWithIsOn:(BOOL)isOn;
@end
