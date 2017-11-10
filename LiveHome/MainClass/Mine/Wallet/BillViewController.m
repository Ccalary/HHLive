
//
//  BillViewController.m
//  LiveHome
//
//  Created by chh on 2017/10/28.
//  Copyright © 2017年 chh. All rights reserved.
//

#import "BillViewController.h"
#import "BillTableViewCell.h"
#import "LHConnect.h"
#import "PublicModel_Dict.h"
#import "WalletBillModel.h"

@interface BillViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) int page; //页码
@end

@implementation BillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray array];
    self.page = 1;
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)initView{
    self.navigationItem.title = @"账单";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor bgColorMain];
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    __weak typeof (self) weakSelf = self;
    //下拉刷新
    _tableView.mj_header = [HHRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        [weakSelf requestData];
    }];
    
    //上拉加载
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page ++;
        [weakSelf requestData];
    }];
    
    [_tableView.mj_header beginRefreshing];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * const cellIdentifier = @"CellIdentifier";
    BillTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[BillTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60*UIRate;
}

#pragma mark - 网络请求
- (void)requestData{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@(self.page) forKey:@"page"];
    [params setValue:@(10) forKey:@"size"];
    [LHConnect postWalletWalletMoneyLog:params loading:@"" success:^(ApiResultData * _Nullable data) {
        if (self.page == 1){
            [self.dataArray removeAllObjects];
        }
        PublicModel_Dict *pDict = [PublicModel_Dict mj_objectWithKeyValues:data];
        NSArray *array = [WalletBillModel mj_objectArrayWithKeyValuesArray:[pDict.data objectForKey:@"rows"]];
        [self.dataArray addObjectsFromArray:array];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if (array.count < 10){
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
    } failure:^(ApiResultData * _Nullable data) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}
@end
