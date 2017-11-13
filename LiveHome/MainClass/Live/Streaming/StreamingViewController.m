//
//  StreamingViewController.m
//  LiveHome
//
//  Created by chh on 2017/11/3.
//  Copyright © 2017年 chh. All rights reserved.
//

#import "StreamingViewController.h"
#import <VideoCore/VideoCore.h>
#import "AppDelegate.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "StreamingStartView.h"
#import "StreamStreamingView.h"
#import "StreamingEndView.h"

#import "CNPPopupController.h"
#import "CloseStreamingPopView.h"

#import "PublicModel_Dict.h"
#import "LHConnect.h"
#import "LiveRoomModel.h"
#import "RoomUserModel.h"

@interface StreamingViewController ()<VCSessionDelegate,StreamStartViewDelegate, StreamStreamingViewDelegate>

@property (nonatomic, strong) StreamingStartView *startView;
@property (nonatomic, strong) StreamStreamingView *streamingView;
@property (nonatomic, strong) StreamingEndView *endView;
@property (nonatomic, strong) NSTimer *timer; //刷新房间信息定时器
//弹窗
@property (nonatomic, strong) CNPPopupController *popupController;
@property (nonatomic, strong) CloseStreamingPopView *closePopView;
@property (nonatomic, assign) BOOL isBacking, isStart;
@property (nonatomic, strong) LiveRoomModel *roomModel;
@end

@implementation StreamingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];//屏幕常亮
    self.isBacking = NO;
    [self.model setupSession:[self cameraOrientation] delegate:self];
    [self.model preview:self.view];
    
    [self.view addSubview:self.startView];
    //请求房间数据
    [self requestLiveRoomInfoWihtEnd:NO];
}

