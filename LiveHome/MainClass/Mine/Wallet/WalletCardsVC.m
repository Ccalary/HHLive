//
//  WalletCardsVC.m
//  LiveHome
//
//  Created by chh on 2017/10/30.
//  Copyright © 2017年 chh. All rights reserved.
//

#import "WalletCardsVC.h"
#import "CardsTableViewCell.h"
#import "WalletAddCardVC.h"

@interface WalletCardsVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *footerView;
@end

@implementation WalletCardsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initView{
    self.view.backgroundColor = [UIColor bgColorMain];
    self.navigationItem.title = @"银行卡";
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor bgColorMain];
    _tableView.tableFooterView = self.footerView;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.estimatedSectionHeaderHeight = NO;
    _tableView.estimatedSectionFooterHeight = NO;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (UIView *)footerView{
    if (!_footerView){
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 75*UIRate)];
        _footerView.backgroundColor = [UIColor bgColorMain];
        
        UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(15*UIRate, 30*UIRate, ScreenWidth - 30*UIRate, 40*UIRate)];
        [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [addButton setTitle:@"添加银行卡" forState:UIControlStateNormal];
        addButton.titleLabel.font = FONT_SYSTEM_BOLD(15);
        [addButton setBackgroundImage:[UIImage imageNamed:@"btn_blue_345x40"] forState:UIControlStateNormal];
        [addButton addTarget:self action:@selector(addButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:addButton];
    }
    return _footerView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * const cellIdentifier = @"CellIdentifier";
    CardsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[CardsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
//    cell.dividerLine.hidden = YES 
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60*UIRate;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15*UIRate;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

//添加银行卡
- (void)addButtonAction{
    [self.navigationController pushViewController:[[WalletAddCardVC alloc] init] animated:YES];
}
@end
