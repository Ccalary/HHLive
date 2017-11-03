
//
//  VoteViewController.m
//  LiveHome
//
//  Created by chh on 2017/10/28.
//  Copyright © 2017年 chh. All rights reserved.
//

#import "VoteViewController.h"

@interface VoteViewController ()

@end

@implementation VoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

- (void)initView{
    self.navigationItem.title = @"投票";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *tipsLabel = [[UILabel alloc] init];
    tipsLabel.font = FONT_SYSTEM_BOLD(18);
    tipsLabel.textColor = [UIColor fontColorLightGray];
    tipsLabel.text = @"正在建设中...";
    [self.view addSubview:tipsLabel];
    [tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
}
@end
