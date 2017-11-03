 //
//  BaseTabBarController.m
//  LiveHome
//
//  Created by caohouhong on 17/3/15.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNavigationController.h"
#import "OldVideosVC.h"
#import "MineViewController.h"
#import "BaseTabbar.h"

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
    
    [self addChildrenViewController:[[OldVideosVC alloc] init] andTitle:@"历史" andImageName:@"tab_me" andSelectImage:@"tab_me_pre"];
     [self addChildrenViewController:[[OldVideosVC alloc] init] andTitle:@"首页" andImageName:@"tab_me" andSelectImage:@"tab_me_pre"];
     [self addChildrenViewController:[[OldVideosVC alloc] init] andTitle:@"首页" andImageName:@"tab_me" andSelectImage:@"tab_me_pre"];
    [self addChildrenViewController:[[MineViewController alloc] init] andTitle:@"我" andImageName:@"tab_me" andSelectImage:@"tab_me_pre"];
}

- (void)addChildrenViewController:(UIViewController *)childVC andTitle:(NSString *)title andImageName:(NSString *)imageName andSelectImage:(NSString *)selectedImage{
    childVC.tabBarItem.image = [UIImage imageNamed:imageName];
    childVC.tabBarItem.selectedImage =  [UIImage imageNamed:selectedImage];
    childVC.title = title;
    
    BaseNavigationController *baseNav = [[BaseNavigationController alloc] initWithRootViewController:childVC];
    
    [self addChildViewController:baseNav];
}

- (void)baseTabbarClickButtonAction:(BaseTabbar *)tabBar{
    DLog(@"点击了中间按钮");
}

@end
