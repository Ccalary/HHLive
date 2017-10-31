//
//  WithdrawViewController.m
//  LiveHome
//
//  Created by chh on 2017/10/30.
//  Copyright © 2017年 chh. All rights reserved.
//

#import "WithdrawViewController.h"
#import "WithdrawTableViewCell1.h"
#import "WithdrawTableViewCell2.h"
#import "WithdrawFooterView.h"
#import "BillViewController.h"
#import "WalletAddCardVC.h"
#import "WalletCardsVC.h"

#define kCell  @"kCell"
NSString * const withdrawCellId1 = @"withdrawTableViewCell1";
NSString * const withdrawCellId2 = @"withdrawTableViewCell2";
@interface WithdrawViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) WithdrawFooterView *footerView;
@property (nonatomic, strong) NSMutableArray *cellsArray;
@property (nonatomic, strong) NSString *withdrawMoney; //提现金额
@property (nonatomic, assign) BOOL isHaveCard;
@end

@implementation WithdrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _cellsArray = [NSMutableArray array];
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initView{
    self.view.backgroundColor = [UIColor bgColorMain];
    self.navigationItem.title = @"提现";
    
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
    
    [self updateCell];
    
    //H 测试
    self.isHaveCard = YES;
    [self updateUI];
}

//更新UI
- (void)updateUI{
    if (self.isHaveCard){
       self.navigationItem.title = @"提现";
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"账单" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemAction)];
        self.navigationItem.rightBarButtonItem = rightItem;
    }else {
       self.navigationItem.title = @"添加银行卡";
    }
}

- (void)updateCell{
    [self.cellsArray removeAllObjects];
    
    NSMutableArray *array1 = [NSMutableArray array];
    NSDictionary *dic1 = @{kCell:withdrawCellId1};
    [array1 addObject:dic1];
    [self.cellsArray addObject:array1];
    
    NSMutableArray *array2 = [NSMutableArray array];
    NSDictionary *dic2 = @{kCell:withdrawCellId2};
    [array2 addObject:dic2];
    [self.cellsArray addObject:array2];
    
    [self.tableView reloadData];
}

#pragma mark - 懒加载
- (WithdrawFooterView *)footerView{
    if (!_footerView){
        _footerView = [[WithdrawFooterView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 120*UIRate)];
        //提现
        _footerView.block = ^{
            
        };
    }
    return _footerView;
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.cellsArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = self.cellsArray[section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableArray *array = self.cellsArray[indexPath.section];
    NSDictionary *dic = array[indexPath.row];
    if ([dic[kCell] isEqualToString:withdrawCellId1]){
        WithdrawTableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:withdrawCellId1];
        if (!cell){
             cell = [[WithdrawTableViewCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:withdrawCellId1];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else if ([dic[kCell] isEqualToString:withdrawCellId2]){
        WithdrawTableViewCell2 *cell = [tableView dequeueReusableCellWithIdentifier:withdrawCellId2];
        if (!cell){
            cell = [[WithdrawTableViewCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:withdrawCellId2];
        }
        __weak typeof (self) weakSelf = self;
        cell.block = ^(NSString *text) {
            weakSelf.withdrawMoney = text;//提现金额
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
    return [[UITableViewCell alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *array = self.cellsArray[indexPath.section];
    NSDictionary *dic = array[indexPath.row];
    if ([dic[kCell] isEqualToString:withdrawCellId2]){
        return 120*UIRate;
    }
    return 60*UIRate;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15*UIRate;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *array = self.cellsArray[indexPath.section];
    NSDictionary *dic = array[indexPath.row];
    if ([dic[kCell] isEqualToString:withdrawCellId1]){
        if (self.isHaveCard){//选择银行卡
           [self.navigationController pushViewController:[[WalletCardsVC alloc] init] animated:YES];
        }else{//添加银行卡
           [self.navigationController pushViewController:[[WalletAddCardVC alloc] init] animated:YES];
        }
    }
}

#pragma mark - Action
- (void)rightBarButtonItemAction{
    [self.navigationController pushViewController:[[BillViewController alloc] init] animated:YES];
}

@end
