//
//  StreamingStartView.m
//  Find
//
//  Created by chh on 2017/8/21.
//  Copyright © 2017年 FindTechnology. All rights reserved.
//

#import "StreamingStartView.h"
#import "UIButton+ImageTitleSpacing.h"
#import "CNPPopupController.h"
#import "LabelNoticePopView.h"
#import "LocationSettingPopView.h"
#import "CloseStreamingPopView.h"
#import <CoreLocation/CoreLocation.h>
#import "FL_Button.h"

@interface StreamingStartView()<UITextFieldDelegate,CLLocationManagerDelegate>

@property (nonatomic, strong) UITextField *titleField;
@property (nonatomic, strong) UILabel *noticeLabel;
@property (nonatomic, strong) CNPPopupController *popupController;
@property (nonatomic, strong) LabelNoticePopView *locationPopupView;
@property (nonatomic, strong) LocationSettingPopView *locationSettingPopView;
@property (nonatomic, strong) CloseStreamingPopView *closeStrPopView;
@property (nonatomic, strong) FL_Button *locationBtn, *reverseBtn, *closeBtn, *horizontalBtn, *verticalBtn, *startBtn;//定位、反转、关闭、横屏、竖屏、开始
@property (nonatomic, strong) FL_Button *qqBtn, *wechatBtn, *friendsBtn;
@property (nonatomic, strong) CLLocationManager *locationManager; //定位
@property (nonatomic, assign) BOOL isLocationed; //是否定位过
@property (nonatomic, assign) BOOL isCanLocate;

@property (nonatomic, strong) NSString *province, *city, *county;//省市区
@property (nonatomic, assign) double lng, lat; //经度，纬度
@property (nonatomic, strong) NSString *password;//私密密码

@end

@implementation StreamingStartView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        self.province = @"";
        self.city = @"";
        self.county = @"";
        
        [self initView];
        [self startLocation];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self setAllFrame];
}

- (void)initView{
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];

    _locationBtn = [self creatImageButtonWithImageStr:@"s_location_16x15" andTitle:@"定位中" andType:StrStartViewBtnTypeLocation];
    
    _reverseBtn = [self creatImageButtonWithImageStr:@"s_camera_16x15" andTitle:@" 翻转" andType:StrStartViewBtnTypeCamera];
    
    _closeBtn = [self creatImageButtonWithImageStr:@"s_close_17" andTitle:@"" andType:StrStartViewBtnTypeClose];
    
    _horizontalBtn = [self creatTopButtonWithImageStr:@"s_hor_48" highlightImage:@"s_hor_pre_48" andTitle:@"横屏" andType:StrStartViewBtnTypeHorizontal andSpace:10];
    
    _verticalBtn = [self creatTopButtonWithImageStr:@"s_ver_48" highlightImage:@"s_ver_pre_48" andTitle:@"竖屏" andType:StrStartViewBtnTypeVertical andSpace:4];
    _verticalBtn.selected = YES;
    
    _noticeLabel = [[UILabel alloc] init];
    _noticeLabel.font = [UIFont systemFontOfSize:18];;
    _noticeLabel.text = @"— 会显示在开播推送消息中 —";
    _noticeLabel.textColor = [UIColor whiteColor];
    [self addSubview:_noticeLabel];
    
    _titleField = [[UITextField alloc] init];
    _titleField.font = [UIFont boldSystemFontOfSize:23];
    _titleField.delegate = self;
    _titleField.placeholder = @"给直播写个标题吧";
    _titleField.textAlignment = NSTextAlignmentCenter;
    _titleField.textColor = [UIColor whiteColor];
    _titleField.returnKeyType = UIReturnKeyDone;
    [_titleField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self addSubview:_titleField];

    _startBtn = [[FL_Button alloc] init];
    [_startBtn setTitle:@"开始直播" forState:UIControlStateNormal];
    _startBtn.backgroundColor = [UIColor themeColor];
    _startBtn.titleLabel.font = [UIFont systemFontOfSize:18];;
    _startBtn.layer.cornerRadius = 20;
    _startBtn.tag = StrStartViewBtnTypeStart;
    [_startBtn  addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_startBtn];
   
    _qqBtn = [self creatImageButtonWithImageStr:@"s_qq_23x23" andTitle:@"" andType:StrStartViewBtnTypeShareQQ];
    _wechatBtn = [self creatImageButtonWithImageStr:@"s_weixin_23x23" andTitle:@"" andType:StrStartViewBtnTypeShareWechat];
    _friendsBtn = [self creatImageButtonWithImageStr:@"s_friends_23x23" andTitle:@"" andType:StrStartViewBtnTypeShareFriends];
    
}

