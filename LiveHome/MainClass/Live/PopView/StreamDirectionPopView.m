//
//  StreamDirectionPopView.m
//  LiveHome
//
//  Created by chh on 2017/11/10.
//  Copyright © 2017年 chh. All rights reserved.
//

#import "StreamDirectionPopView.h"
#import "FL_Button.h"
#import "UIButton+ImageTitleSpacing.h"

@interface StreamDirectionPopView()
@property (nonatomic ,strong) UIImageView *photoImageView, *camerImageView;
@property (nonatomic, strong) FL_Button *horizontalBtn, *verticalBtn;
@end

@implementation StreamDirectionPopView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        [self initView];
    }
    return self;
}

- (void)initView{
    _photoImageView = [[UIImageView alloc] init];
    _photoImageView.image = [UIImage imageNamed:@"s_bg_180x95"];
    _photoImageView.backgroundColor = [UIColor grayColor];
    [self addSubview:_photoImageView];
    [_photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(180*UIRate);
        make.height.mas_equalTo(95*UIRate);
        make.top.offset(23*UIRate);
        make.centerX.equalTo(self);
    }];
    
    _camerImageView = [[UIImageView alloc] init];
    _camerImageView.image = [UIImage imageNamed:@"s_photo_40x34"];
    [self addSubview:_camerImageView];
    [_camerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(40*UIRate);
        make.height.mas_equalTo(34*UIRate);
        make.centerX.equalTo(_photoImageView);
        make.top.equalTo(_photoImageView).offset(15*UIRate);
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
    
    FL_Button *addBtn = [self creatTopButtonWithImageStr:@"" highlightImage:@"" andTitle:@"" andType:StreamDirPopViewBtnTypePhoto andSpace:0];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_photoImageView);
    }];
    
    _horizontalBtn = [self creatTopButtonWithImageStr:@"s_hor_40" highlightImage:@"" andTitle:@"横屏" andType:StreamDirPopViewBtnTypeHorizontal andSpace:10];
    
    _verticalBtn = [self creatTopButtonWithImageStr:@"s_ver_40" highlightImage:@"" andTitle:@"竖屏" andType:StreamDirPopViewBtnTypeVertical andSpace:4];
    
    [_horizontalBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(70*UIRate);
        make.right.equalTo(self.mas_centerX).offset(-10);
        make.bottom.equalTo(self).offset(-20*UIRate);
    }];
    
    [_verticalBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(_horizontalBtn);
        make.left.equalTo(self.mas_centerX).offset(10);
        make.centerY.equalTo(_horizontalBtn);
    }];
}

- (FL_Button *)creatTopButtonWithImageStr:(NSString *)imageStr highlightImage:(NSString *)highligth andTitle:(NSString *)title andType:(StreamDirPopViewBtnType) buttonType andSpace:(CGFloat)space{
    FL_Button *button = [[FL_Button alloc] initWithAlignmentStatus:FLAlignmentStatusTop];
    [button setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highligth] forState:UIControlStateSelected];
    [button setTitle:title forState:UIControlStateNormal];
    button.tag = buttonType;
    [button setTitleColor:[UIColor themeColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15*UIRate];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:space];
    [self addSubview:button];
    return button;
}

- (void)buttonAction:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(streamPopViewBtnActionWithType:)]){
        [self.delegate streamPopViewBtnActionWithType:button.tag];
    }
}

- (void)setBannerImage:(UIImage *)bannerImage{
    _photoImageView.image = bannerImage;
    [self bringSubviewToFront:_photoImageView];
}
@end
