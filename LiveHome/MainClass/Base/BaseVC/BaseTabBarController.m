 //
//  BaseTabBarController.m
//  LiveHome
//
//  Created by caohouhong on 17/3/15.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNavigationController.h"
#import "BaseTabbar.h"
#import "OldVideosVC.h"
#import "MyUseViewController.h"
#import "StreamingViewController.h"
#import "MineViewController.h"
#import "SettingViewModel.h"
#import "StreamingViewModel.h"
#import "MessageViewController.h"

@interface BaseTabBarController ()<BaseTabbarDelegate>

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITabBar *tabbar = [UITabBar appearance];
    tabbar.tintColor = [UIColor themeColor];
    //创建自己的tabbar，然后用kvc将自己的tabbar和系统的tabBar替换下
    BaseTabbar *baseTabbar = [[BaseTabbar alloc] init];
    baseTabbar.myDelegate = self;
    //kvc实质是修改了系统的_tabBar
    [self setValue:baseTabbar forKeyPath:@"tabBar"];
    
    [self addChildViewControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//添加子控制器
- (void)addChildViewControllers{
    
    [self addChildrenViewController:[[OldVideosVC alloc] init] andTitle:@"历史" andImageName:@"tab_history" andSelectImage:@"tab_history_pre"];
     [self addChildrenViewController:[[MyUseViewController alloc] init] andTitle:@"应用" andImageName:@"tab_use" andSelectImage:@"tab_use_pre"];
     [self addChildrenViewController:[[MessageViewController alloc] init] andTitle:@"消息" andImageName:@"tab_msg" andSelectImage:@"tab_msg_pre"];
    [self addChildrenViewController:[[MineViewController alloc] init] andTitle:@"我" andImageName:@"tab_mine" andSelectImage:@"tab_mine_pre"];
}

- (void)addChildrenViewController:(UIViewController *)childVC andTitle:(NSString *)title andImageName:(NSString *)imageName andSelectImage:(NSString *)selectedImage{
    childVC.tabBarItem.image = [UIImage imageNamed:imageName];
    childVC.tabBarItem.selectedImage =  [UIImage imageNamed:selectedImage];
    childVC.title = title;
    
    BaseNavigationController *baseNav = [[BaseNavigationController alloc] initWithRootViewController:childVC];
    
    [self addChildViewController:baseNav];
}

- (void)baseTabbarClickButtonAction:(BaseTabbar *)tabBar{
    
    SettingViewModel *model = [[SettingViewModel alloc] init];
    model.url = @"rtmp://push.o2o.com.cn/find/3306388461?token=91a1dae67a18c960d742b58be81559baeb9bd482b8d3ce52022fc4c3af324117&expire=2017-11-09T10:38:43Z";
    model.direction = DirectionPortrait;
    
    StreamingViewModel *vm = [[StreamingViewModel alloc] initWithSettingViewModel:model];
    
//    StreamingLandscapeViewController *vc = [[StreamingLandscapeViewController alloc] init];
//    vc.model = vm;
//    vc.isScreenVertical = NO;
//    vc.targetId = targetId;
//    vc.conversationType = ConversationType_CHATROOM;
//    [self.navigationController pushViewController:vc animated:NO];
    
    
    StreamingViewController *vc = [[StreamingViewController alloc] init];
    vc.model = vm;
    BaseNavigationController *baseNav = [[BaseNavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:baseNav animated:YES completion:nil];
}

@end