- (void)setAllFrame{
    [_locationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self).offset(15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
    }];
    
    [_reverseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_locationBtn.mas_right).offset(10);
        make.centerY.equalTo(_locationBtn);
        make.width.mas_equalTo(70);
        make.height.equalTo(_locationBtn);
    }];
    [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(40);
        make.centerY.equalTo(_locationBtn);
        make.right.equalTo(self);
    }];
    
    [_horizontalBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(65);
        make.right.equalTo(self.mas_centerX).offset(-10);
        make.centerY.equalTo(self);
    }];
    
    [_verticalBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(_horizontalBtn);
        make.left.equalTo(self.mas_centerX).offset(10);
        make.centerY.equalTo(self);
    }];
    
    [_noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(_horizontalBtn.mas_top).offset(-10);
    }];
    
    [_titleField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(ScreenWidth);
        make.centerX.equalTo(self);
        make.bottom.equalTo(_noticeLabel.mas_top).offset(-10);
    }];
    
    [_startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-40);
        make.centerX.equalTo(self);
        make.width.mas_equalTo(185);
        make.height.mas_equalTo(40);
    }];
    
    [_wechatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(40);
        make.centerX.equalTo(self);
        make.bottom.equalTo(_startBtn.mas_top).offset(-10);
    }];
    [_qqBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(_wechatBtn);
        make.centerY.equalTo(_wechatBtn);
        make.right.equalTo(_wechatBtn.mas_left).offset(-5);
    }];
    [_friendsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(_wechatBtn);
        make.centerY.equalTo(_wechatBtn);
        make.left.equalTo(_wechatBtn.mas_right);
    }];
}

- (void)startLocation{
    [self.locationManager requestWhenInUseAuthorization];
    //判断用户定位服务是否开启
    if ([CLLocationManager locationServicesEnabled]){
        //开始定位用户位置
        [self.locationManager startUpdatingLocation];
        //精度
        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    }else {
        //不能定位
        self.isCanLocate = NO;
    }
}

/**
 定位弹窗
 */
- (LabelNoticePopView *)locationPopupView{
    if (!_locationPopupView){
        _locationPopupView = [[LabelNoticePopView alloc] initWithFrame:CGRectMake(0, 0, 270, 120) andType:LabelNoticePopViewLocation];
        __weak typeof (self) weakSelf = self;
        _locationPopupView.block = ^(BOOL isSure) {
            [weakSelf.popupController dismissPopupControllerAnimated:YES];
            if (isSure){//确定
               [weakSelf.locationBtn setTitle:@"定位关" forState:UIControlStateNormal];
                weakSelf.isLocationed = NO;
            }
        };
    }
    return _locationPopupView;
}

/**
 定位权限
 */
- (LocationSettingPopView *)locationSettingPopView{
    if (!_locationSettingPopView){
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"LocationSettingPopView" owner:self options:nil];
        //得到第一个UIView
        _locationSettingPopView = [nib firstObject];
        __weak typeof (self) weakSelf = self;
        _locationSettingPopView.block = ^(BOOL isSure){
            [weakSelf.popupController dismissPopupControllerAnimated:YES];
            if (isSure){
                //打开设置界面
                NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if([[UIApplication sharedApplication] canOpenURL:url]) {
                    [[UIApplication sharedApplication] openURL:url];
                }
            }
        };
    }
    return _locationSettingPopView;
}
/**
 开启定位
 */
- (CLLocationManager *)locationManager{
    if (!_locationManager){
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
    }
    return _locationManager;
}

- (CloseStreamingPopView *)closeStrPopView{
    if (!_closeStrPopView){
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"CloseStreamingPopView" owner:self options:nil];
        //得到第一个UIView
        _closeStrPopView = [nib firstObject];
        __weak typeof (self) weakSelf = self;
        _closeStrPopView.block = ^(BOOL isSure){
            [weakSelf.popupController dismissPopupControllerAnimated:YES];
        };
    }
    return _closeStrPopView;
}

