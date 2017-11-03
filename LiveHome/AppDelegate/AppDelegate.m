//
//  AppDelegate.m
//  LiveHome
//
//  Created by chh on 2017/10/27.
//  Copyright © 2017年 chh. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseTabBarController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
//微信SDK头文件
#import "WXApi.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = [[BaseTabBarController alloc] init];
    
    //初始化shardSdk
    [self registerShareSDK];
    
    return YES;
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    if (self.allowLandscapeRight) {
        return UIInterfaceOrientationMaskLandscapeRight;
    }
    return UIInterfaceOrientationMaskPortrait;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - 集成shareSDK
#warning 更改
/**
 *  ⚠️⚠️⚠️⚠️正式使用时info.plist 文件中的key和secret要换成本项目的，wechat和QQ 的ID和Key也要更换⚠️⚠️⚠️⚠️
 **/
- (void)registerShareSDK{
    /**初始化ShareSDK应用
     @param activePlatforms
     使用的分享平台集合
     @param importHandler (onImport)
     导入回调处理，当某个平台的功能需要依赖原平台提供的SDK支持时，需要在此方法中对原平台SDK进行导入操作
     @param configurationHandler (onConfiguration)
     配置回调处理，在此方法中根据设置的platformType来填充应用配置信息
     */
    [ShareSDK registerActivePlatforms:@[@(SSDKPlatformTypeWechat),
                                        @(SSDKPlatformTypeQQ),]
                             onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             default:
                 break;
         }
     }
     onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         switch (platformType)
         {
                 
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wxe2053cbb105fa55b"
                                       appSecret:@"99887af53031e6b616c8d8ae87c7a5c1"];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"1106004243"
                                      appKey:@"SSYsolH7ix6zRk6i"
                                    authType:SSDKAuthTypeBoth];
                 break;
             default:
                 break;
         }
     }];
}

@end
