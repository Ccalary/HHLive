//
//  StatisticsViewController.m
//  LiveHome
//
//  Created by chh on 2017/10/31.
//  Copyright © 2017年 chh. All rights reserved.
//

#import "StatisticsViewController.h"
#import "StatisticsTableViewCell.h"
#import "UIButton+ImageTitleSpacing.h"
#import "HHPopSelectView.h"
#import "StatisticsSelectView.h"
#import "StaticHeaderView.h"

@interface StatisticsViewController ()<UITableViewDelegate, UITableViewDataSource, StatisticsSelectViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) StatisticsSelectView *selectView;
@property (nonatomic, strong) HHPopSelectView *popSelectView;
@property (nonatomic, strong) StaticHeaderView *headerView;
@end

@implementation StatisticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = @[
                      @[@"日期",@"时长(分)",@"人数",@"打赏(元)"],
                      @[@"2017.11.1",@"200",@"100",@"200"],
                      @[@"2017.11.2",@"300",@"200",@"1200"],
                      @[@"2017.11.3",@"400",@"300",@"11200"],
                      @[@"2017.11.4",@"500",@"400",@"111200"]
                      ];
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initView{
    self.view.backgroundColor = [UIColor bgColorMain];
    self.navigationItem.title = @"直播统计";
    
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 70*UIRate, 30*UIRate)];
    customView.backgroundColor = [UIColor clearColor];
    _rightButton = [[UIButton alloc] initWithFrame:customView.frame];
    [_rightButton setTitle:@"一周内" forState:UIControlStateNormal];
    _rightButton.titleLabel.font = FONT_SYSTEM(15);
    [_rightButton setImage:[UIImage imageNamed:@"arrow_white_9x15"] forState:UIControlStateNormal];
    [_rightButton addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [_rightButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:2];
    [customView addSubview:_rightButton];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:customView];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = self.headerView;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (StaticHeaderView *)headerView{
    if (!_headerView){
        _headerView = [[StaticHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 250*UIRate)];
    }
    return _headerView;
}

- (StatisticsSelectView *)selectView{
    if (!_selectView){
        _selectView = [[StatisticsSelectView alloc] initWithFrame:CGRectMake(0, 0, 100*UIRate, 120*UIRate)
                                                     andDataArray:@[@"一周内",@"一月内",@"一年内"]];
        _selectView.delegate = self;
    }
    return _selectView;
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * const cellIdentifier = @"CellIdentifier";
    StatisticsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[StatisticsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.bgColor = (indexPath.row%2 == 0) ? [UIColor colorWithHex:0xe3e8ee] : [UIColor bgColorWhite];
    cell.dataArray = self.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40*UIRate;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *holdView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(14, 0, ScreenWidth - 29, 1)];
    line.backgroundColor = [UIColor bgColorLineDarkGray];
    [holdView addSubview:line];
    return holdView;
}

#pragma mark - StatisticsSelectViewDelegate 筛选代理
- (void)didSelectRowWithTitle:(NSString *)text{
    [_rightButton setTitle:text forState:UIControlStateNormal];
    [_popSelectView dismiss];
}

#pragma mark - Action
- (void)rightButtonAction{
    _popSelectView = [[HHPopSelectView alloc] initWithOrigin:CGPointMake(ScreenWidth - 30, TopFullHeight) andCustomView:self.selectView];
    [_popSelectView popView];
}
@end