- (FL_Button *)creatImageButtonWithImageStr:(NSString *)imageStr andTitle:(NSString *)title andType:(StrStartViewBtnType) buttonType{
    FL_Button *button = [[FL_Button alloc] initWithAlignmentStatus:FLAlignmentStatusLeft];
    [button setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    button.tag = buttonType;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    return button;
}


- (FL_Button *)creatTopButtonWithImageStr:(NSString *)imageStr highlightImage:(NSString *)highligth andTitle:(NSString *)title andType:(StrStartViewBtnType) buttonType andSpace:(CGFloat)space{
    FL_Button *button = [[FL_Button alloc] initWithAlignmentStatus:FLAlignmentStatusTop];
    [button setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highligth] forState:UIControlStateSelected];
    [button setTitle:title forState:UIControlStateNormal];
    button.tag = buttonType;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:18];;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:space];
    [self addSubview:button];
    return button;
}

#pragma mark - CLLocationManagerDelegate 定位代理
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    //定位失败
    //用户没有开启权限
    if (error.code == kCLErrorDenied){
        NSLog(@"定位失败");
        _isCanLocate = NO;
        dispatch_async(dispatch_get_main_queue(), ^{
            [_locationBtn setTitle:@"定位失败" forState:UIControlStateNormal];
        });
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    //定位一次就好
    if (self.isLocationed) return;
    self.isCanLocate = YES;
    [_locationManager stopUpdatingLocation];
    
    CLLocation *currentLocation = [locations lastObject];
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
    //当前的经纬度
    DLog(@"当前的经纬度 %f,%f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
    
    self.lng = currentLocation.coordinate.longitude;//经度
    self.lat = currentLocation.coordinate.latitude;//纬度
    
    _isLocationed = YES;
    //地理反编码 可以根据坐标(经纬度)确定位置信息(街道 门牌等)
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count >0) {
            CLPlacemark *placeMark = placemarks[0];
           NSString *_currentCity = placeMark.locality;
            if (!_currentCity) {
                _currentCity = @"未获取";
            }
            //看需求定义一个全局变量来接收赋值
//            NSLog(@"当前国家 - %@",placeMark.country);//当前国家
//            NSLog(@"当前省份 - %@",placeMark.administrativeArea);//当前省份
//            NSLog(@"当前城市 - %@",_currentCity);//当前城市
//            NSLog(@"当前位置 - %@",placeMark.subLocality);//当前位置
//            NSLog(@"当前街道 - %@",placeMark.thoroughfare);//当前街道
//            NSLog(@"具体地址 - %@",placeMark.name);//具体地址
            
            self.province = placeMark.administrativeArea;
            self.city = placeMark.locality;
            self.county = placeMark.subLocality;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [_locationBtn setTitle:_currentCity forState:UIControlStateNormal];
            });
            
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [_locationBtn setTitle:@"定位失败" forState:UIControlStateNormal];
            });
        }
    }];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self endEditing:YES];
    return YES;
}

- (void)buttonAction:(UIButton *)button{
    
    switch (button.tag) {
        case StrStartViewBtnTypeLocation://定位
            if (self.isCanLocate){//定位是否允许
                if (self.isLocationed){//关闭定位弹窗
                    self.popupController = [[CNPPopupController alloc] initWithContents:@[self.locationPopupView]];
                    [self.popupController presentPopupControllerAnimated:YES];
                }else {
                    [self.locationManager startUpdatingLocation];//再次定位
                }
                
            }else {//弹窗提醒
                self.popupController = [[CNPPopupController alloc] initWithContents:@[self.locationSettingPopView]];
                [self.popupController presentPopupControllerAnimated:YES];
            }
            break;
        case StrStartViewBtnTypeHorizontal://横屏
            _horizontalBtn.selected = YES;
            _verticalBtn.selected = NO;
            break;
        case StrStartViewBtnTypeVertical://竖屏
            _horizontalBtn.selected = NO;
            _verticalBtn.selected = YES;
            break;
        case StrStartViewBtnTypeStart://开始
           
            break;
        case StrStartViewBtnTypeShareQQ://分享到QQ
          
            return;
        case StrStartViewBtnTypeShareWechat://分享到微信
           
            return;
        case StrStartViewBtnTypeShareFriends://分享到朋友圈
            return;
        default:
            break;
    }
    if ([self.delegate respondsToSelector:@selector(streamingStartViewBtnAction:)]){
        [self.delegate streamingStartViewBtnAction:button.tag];
    }
}

@end
