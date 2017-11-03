//
//  StreamingViewController.m
//  LiveHome
//
//  Created by chh on 2017/11/3.
//  Copyright © 2017年 chh. All rights reserved.
//

#import "StreamingViewController.h"
#import "StreamingStartView.h"
#import "AppDelegate.h"

@interface StreamingViewController ()<StreamStartViewDelegate>
@property (nonatomic, assign) BOOL isLandscape; //是否横屏
@property (nonatomic, strong) StreamingStartView *startView;
@end

@implementation StreamingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _startView = [[StreamingStartView alloc] initWithFrame:self.view.bounds];
    _startView.delegate = self;
    [self.view addSubview:_startView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}


#pragma mark - StreamStartViewDelegate 开始界面代理
- (void)streamingStartViewBtnAction:(StrStartViewBtnType)type{
    switch (type) {
        case StrStartViewBtnTypeClose://关闭
            if (self.isLandscape){
                [self screenRotationToLandscape:NO];
                return;
            }
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        case StrStartViewBtnTypeHorizontal://横屏
        {
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

//屏幕旋转更改开始界面布局
- (void)screenRotationToLandscape:(BOOL )rotate{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.allowLandscapeRight = rotate;
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
