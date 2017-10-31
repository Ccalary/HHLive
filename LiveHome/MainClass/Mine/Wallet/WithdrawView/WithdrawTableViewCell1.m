//
//  WithdrawTableViewCell1.m
//  LiveHome
//
//  Created by chh on 2017/10/30.
//  Copyright © 2017年 chh. All rights reserved.
//

#import "WithdrawTableViewCell1.h"
@interface WithdrawTableViewCell1()
@property (nonatomic, strong) UIImageView *bankImageView;
@property (nonatomic, strong) UILabel *nameLabel, *numLabel;
@property (nonatomic, strong) UIView *noCardView;
@end

@implementation WithdrawTableViewCell1
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
        [self initNoCardView];
    }
    return self;
}

- (void)initView{
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _bankImageView = [[UIImageView alloc] init];
    _bankImageView.image = [UIImage imageNamed:@"tab_me"];
    [self.contentView addSubview:_bankImageView];
    [_bankImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(34*UIRate);
        make.left.offset(15*UIRate);
        make.centerY.equalTo(self.contentView);
    }];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = FONT_SYSTEM(15);
    _nameLabel.textColor = [UIColor fontColorBlack];
    _nameLabel.text = @"招商银行";
    [self.contentView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bankImageView.mas_right).offset(15*UIRate);
        make.centerY.equalTo(self.contentView).offset(-10*UIRate);
    }];
    
    _numLabel = [[UILabel alloc] init];
    _numLabel.font = FONT_SYSTEM(12);
    _numLabel.textColor = [UIColor fontColorLightGray];
    _numLabel.text = @"尾号5077储蓄卡";
    [self.contentView addSubview:_numLabel];
    [_numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel);
        make.centerY.equalTo(self.contentView).offset(8*UIRate);
    }];
    
    UIImageView *arrowImageView = [[UIImageView alloc] init];
    arrowImageView.image = [UIImage imageNamed:@"arrow_10x18"];
    [self.contentView addSubview:arrowImageView];
    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(8*UIRate);
        make.height.mas_equalTo(10*UIRate);
        make.right.offset(-15*UIRate);
        make.centerY.equalTo(self.contentView);
    }];
}

- (void)initNoCardView{
    _noCardView = [[UIView alloc] init];
    _noCardView.backgroundColor = [UIColor whiteColor];
//    _noCardView.hidden = YES;
    [self.contentView addSubview:_noCardView];
    [_noCardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    UILabel *tipsLabel = [[UILabel alloc] init];
    tipsLabel.font = FONT_SYSTEM(15);
    tipsLabel.textColor = [UIColor fontColorLightGray];
    tipsLabel.text = @"添加银行卡";
    [_noCardView addSubview:tipsLabel];
    [tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_noCardView);
        make.centerX.equalTo(_noCardView).offset(11*UIRate);
    }];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"bank_card_20x15"];
    [_noCardView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(20*UIRate);
        make.height.mas_equalTo(15*UIRate);
        make.right.equalTo(tipsLabel.mas_left).offset(-3*UIRate);
        make.centerY.equalTo(_noCardView);
    }];
}
@end
