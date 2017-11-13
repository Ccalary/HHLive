//
//  OldVideosCollectionViewCell.m
//  LiveHome
//
//  Created by chh on 2017/10/28.
//  Copyright © 2017年 chh. All rights reserved.
//

#import "OldVideosCollectionViewCell.h"
@interface OldVideosCollectionViewCell()
@property (nonatomic, strong) UIImageView *videoImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@end

@implementation OldVideosCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        [self initView];
    }
    return self;
}

- (void)initView{
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _videoImageView = [[UIImageView alloc] init];
    _videoImageView.image = [UIImage imageNamed:@"video_default_180x95"];
    [self.contentView addSubview:_videoImageView];
    [_videoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView);
        make.height.mas_equalTo(97*UIRate);
    }];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = FONT_SYSTEM(15);
    _nameLabel.textColor = [UIColor fontColorBlack];
    _nameLabel.numberOfLines = 0;
    _nameLabel.text = @"2017全国服务创业型企业发展方向";
    [self.contentView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(5);
        make.right.offset(-5);
        make.top.equalTo(_videoImageView.mas_bottom).offset(5);
        make.bottom.offset(-5);
    }];
}
@end
