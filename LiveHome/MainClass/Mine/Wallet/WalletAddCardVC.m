//
//  WalletAddCardVC.m
//  LiveHome
//
//  Created by chh on 2017/10/28.
//  Copyright © 2017年 chh. All rights reserved.
//

#import "WalletAddCardVC.h"
#import "AddCardTableViewCell.h"

@interface WalletAddCardVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UIButton *submitButton;
@property (nonatomic, strong) NSArray *dataArray, *placeArray;
@property (nonatomic, strong) NSMutableArray *stringArray;
@end

@implementation WalletAddCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = @[@"开户名",@"银行账号",@"银行名称",@"支行名称"];
    _placeArray = @[@"请输入开户名",@"请输入银行账号",@"请输入银行名称",@"请输入支行名称"];
    _stringArray = [[NSMutableArray alloc] initWithArray:@[@"",@"",@"",@""]];
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)initView{
    self.navigationItem.title = @"添加银行卡";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initFooterView];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor bgColorMain];
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 15*UIRate)];
    _tableView.tableFooterView = self.footerView;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)initFooterView{
    _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 70*UIRate)];
    _footerView.backgroundColor = [UIColor bgColorMain];
    [_footerView addSubview:self.submitButton];
}

- (UIButton *)submitButton{
    if (!_submitButton){
        _submitButton = [[UIButton alloc] initWithFrame:CGRectMake(15*UIRate, 25*UIRate, ScreenWidth - 30*UIRate, 40*UIRate)];
        [_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitButton setTitle:@"提交" forState:UIControlStateNormal];
        _submitButton.titleLabel.font = FONT_SYSTEM_BOLD(15);
        [_submitButton setBackgroundColor:[UIColor themeColor]];
        _submitButton.layer.cornerRadius = 4;
        [_submitButton addTarget:self action:@selector(submitBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * const cellIdentifier = @"CellIdentifier";
    AddCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[AddCardTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.nameLabel.text = self.dataArray[indexPath.row];
    cell.textField.placeholder = self.placeArray[indexPath.row];
    cell.textField.tag = 1000 + (int)indexPath.row;
    [cell.textField addTarget:self action:@selector(textFieldAction:) forControlEvents:UIControlEventEditingChanged];
    if (indexPath.row == 2){
        cell.textField.keyboardType = UIKeyboardTypeNumberPad;
    }else {
        cell.textField.keyboardType = UIKeyboardTypeDefault;
    }
    [cell.clearBtn addTarget:self action:@selector(clearBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.clearBtn.tag = 1000 + (int)indexPath.row;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55*UIRate;
}

//Action 清除和隐藏工作在cell中处理了
- (void)clearBtnAction:(UIButton *)button{
    int i = (int)button.tag - 1000;
    if (_stringArray.count > i){
        _stringArray[i] = @"";
    }
}

- (void)textFieldAction:(UITextField *)textField{
    int i = (int)textField.tag - 1000;
    if (_stringArray.count > i){
        _stringArray[i] = textField.text;
    }
}

//提交
- (void)submitBtnAction{
    for (NSString *text in self.stringArray){
        if (text.length == 0){
            [LCProgressHUD showFailure:@"信息不全!"];
        }
    }
    NSLog(@"%@",self.stringArray);
}
@end
