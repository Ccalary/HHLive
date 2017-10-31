//
//  MineHeaderView.m
//  LiveHome
//
//  Created by chh on 2017/10/27.
//  Copyright © 2017年 chh. All rights reserved.
//

#import "MineHeaderView.h"
@interface MineHeaderView()
@property (nonatomic, strong) UIImageView *bgImageView, *headerImageView;
@property (nonatomic, strong) UILabel *nameLabel, *numberLabel, *contriLabel, *fansLabel;
@end

@implementation MineHeaderView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        [self initView];
    }
    return self;
}

- (void)initView{
    _bgImageView = [[UIImageView alloc] initWithFrame:self.frame];
    _bgImageView.backgroundColor = [UIColor themeColor];
    [self addSubview:_bgImageView];
    
    UIView *dividerLine = [[UIView alloc] init];
    dividerLine.backgroundColor = [UIColor grayColor];
    [self addSubview:dividerLine];
    [dividerLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(25*UIRate);
        make.bottom.offset(-10*UIRate);
        make.centerX.equalTo(self);
    }];
    
    UIButton *writeButton = [[UIButton alloc] init];
    [writeButton setImage:[UIImage imageNamed:@"mine_write_30"] forState:UIControlStateNormal];
    [writeButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:writeButton];
    [writeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(35*UIRate);
        make.top.offset(20*UIRate);
        make.right.offset(0);
    }];
    
    UIView *headerBgView = [[UIView alloc] init];
    headerBgView.backgroundColor = [UIColor whiteColor];
    headerBgView.layer.cornerRadius = 45*UIRate;
    [self addSubview:headerBgView];
    [headerBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(90*UIRate);
        make.top.offset(50*UIRate);
        make.centerX.equalTo(self);
    }];
    
    _headerImageView = [[UIImageView alloc] init];
    _headerImageView.image = [UIImage imageNamed:@"header_default_60"];
    _headerImageView.layer.cornerRadius = 40*UIRate;
    [self addSubview:_headerImageView];
    
    [_headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(80*UIRate);
        make.center.equalTo(headerBgView);
    }];
    
    _nameLabel = [self creatLabelText:@"名字"];
    _numberLabel = [self creatLabelText:@"账号:8688"];
    _numberLabel.font = FONT_SYSTEM(12);
    _contriLabel = [self creatLabelText:@"123"];
    UILabel *contriTextLabel = [self creatLabelText:@"贡献"];
    _fansLabel = [self creatLabelText:@"456"];
    UILabel *fansTextLabel = [self creatLabelText:@"粉丝"];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerBgView.mas_bottom).offset(15*UIRate);
        make.centerX.equalTo(self);
    }];
   
    [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_bottom).offset(6*UIRate);
        make.centerX.equalTo(self);
    }];
    
    [contriTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-5*UIRate);
        make.centerX.equalTo(self).offset(-ScreenWidth/4.0);
    }];
    
    [_contriLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(contriTextLabel.mas_top).offset(-2*UIRate);
        make.centerX.equalTo(contriTextLabel);
    }];
    
    [fansTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(contriTextLabel);
        make.centerX.equalTo(self).offset(ScreenWidth/4.0);
    }];
    
    [_fansLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(fansTextLabel);
        make.centerY.equalTo(_contriLabel);
    }];
    
}

- (UILabel *)creatLabelText:(NSString *)text{
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor whiteColor];
    label.font = FONT_SYSTEM(15);
    label.text = text;
    [self addSubview:label];
    return label;
}

- (void)buttonAction:(UIButton *)button{
    
}

@end
