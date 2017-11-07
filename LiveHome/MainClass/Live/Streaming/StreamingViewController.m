//
//  StreamingViewController.m
//  LiveHome
//
//  Created by chh on 2017/11/3.
//  Copyright © 2017年 chh. All rights reserved.
//

#import "StreamingViewController.h"
#import "StreamingStartView.h"
#import "StreamStreamingView.h"
#import "StreamingEndView.h"

#import "CNPPopupController.h"
#import "CloseStreamingPopView.h"

#import <VideoCore/VideoCore.h>
#import "AppDelegate.h"

@interface StreamingViewController ()<VCSessionDelegate,StreamStartViewDelegate, StreamStreamingViewDelegate>

@property (nonatomic, assign) BOOL isLandscape; //是否横屏
@property (nonatomic, strong) StreamingStartView *startView;
@property (nonatomic, strong) StreamStreamingView *streamingView;
@property (nonatomic, strong) StreamingEndView *endView;

//弹窗
@property (nonatomic, strong) CNPPopupController *popupController;
@property (nonatomic, strong) CloseStreamingPopView *closePopView;
@property (nonatomic, assign) BOOL isBacking, isStart;
@end

@implementation StreamingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];//屏幕常亮
    [UIApplication sharedApplication].statusBarHidden = NO;
    self.isBacking = NO;
    [self.model setupSession:[self cameraOrientation] delegate:self];
    [self.model preview:self.view];
    
    [self.view addSubview:self.startView];
}

- (void)viewDidLayoutSubviews {
    [self.model updateFrame:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (AVCaptureVideoOrientation)cameraOrientation {
    if (self.isLandscape){
        return AVCaptureVideoOrientationLandscapeRight;
    }
    return AVCaptureVideoOrientationPortrait;
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
        _streamingView = [[StreamStreamingView alloc] initWithFrame:self.view.frame];
        _streamingView.delegate = self;
    }
    return _streamingView;
}
//结束界面
- (StreamingEndView *)endView{
    if(!_endView){
        _endView = [[StreamingEndView alloc] initWithFrame:self.view.frame andIsLandscape:self.isLandscape];
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
            if (self.isLandscape){
                [self screenRotationToLandscape:NO];
                return;
            }
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        case StrStartViewBtnTypeCamera://摄像头
            [self.model switchCamera];
            break;
        case StrStartViewBtnTypeHorizontal://横屏
        {
            [self.model setEndStreaming];
            [self screenRotationToLandscape:YES];
        }
            break;
        case StrStartViewBtnTypeVertical://竖屏
        {
            [self screenRotationToLandscape:NO];
        }
            break;
        default:
            break;
    }
}

- (void)streamingViewBtnAction:(StreamStreamingViewBtnType)type{
    switch (type) {
        case StrStreamingViewBtnTypeClose://关闭
            self.popupController = [[CNPPopupController alloc] initWithContents:@[self.closePopView]];
            self.popupController.theme.backgroundColor = [UIColor clearColor];
            [self.popupController presentPopupControllerAnimated:YES];
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
    [self.streamingView removeFromSuperview];
    [self.view addSubview:self.endView];
}

//屏幕旋转更改开始界面布局
- (void)screenRotationToLandscape:(BOOL )rotate{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.allowLandscapeRight = rotate;
    self.isLandscape = rotate;
    if (rotate){//旋转成横屏
        // 强制翻转屏幕，Home键在右边。
        [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationLandscapeRight) forKey:@"orientation"];
        //刷新
        [UIViewController attemptRotationToDeviceOrientation];
    }else {
        //强制翻转屏幕竖屏。
        [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationPortrait) forKey:@"orientation"];
        //刷新
        [UIViewController attemptRotationToDeviceOrientation];
    }
    _startView.frame =  self.view.bounds;
    [self.startView layoutIfNeeded];
}

@end
