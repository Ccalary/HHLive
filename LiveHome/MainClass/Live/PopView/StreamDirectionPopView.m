//
//  StreamDirectionPopView.m
//  LiveHome
//
//  Created by chh on 2017/11/10.
//  Copyright © 2017年 chh. All rights reserved.
//

#import "StreamDirectionPopView.h"
#import "FL_Button.h"

@interface StreamDirectionPopView()
@property (nonatomic ,strong) UIImageView *photoImageView, *camerImageView;
@property (nonatomic, strong) FL_Button *horizontalBtn, *verticalBtn;
@end

@implementation StreamDirectionPopView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        
    }
    return self;
}

- (void)initView{
    _photoImageView = [[UIImageView alloc] init];
    _photoImageView.image = [UIImage imageNamed:@""];
    [self addSubview:_photoImageView];
    [_photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(170*UIRate);
        make.height.mas_equalTo(95*UIRate);
        make.top.offset(23*UIRate);
        make.center.equalTo(self);
    }];
    
    _camerImageView = [[UIImageView alloc] init];
    _camerImageView.image = [UIImage imageNamed:@""];
    [self addSubview:_camerImageView];
    [_camerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(10);
        make.centerX.equalTo(_photoImageView);
        make.top.equalTo(_photoImageView).offset(10);
    }];
    
    UILabel *tipsLabel = [[UILabel alloc] init];
    tipsLabel.text = @"添加直播封面";
    tipsLabel.font = FONT_SYSTEM(12*UIRate);
    tipsLabel.textColor = [UIColor fontColorLightGray];
    [self addSubview:tipsLabel];
    [tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_photoImageView).offset(-15*UIRate);
        make.centerX.equalTo(self);
    }];
    
    _horizontalBtn = [self creatTopButtonWithImageStr:@"s_hor_48" highlightImage:@"s_hor_pre_48" andTitle:@"横屏" andType:StreamDirPopViewBtnTypeHorizontal andSpace:10];
    
    _verticalBtn = [self creatTopButtonWithImageStr:@"s_ver_48" highlightImage:@"s_ver_pre_48" andTitle:@"竖屏" andType:StreamDirPopViewBtnTypeVertical andSpace:4];
    
}

- (FL_Button *)creatTopButtonWithImageStr:(NSString *)imageStr highlightImage:(NSString *)highligth andTitle:(NSString *)title andType:(StreamDirPopViewBtnType) buttonType andSpace:(CGFloat)space{
    FL_Button *button = [[FL_Button alloc] initWithAlignmentStatus:FLAlignmentStatusTop];
    [button setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highligth] forState:UIControlStateSelected];
    [button setTitle:title forState:UIControlStateNormal];
    button.tag = buttonType;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:18];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//    [button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:space];
    [self addSubview:button];
    return button;
}

- (void)buttonAction:(UIButton *)button{
    
}
@end
