//
//  PasswordViewController.m
//  LiveHome
//
//  Created by chh on 2017/11/2.
//  Copyright © 2017年 chh. All rights reserved.
//

#import "PasswordViewController.h"
#import "CountdownTableViewCell.h"
#import "PopSecurityCodeView.h"
#import "CNPPopupController.h"
//H 测试
#import "LoginViewController.h"
#import "BaseNavigationController.h"

@interface PasswordViewController ()<UITableViewDelegate, UITableViewDataSource,UIGestureRecognizerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSMutableArray *resultArray;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, assign) PasswordVCType type;
@property (nonatomic, strong) CNPPopupController *popupController;
@property (nonatomic, strong) PopSecurityCodeView *codeView;
@end

@implementation PasswordViewController

- (instancetype)initWithType:(PasswordVCType)type{
    if (self = [super init]){
        self.type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.type == PasswordVCTypeRegister){
        self.navigationItem.title = @"注册";
        self.dataArray = @[@[@"手机号",@"请输入手机号"],@[@"验证码",@"请输入验证码"],@[@"密码",@"请输入密码，至少6位"]];
    }else if (self.type == PasswordVCTypeForgotPsd){
        self.navigationItem.title = @"忘记密码";
        self.dataArray = @[@[@"手机号",@"请输入手机号"],@[@"验证码",@"请输入验证码"],@[@"新密码",@"请输入密码，至少6位"]];
    }else{
        self.dataArray = @[];
    }
    
    self.resultArray = [[NSMutableArray alloc] initWithArray:@[@"",@"",@""]];
    
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)initView{
    self.view.backgroundColor = [UIColor bgColorMain];
   
    UITapGestureRecognizer *aTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    aTap.delegate = self;
    [self.view addGestureRecognizer:aTap];
    
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
#pragma mark - 懒加载
- (UIView *)footerView{
    if (!_footerView){
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 70*UIRate)];
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(15*UIRate, 25*UIRate, ScreenWidth - 30*UIRate, 40*UIRate)];
        [button setBackgroundImage:[UIImage imageNamed:@"btn_blue_345x40"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitle:@"提交" forState:UIControlStateNormal];
        button.titleLabel.font = FONT_SYSTEM_BOLD(15);
        [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:button];
    }
    return _footerView;
}

//弹窗
- (PopSecurityCodeView *)codeView{
    if (!_codeView){
        _codeView = [[PopSecurityCodeView alloc] initWithFrame:CGRectMake(0, 0, 330*UIRate, 160*UIRate)];
        __weak typeof (self) weakSelf = self;
        _codeView.block = ^(BOOL isSubmit) {
            [weakSelf.popupController dismissPopupControllerAnimated:YES];
            if (isSubmit){
                //网络请求
            }
        };
    }
    return _codeView;
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
    CountdownTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[CountdownTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *array = self.dataArray[indexPath.row];
    //最后一个隐藏分割线
    cell.dividerLine.hidden = (self.dataArray.count - 1 == indexPath.row) ? YES : NO;
    cell.nameLabel.text = array.firstObject;
    cell.textField.placeholder = array.lastObject;
    cell.textField.secureTextEntry = NO;
    cell.textField.tag = 1000 + (int)indexPath.row;
    [cell.textField addTarget:self action:@selector(textFieldAction:) forControlEvents:UIControlEventEditingChanged];
    switch (indexPath.row) {
        case 0:
        {
            cell.textField.keyboardType = UIKeyboardTypeNumberPad;
            //倒计时按钮点击
            __weak typeof (self) weakSelf = self;
            cell.block = ^{
                weakSelf.popupController = [[CNPPopupController alloc] initWithContents:@[weakSelf.codeView]];
                [weakSelf.popupController presentPopupControllerAnimated:YES];
            };
            [cell countdownViewHidden:NO];
        }
            break;
        case 1:
            cell.textField.keyboardType = UIKeyboardTypeNumberPad;
            break;
        case 2:
            cell.textField.keyboardType = UIKeyboardTypeDefault;
            cell.textField.secureTextEntry = YES;
        default:
            cell.textField.keyboardType = UIKeyboardTypeDefault;
            [cell countdownViewHidden:YES];
            break;
    }
    [cell.clearBtn addTarget:self action:@selector(clearBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.clearBtn.tag = 1000 + (int)indexPath.row;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55*UIRate;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10*UIRate;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

#pragma mark - Action
//清除和隐藏工作在cell中处理了
- (void)clearBtnAction:(UIButton *)button{
    int i = (int)button.tag - 1000;
    if (_resultArray.count > i){
        _resultArray[i] = @"";
    }
}

- (void)textFieldAction:(UITextField *)textField{
    int i = (int)textField.tag - 1000;
    if (_resultArray.count > i){
        _resultArray[i] = textField.text;
    }
}

- (void)tapAction{
    [self.view endEditing:YES];
}

//提交
- (void)buttonAction{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    BaseNavigationController *baseNav = [[BaseNavigationController alloc] initWithRootViewController:loginVC];
    [self presentViewController:baseNav animated:YES completion:nil];
}

@end
