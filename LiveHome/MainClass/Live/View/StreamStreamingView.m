//
//  StreamStreamingView.m
//  LiveHome
//
//  Created by chh on 2017/11/5.
//  Copyright © 2017年 chh. All rights reserved.
//

#import "StreamStreamingView.h"
#import "CountdownLabel.h"
#import "StreamingTopView.h"
#import "RCDLiveChatListView.h"
#import <RongIMLib/RongIMLib.h>

@interface StreamStreamingView()
@property (nonatomic, strong) UIButton *beautyBtn;
@property (nonatomic, strong) CountdownLabel *countdownLabel;
@property (nonatomic, strong) StreamingTopView *topView;
@property (nonatomic, assign) CGFloat rate;
@property (nonatomic, strong) RCDLiveChatListView *chatListView;
@end

@implementation StreamStreamingView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
  
        CGSize size = [UIScreen mainScreen].bounds.size;
        if (size.width > size.height){
            _rate = size.height/375.0;
        }else {
            _rate = size.width/375.0;
        }
        [self initTopView];
        [self initBtnView];
        [self addSubview:self.countdownLabel];
        
        [self initChatListView];
    }
    return self;
}

- (void)initChatListView{
    RCUserInfo *user = [[RCUserInfo alloc]init];
    user.userId = @"1";
    user.portraitUri = @"";
    user.name = @"夜空中最亮的星 ";
    [RCIMClient sharedRCIMClient].currentUserInfo = user;
    self.chatListView = [[RCDLiveChatListView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 250, 250, 200) andTargetId:@"ChatRoom01"];
    [self addSubview:self.chatListView];
}

- (void)initTopView{
    self.topView = [[StreamingTopView alloc] initWithFrame:CGRectMake(0, 20, self.frame.size.width, 70*self.rate) andItemWidth:30*self.rate];
    [self addSubview:self.topView];
    [self.topView.mCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-35);
    }];
}
//按钮
- (void)initBtnView{
    
    UIButton *closeBtn = [self createButtonWithImageStr:@"s_close_17" andType:StrStreamingViewBtnTypeClose];
    UIButton *appBtn = [self createButtonWithImageStr:@"s_app_32" andType:StrStreamingViewBtnTypeApp];
    UIButton *shareBtn = [self createButtonWithImageStr:@"s_share_32" andType:StrStreamingViewBtnTypeShare];
    _beautyBtn = [self createButtonWithImageStr:@"s_beauty_s_32" andType:StrStreamingViewBtnTypeBeauty];
//    UIButton *msgBtn = [self createButtonWithImageStr:@"s_msg_32" andType:StrStreamingViewBtnTypeMsg];
    UIButton *chatBtn = [self createButtonWithImageStr:@"s_chat_32" andType:StrStreamingViewBtnTypeChat];
    
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(40);
        make.right.equalTo(self).offset(0);
        make.top.offset(20);
    }];
    
    [appBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(40);
        make.right.offset(-10);
        make.bottom.offset(-5);
    }];
    
    [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(appBtn);
        make.right.equalTo(appBtn.mas_left).offset(-10);
        make.centerY.equalTo(appBtn);
    }];
    
    [_beautyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(appBtn);
        make.right.equalTo(shareBtn.mas_left).offset(-10);
        make.centerY.equalTo(appBtn);
    }];
    
//    [msgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(appBtn);
//        make.right.equalTo(_beautyBtn.mas_left).offset(-10);
//        make.centerY.equalTo(appBtn);
//    }];
    
    [chatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(appBtn);
        make.left.offset(10);
        make.centerY.equalTo(appBtn);
    }];
}

- (CountdownLabel *)countdownLabel{
    if (!_countdownLabel){
        _countdownLabel = [[CountdownLabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
        _countdownLabel.center = self.center;
        [_countdownLabel startCount];
    }
    return _countdownLabel;
}


//创建button
- (UIButton *)createButtonWithImageStr:(NSString *)imgStr andType:(StreamStreamingViewBtnType )type{
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:imgStr] forState:UIControlStateNormal];
    button.tag = type;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    return button;
}

#pragma mark - Action
- (void)buttonAction:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(streamingViewBtnAction:)]){
        [self.delegate streamingViewBtnAction:button.tag];
    }
}

//根据开关状态更改图片
- (void)showBeautyBtnImageWithIsOn:(BOOL)isOn{
    if (isOn){
        [self.beautyBtn setImage:[UIImage imageNamed:@"s_beauty_s_32"] forState:UIControlStateNormal];
    }else {
        [self.beautyBtn setImage:[UIImage imageNamed:@"s_beauty_n_32"] forState:UIControlStateNormal];
    }
}
@end
