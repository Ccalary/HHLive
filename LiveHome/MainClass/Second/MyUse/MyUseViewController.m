//
//  MyUseViewController.m
//  LiveHome
//
//  Created by chh on 2017/10/28.
//  Copyright © 2017年 chh. All rights reserved.
//

#import "MyUseViewController.h"
#import "MineTableViewCell.h"
#import "VoteViewController.h"
#import "SignInViewController.h"
#import "StreamingViewController.h"

@interface MyUseViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSArray *imageArray;
@end

@implementation MyUseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = @[@"礼物",@"投票",@"签到"];
    _imageArray = @[@"icon_gift_23",@"icon_vote_23",@"icon_sign_23"];
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initView{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"应用";
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor bgColorMain];
    _tableView.estimatedSectionHeaderHeight = NO;
    _tableView.estimatedSectionFooterHeight = NO;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * const cellIdentifier = @"CellIdentifier";
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[MineTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.dividerLine.hidden = YES;
    cell.iconImageView.image = [UIImage imageNamed:self.imageArray[indexPath.section]];
    cell.titleLabel.text = self.dataArray[indexPath.section];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45*UIRate;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0://礼物
        {
             [self.navigationController pushViewController:[[StreamingViewController alloc] init] animated:YES];
        }
            break;
        case 1://投票
        {
            [self.navigationController pushViewController:[[VoteViewController alloc] init] animated:YES];
        }
            break;
        case 2://签到
        {
            [self.navigationController pushViewController:[[SignInViewController alloc] init] animated:YES];
        }
            break;
        default:
            break;
    }
}

@end