- (void)viewDidLayoutSubviews {
    [self.model updateFrame:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (AVCaptureVideoOrientation)cameraOrientation {
    return AVCaptureVideoOrientationPortrait;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [IQKeyboardManager sharedManager].enable = NO;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [UIApplication sharedApplication].statusBarHidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    
    if (self.isLandScape){
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        appDelegate.allowLandscapeRight = NO;
        //强制旋转成竖屏
        NSNumber *value = [NSNumber numberWithInt:UIDeviceOrientationPortrait];
        [[UIDevice currentDevice]setValue:value forKey:@"orientation"];
        [UIViewController attemptRotationToDeviceOrientation];
    }
}


//开始界面
- (StreamingStartView *)startView{
    if (!_startView){
        _startView = [[StreamingStartView alloc] initWithFrame:self.view.bounds];
        _startView.delegate = self;
    }
    return _startView;
}
//直播界面
- (StreamStreamingView *)streamingView{
    if (!_streamingView){
        _streamingView = [[StreamStreamingView alloc] initWithFrame:self.view.frame andTargetId:self.targetId];
        _streamingView.delegate = self;
        _streamingView.topView.roomModel = self.roomModel;
        [self requestRoomUsersInfo];
        _timer = [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(requestRoomUsersInfo) userInfo:nil repeats:YES];
    }
    return _streamingView;
}
//结束界面
- (StreamingEndView *)endView{
    if(!_endView){
        _endView = [[StreamingEndView alloc] initWithFrame:self.view.frame andIsLandscape:self.isLandScape];
        __weak typeof (self) weakSelf = self;
        _endView.closeBlock = ^{
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        };
    }
    return _endView;
}

//关闭弹窗
- (CloseStreamingPopView *)closePopView{
    if (!_closePopView){
        _closePopView = [[NSBundle mainBundle] loadNibNamed:@"CloseStreamingPopView" owner:self options:nil].firstObject;
        __weak typeof (self) weakSelf = self;
        _closePopView.block = ^(BOOL isSure) {
            [weakSelf.popupController dismissPopupControllerAnimated:YES];
            if (isSure){
                weakSelf.isBacking = YES;
                BOOL result = [weakSelf.model back];
                if (!result) {
                    [weakSelf finishStreaming];
                }
            }
        };
    }
    return _closePopView;
}

#pragma mark - VCSessionDelegate
- (void) connectionStatusChanged: (VCSessionState) sessionState {
    switch(sessionState) {
        case VCSessionStatePreviewStarted:
            [self.model toggleBeauty];//开始后开启美颜
            break;
        case VCSessionStateStarting:
            NSLog(@"准备推流\n");
            self.isStart = YES;
            break;
        case VCSessionStateStarted:
            NSLog(@"开始推流\n");
            self.isStart = YES;
            break;
        case VCSessionStateError:
            NSLog(@"推流出错\n");
            self.isStart = NO;
            break;
        case VCSessionStateEnded:
            NSLog(@"推流结束\n");
            self.isStart = NO;
            if (self.isBacking) {
                self.isBacking = NO;
                [self finishStreaming];
            }
            break;
        default:
            break;
    }
}

#pragma mark - StreamStartViewDelegate 开始界面代理
- (void)streamingStartViewBtnAction:(StrStartViewBtnType)type{
    switch (type) {
        case StrStartViewBtnTypeStart://开始
            [self.startView removeFromSuperview];
            [self.view addSubview:self.streamingView];
             [self.model toggleStream];//开始
            break;
        case StrStartViewBtnTypeClose://关闭
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        case StrStartViewBtnTypeCamera://摄像头
            [self.model switchCamera];
            break;
        default:
            break;
    }
}

//推流界面
- (void)streamingViewBtnAction:(StreamStreamingViewBtnType)type{
    switch (type) {
        case StrStreamingViewBtnTypeClose://关闭
            self.popupController = [[CNPPopupController alloc] initWithContents:@[self.closePopView]];
            self.popupController.theme.backgroundColor = [UIColor clearColor];
            [self.popupController presentPopupControllerAnimated:YES];
            break;
        case StrStreamingViewBtnTypeChat://聊天
            break;
        case StrStreamingViewBtnTypeBeauty://美颜
        {
            BOOL toggle = [self.model toggleBeauty];
            [self.streamingView showBeautyBtnImageWithIsOn:toggle];
        }
            break;
        default:
            break;
    }
}

//直播结束
- (void)finishStreaming{
    [_timer invalidate];
    _timer = nil;
    [self.streamingView removeFromSuperview];
    [self.streamingView quiteChatRoom];//退出聊天室
    [self requestLiveRoomInfoWihtEnd:YES];
    [self.view addSubview:self.endView];
}

#pragma mark -网络数据 - 详情数据
//房间数据(分开始和结束时，默认开始时的数据)
- (void)requestLiveRoomInfoWihtEnd:(BOOL)isEndView{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:self.targetId forKey:@"id"];
    
    [LHConnect postLiveRoomInfo:params loading:@"加载中..." success:^(ApiResultData * _Nullable data) {
         PublicModel_Dict *pDic = [PublicModel_Dict mj_objectWithKeyValues:data];
        _roomModel = [LiveRoomModel mj_objectWithKeyValues:pDic.data];
        if (isEndView){
            self.endView.model = _roomModel;
        }else {
            self.startView.model = _roomModel;
        }
        
    } failure:^(ApiResultData * _Nullable data) {
        
    }];
}

//获得观众列表
- (void)requestRoomUsersInfo{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:self.targetId forKey:@"id"];
    [LHConnect postLiveRoomUsers:params loading:nil success:^(ApiResultData * _Nullable data) {
        PublicModel_Dict *model = [PublicModel_Dict mj_objectWithKeyValues:data];
        RoomUserModel *userModel = [RoomUserModel mj_objectWithKeyValues:model.data];
        self.streamingView.topView.userModel = userModel;
    } failure:^(ApiResultData * _Nullable data) {
        
    }];
}
@end
