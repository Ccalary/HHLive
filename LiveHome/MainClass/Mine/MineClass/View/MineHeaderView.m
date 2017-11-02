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
@property (nonatomic, strong) UILabel *nameLabel, *numberLabel;
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
        make.width.height.mas_equalTo(60*UIRate);
        make.top.offset(60*UIRate);
        make.left.offset(15*UIRate);
    }];
    
    _headerImageView = [[UIImageView alloc] init];
    _headerImageView.image = [UIImage imageNamed:@"header_default_60"];
    _headerImageView.layer.cornerRadius = 40*UIRate;
    [self addSubview:_headerImageView];
    [_headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(55*UIRate);
        make.center.equalTo(headerBgView);
    }];
    
    UIButton *headerButton = [[UIButton alloc] init];
    [headerButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:headerButton];
    [headerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(headerBgView);
    }];
    
    _nameLabel = [self creatLabelText:@"名字"];
    _numberLabel = [self creatLabelText:@"ID:8688"];
    _numberLabel.font = FONT_SYSTEM(12);
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerBgView.mas_right).offset(6*UIRate);
        make.centerY.equalTo(headerBgView).offset(-10*UIRate);
    }];
   
    [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel);
        make.centerY.equalTo(headerBgView).offset(9*UIRate);
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
    if ([self.delegate respondsToSelector:@selector(mineHeaderViewBtnAction)]){
        [self.delegate mineHeaderViewBtnAction];
    }
}

@end
