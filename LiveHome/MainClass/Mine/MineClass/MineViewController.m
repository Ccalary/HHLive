//
//  MineViewController.m
//  LiveHome
//
//  Created by chh on 2017/10/27.
//  Copyright © 2017年 chh. All rights reserved.
//

#import "MineViewController.h"
#import "MineHeaderView.h"
#import "MineTableViewCell.h"
#import "RealNameVC.h"
#import "WalletViewController.h"
#import "UserInfoEditVC.h"
#import "StatisticsViewController.h"
#import "PasswordViewController.h"

@interface MineViewController ()<UITableViewDelegate, UITableViewDataSource,MineHeaderViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MineHeaderView *headerView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSArray *imageArray;
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = @[@[@"我的钱包"],@[@"直播统计"],@[@"设置"]];
    _imageArray = @[@[@"mine_wallet_18"],@[@"mine_statics_18"],@[@"mine_setting_18"]];
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)initView{
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = self.headerView;
    _tableView.backgroundColor = [UIColor bgColorMain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.estimatedSectionHeaderHeight = NO;
    _tableView.estimatedSectionFooterHeight = NO;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.offset(-TabBarHeight);
        make.top.equalTo(self.view).offset(-StatusBarHeight);
    }];
}

- (MineHeaderView *)headerView{
    if (!_headerView){
        _headerView = [[MineHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 155*UIRate)];
        _headerView.delegate = self;
    }
    return _headerView;
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = self.dataArray[section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * const cellIdentifier = @"CellIdentifier";
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[MineTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSArray *array = self.dataArray[indexPath.section];
    cell.dividerLine.hidden = (array.count-1 == indexPath.row) ? YES : NO;
    cell.iconImageView.image = [UIImage imageNamed:self.imageArray[indexPath.section][indexPath.row]];
    cell.titleLabel.text = self.dataArray[indexPath.section][indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45*UIRate;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10*UIRate;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0){
        switch (indexPath.row) {
            case 0://钱包
            {
                [self.navigationController pushViewController:[[WalletViewController alloc] init] animated:YES];
            }
                break;
            default:
                break;
        }
    }else if (indexPath.section == 1){
        switch (indexPath.row) {
            case 0://直播统计
            {
                [self.navigationController pushViewController:[[StatisticsViewController alloc] init] animated:YES];
            }
                break;
            default:
                break;
        }
        
    }else if (indexPath.section == 2){
        if (indexPath.row == 0){//设置
            [self.navigationController pushViewController:[[PasswordViewController alloc] initWithType:PasswordVCTypeForgotPsd] animated:YES];
        }
    }
}

#pragma mark - MineHeaderViewDelegate
- (void)mineHeaderViewBtnAction{
    [self.navigationController pushViewController:[[UserInfoEditVC alloc] init] animated:YES];
}
@end
