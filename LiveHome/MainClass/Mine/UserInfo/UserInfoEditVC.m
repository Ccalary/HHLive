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

@interface UserInfoEditVC ()<UITableViewDelegate, UITableViewDataSource,UIGestureRecognizerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UIImage *headerImage;
@property (nonatomic, strong) NSString *companyPro;
@property (nonatomic, strong) NSString *nickName, *areaName;
@property (nonatomic, strong) NSString *realNameStatus;
@end

@implementation UserInfoEditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = @[@[@"头像",@"昵称",@"属性",@"城市"],@[@"实名认证"]];
    self.headerImage = [UIImage imageNamed:@"header_default_60"];
    self.companyPro = @"事业单位";
    self.areaName = @"北京";
    self.realNameStatus = @"未申请认证";
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initView{
    self.view.backgroundColor = [UIColor bgColorMain];
    self.navigationItem.title = @"编辑";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rigthBarButtonAction)];
    
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
                cell.headerImageView.image = self.headerImage;
                break;
            case 1://昵称
                cell.textField.hidden = NO;
                [cell.textField addTarget:self action:@selector(textFieldAction:) forControlEvents:UIControlEventEditingChanged];
                cell.textField.text = self.nickName;
                break;
            case 2://性别
                cell.rightLabel.text = self.companyPro;
                break;
            case 3://城市
                cell.rightLabel.text = self.areaName;
                break;
            default:
                break;
        }
    }else if (indexPath.section == 1){
        switch (indexPath.row) {
            case 0://实名认证
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
            {
                PhotoHelper *photoHelper = [PhotoHelper sharedInstance];
                [photoHelper addPhotoWithController:self];
                __weak typeof (self) weakSelf = self;
                photoHelper.block = ^(UIImage *image) {
                    weakSelf.headerImage = image;
                    [weakSelf reloadTableViewRow:indexPath.row];
                };
            }
                break;
            case 1://昵称
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
            [self.navigationController pushViewController:[[RealNameVC alloc] init] animated:YES];
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

- (void)reloadTableViewRow:(NSUInteger)row{
    NSIndexPath *position = [NSIndexPath indexPathForRow:row inSection:0];//刷新第一个section的第row行
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:position,nil] withRowAnimation:UITableViewRowAnimationFade];
}

//解决手势冲突
-(BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldReceiveTouch:(UITouch*)touch {
    
    if([NSStringFromClass([touch.view class]) isEqual:@"UITableViewCellContentView"]){
        return NO;
    }
    return YES;
}
#pragma mark - Method
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
        [weakSelf reloadTableViewRow:row];
    } otherButtonTitles:@"事业单位",@"外企",@"私营",@"民企",nil];
    [sheet show];
}

- (void)selectAreaWithRow:(NSInteger)row{
    AddressView *addressView = [[AddressView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    __weak typeof (self) weakSelf = self;
    addressView.block = ^(NSString *province, NSString *city, NSString *area){
      weakSelf.areaName = [NSString stringWithFormat:@"%@ %@ %@",province,city,area];
      [weakSelf reloadTableViewRow:row];
    };
    [addressView showView:self.view];
}
#pragma mark - Action
//保存
- (void)rigthBarButtonAction{

}

- (void)tapAction{
    [self.view endEditing:YES];
}

- (void)textFieldAction:(UITextField *)textField{
    self.nickName = textField.text;
}
@end
