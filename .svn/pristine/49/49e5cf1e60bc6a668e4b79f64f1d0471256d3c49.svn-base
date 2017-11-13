//
//  UserInfoEditVC.m
//  LiveHome
//
//  Created by chh on 2017/10/31.
//  Copyright © 2017年 chh. All rights reserved.
//

#import "UserInfoEditVC.h"
#import "UserInfoTableViewCell.h"
#import "PhotoHelper.h"
#import "LCActionSheet.h"
#import "AddressView.h"
#import "RealNameVC.h"
#import "UserInfoModel.h"
#import "UserHelper.h"
#import "UIImageView+WebCache.h"
#import "LHConnect.h"
#import "PublicModel_Array.h"
#import "PublicModel_Dict.h"

@interface UserInfoEditVC ()<UITableViewDelegate, UITableViewDataSource,UIGestureRecognizerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSString *companyPro;
@property (nonatomic, strong) NSString *textName;
@property (nonatomic, strong) NSString *realNameStatus;
@property (nonatomic, strong) UserInfoModel *model;
@end

@implementation UserInfoEditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = @[@[@"头像",@"昵称",@"属性",@"城市"],@[@"实名认证"]];
    [self initView];
    //获取个人信息
    [self requestUserInfo];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initView{
    self.view.backgroundColor = [UIColor bgColorMain];
    self.navigationItem.title = @"编辑";
    
    UITapGestureRecognizer *aTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    aTap.delegate = self;
    [self.view addGestureRecognizer:aTap];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor bgColorMain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    NSArray *array = self.dataArray[section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *array = self.dataArray[indexPath.section];

    NSString * const cellIdentifier = @"CellIdentifier";
    UserInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UserInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.dividerLine.hidden = (array.count - 1 == indexPath.row) ? YES : NO;
    cell.nameLabel.text = array[indexPath.row];
    cell.textField.hidden = YES;
    cell.headerImageView.hidden = YES;
    cell.rightLabel.text = @"";
    cell.rightDetailLabel.text = @"";
    cell.arrowImageView.hidden = YES;
    if (indexPath.section == 0){
        switch (indexPath.row) {
            case 0://头像
                cell.headerImageView.hidden = NO;
                [cell.headerImageView sd_setImageWithURL:[NSURL URLWithString:self.model.userimage] placeholderImage:[UIImage imageNamed:@"header_default_60"]];
                break;
            case 1://昵称
                cell.textField.hidden = NO;
                cell.textField.userInteractionEnabled = NO;
                cell.textField.text = self.model.username;
                break;
            case 2://属性
                cell.rightLabel.text = self.model.prop ?: @"";
                break;
            case 3://城市
                cell.rightLabel.text = [NSString stringWithFormat:@"%@-%@", self.model.hprovince ?: @"", self.model.hcity ?: @""];
                break;
            default:
                break;
        }
    }else if (indexPath.section == 1){
        switch (indexPath.row) {
            case 0://实名认证
                /** 实名认证状态 -1-未申请认证 0-待审核 1-审核通过 其他-审核不通过*/
                if ([@"-1" isEqualToString:self.model.cer]){
                    self.realNameStatus = @"未申请认证";
                }else if ([@"0" isEqualToString:self.model.cer]){
                    self.realNameStatus = @"审核中";
                }else if ([@"1" isEqualToString:self.model.cer]){
                    self.realNameStatus = @"审核通过";
                }else{
                    self.realNameStatus = @"审核不通过";
                }
                cell.rightDetailLabel.text = self.realNameStatus;
                cell.arrowImageView.hidden = NO;
                break;
            default:
                break;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.view endEditing:YES];
    if (indexPath.section == 0){
        switch (indexPath.row) {
            case 0://头像
                [self showSelectHeaderImage];
                break;
            case 1://昵称
                [self showNickNameAlertView];
                break;
            case 2://性别
                [self selectSexWithRow:indexPath.row];
                break;
            case 3://城市
                [self selectAreaWithRow:indexPath.row];
                break;
            default:
                break;
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0){//实名认证
            if ([@"0" isEqualToString:self.model.cer]){
                [LCProgressHUD showMessage:@"正在审核中"];
                return;
            }
            
            RealNameVC *vc = [[RealNameVC alloc] init];
            vc.isSuccess =  ([@"1" isEqualToString:self.model.cer]) ? YES : NO;
            __weak typeof (self) weakSelf = self;
            vc.block = ^{
                [weakSelf requestUserInfo];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10*UIRate;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) return 55*UIRate;
    return 45*UIRate;
}

//解决手势冲突
-(BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldReceiveTouch:(UITouch*)touch {
    
    if([NSStringFromClass([touch.view class]) isEqual:@"UITableViewCellContentView"]){
        return NO;
    }
    return YES;
}
#pragma mark - Method

//头像
- (void)showSelectHeaderImage{
    PhotoHelper *photoHelper = [PhotoHelper sharedInstance];
    [photoHelper addPhotoWithController:self];
    __weak typeof (self) weakSelf = self;
    photoHelper.block = ^(UIImage *image) {
        [weakSelf requestHeaderImage:@[image]];
    };
}

- (void)showNickNameAlertView{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请输入昵称"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    __weak typeof (self) weakSelf = self;
    [alert addAction:[UIAlertAction actionWithTitle:@"确定"
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * _Nonnull action){
                                                if ([weakSelf.textName isEqualToString:weakSelf.model.username] || (weakSelf.textName.length == 0)){
                                                    
                                                }else {
                                                    [weakSelf postUserInfoWithName:@"name" value:weakSelf.textName];
                                                    weakSelf.textName = @"";
                                                }
                                            }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消"
                                              style:UIAlertActionStyleCancel
                                            handler:^(UIAlertAction * _Nonnull action) {
                                                
                                            }]];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        textField.text = weakSelf.model.username ?: @"";
        textField.placeholder = @"请输入10个字以内的昵称";
        [textField addTarget:weakSelf action:@selector(textFieldAction:) forControlEvents:UIControlEventEditingChanged];
    }];
    //弹出提示框
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)selectSexWithRow:(NSInteger)row{
    __weak typeof (self) weakSelf = self;
    LCActionSheet *sheet = [[LCActionSheet alloc] initWithTitle:nil cancelButtonTitle:@"取消" clicked:^(LCActionSheet * _Nonnull actionSheet, NSInteger buttonIndex) {
        switch (buttonIndex) {
            case 1:
                weakSelf.companyPro = @"事业单位";
                break;
            case 2:
                weakSelf.companyPro = @"外企";
                break;
            case 3:
                weakSelf.companyPro = @"私营";
                break;
            case 4:
                weakSelf.companyPro = @"民企";
                break;
            default:
                break;
        }
        //上传信息
        [self postUserInfoWithName:@"prop" value:weakSelf.companyPro];
    } otherButtonTitles:@"事业单位",@"外企",@"私营",@"民企",nil];
    [sheet show];
}

- (void)selectAreaWithRow:(NSInteger)row{
    AddressView *addressView = [[AddressView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    __weak typeof (self) weakSelf = self;
    addressView.block = ^(NSString *province, NSString *city, NSString *area){
        [weakSelf postUserInfoWithName:@"hpc" value:[NSString stringWithFormat:@"%@-%@",province,city]];
    };
    [addressView showView:self.view];
}
#pragma mark - Action
- (void)tapAction{
    [self.view endEditing:YES];
}

- (void)textFieldAction:(UITextField *)textField{
    if (textField.text.length > 10){
        _textName = [textField.text substringToIndex:10];
    }else {
        _textName = textField.text;
    }
}

#pragma mark - 网络请求
- (void)requestHeaderImage:(NSArray *)imageArray{
    [LCProgressHUD showKeyWindowLoading:@"头像上传中..."];
    [LHConnect uploadImageResource:nil files:imageArray success:^(ApiResultData * _Nullable data) {
        PublicModel_Array *pArray = [PublicModel_Array mj_objectWithKeyValues:data];
        NSString *imageurl = pArray.data[0];
        [self postUserInfoWithName:@"headerimage" value:imageurl];
    } failure:^(ApiResultData * _Nullable data) {
        [LCProgressHUD hide];
    }];
}

//上传用户信息
- (void)postUserInfoWithName:(NSString *)name value:(NSString *)value{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:name forKey:@"name"];
    [params setValue:value forKey:@"value"];
    [LHConnect postUpdateUserInfo:params loading:@"更新中..." success:^(ApiResultData * _Nullable data) {
        [self setUserInfoWithKey:name andValue:value];
    } failure:^(ApiResultData * _Nullable data) {
        
    }];
}

//更新用户信息
- (void)setUserInfoWithKey:(NSString *)name andValue:(NSString *)value{
    NSMutableDictionary *mDic = [[NSMutableDictionary alloc] initWithDictionary:[UserHelper getUserInfo]];
    if ([name isEqualToString:@"name"]){//昵称
       [mDic setValue:value forKey:@"username"];
    }else if ([name isEqualToString:@"prop"]){//属性
         [mDic setValue:value forKey:@"prop"];
    }else if ([name isEqualToString:@"hpc"]){//城市
        NSArray *array = [value componentsSeparatedByString:@"-"];
        [mDic setValue:array.firstObject forKey:@"hprovince"];
        [mDic setValue:array.lastObject forKey:@"hcity"];
    }else if ([name isEqualToString:@"headerimage"]){//头像
       [mDic setValue:value forKey:@"userimage"];
    }
    _model = [UserInfoModel mj_objectWithKeyValues:mDic];
    [self.tableView reloadData];
    [UserHelper setUserInfo:mDic];
}

//获取个人信息
- (void)requestUserInfo{
    NSString *userId = [UserHelper getMemberId];
    if (userId.length == 0) return;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:[UserHelper getMemberId] forKey:@"userid"];
    [LHConnect postUserInfo:params loading:@"加载中..." success:^(ApiResultData * _Nullable data) {
        PublicModel_Dict *pDict = [PublicModel_Dict mj_objectWithKeyValues:data];
        NSDictionary *dic = pDict.data;
        _model = [UserInfoModel mj_objectWithKeyValues:dic];
        [UserHelper setUserInfo:dic];
        [self.tableView reloadData];
    } failure:^(ApiResultData * _Nullable data) {
        
    }];
}
@end
