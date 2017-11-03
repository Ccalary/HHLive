//
//  RealNameVC.m
//  LiveHome
//
//  Created by chh on 2017/10/30.
//  Copyright © 2017年 chh. All rights reserved.
//

#import "RealNameVC.h"
#import "RealNameFooterView.h"
#import "CountdownTableViewCell.h"
#import "PhotoHelper.h"

@interface RealNameVC ()<UITableViewDelegate, UITableViewDataSource,RealNameFooterViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) RealNameFooterView *footerView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSMutableArray *resultArray;
@end

@implementation RealNameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initView{
    self.view.backgroundColor = [UIColor bgColorMain];
    self.navigationItem.title = @"实名认证";
    
    [self initNormalView];
}

- (void)initNormalView{
    
    UITapGestureRecognizer *aTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:aTap];
    
    self.dataArray = @[@[@"真实姓名",@"请输入真实姓名"],@[@"手机号码",@"请输入手机号码"],@[@"验证码",@"请输入验证码"],@[@"身份证号",@"请输入身份证号"]];
    self.resultArray = [[NSMutableArray alloc] initWithArray:@[@"",@"",@"",@""]];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor bgColorMain];
    _tableView.tableHeaderView = self.headerView;
    _tableView.tableFooterView = self.footerView;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)initFinishView{
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@""];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(97*UIRate);
        make.top.offset(115*UIRate);
        make.centerX.equalTo(self.view);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.font = FONT_SYSTEM(15);
    label.textColor = [UIColor fontColorLightGray];
    label.text = @"实名认证已成功";
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).offset(25*UIRate);
        make.centerX.equalTo(self.view);
    }];
}

#pragma mark - 懒加载
- (UIView *)headerView{
    if (!_headerView){
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 30*UIRate)];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15*UIRate, 0, ScreenWidth - 30*UIRate, 30*UIRate)];
        label.font = FONT_SYSTEM(12);
        label.textColor = [UIColor fontColorLightGray];
        label.text = @"以下信息均为必填项，为了保证您的利益请如实填写";
        [_headerView addSubview:label];
    }
    return _headerView;
}

- (RealNameFooterView *)footerView{
    if (!_footerView){
        _footerView = [[RealNameFooterView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 130*UIRate)];
        _footerView.delegate = self;
    }
    return _footerView;
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
    cell.textField.tag = 1000 + (int)indexPath.row;
    [cell.textField addTarget:self action:@selector(textFieldAction:) forControlEvents:UIControlEventEditingChanged];
    switch (indexPath.row) {
        case 1:
            cell.textField.keyboardType = UIKeyboardTypeNumberPad;
            //倒计时按钮点击
            cell.block = ^{
                DLog(@"倒计时开始");
            };
            [cell countdownViewHidden:NO];
            break;
        case 2:
            cell.textField.keyboardType = UIKeyboardTypeNumberPad;
            break;
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
    return 45*UIRate;
}

#pragma mark - RealNameFooterViewDelegate
- (void)realNameFooterViewButtonClick:(RealNameFooterViewBtnType)type{
    switch (type) {
        case RealNameFooterViewBtnTypePhoto://添加照片
        {
            PhotoHelper *photoHelper = [PhotoHelper sharedInstance];
            [photoHelper addPhotoWithController:self];
            __weak typeof (self) weakSelf = self;
            photoHelper.block = ^(UIImage *image) {
                weakSelf.footerView.photoImage = image;
            };
        }
            break;
        case RealNameFooterViewBtnTypeSubmit://提交审核
            break;
        default:
            break;
    }
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
@end
