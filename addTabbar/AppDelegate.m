//
//  AppDelegate.m
//  addTabbar
//
//  Created by 000 on 16/11/21.
//  Copyright © 2016年 faner. All rights reserved.
//
/*
    新浪判断
    1.先判断有没有帐号
    2.判断是不是第一次使用
 */

#import "AppDelegate.h"
#import "QZOAuthViewController.h"
#import "QZAccountTool.h"
#import "UIWindow+Extension.h"
#import "SDWebImageManager.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //1.创建窗口
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    
    
    QZAccount *account =[QZAccountTool account];
    
    if (account) {//如果存在 说明之前已经登陆成功过
        [self.window switchRootViewController];
    } else {
        self.window.rootViewController = [[QZOAuthViewController alloc] init];

    }
    
    
    //3.显示窗口
    [self.window makeKeyAndVisible];
    
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}
/**
 *  当app进入后台时调用
 *
 */
- (void)applicationDidEnterBackground:(UIApplication *)application {
    /**
     *  app的状态
     *  1.死亡状态：没有打开app
     *  2.前台运行状态
     *  3.后台暂停状态 ：停止一切动画、定时器、多媒体操作、联网操作，很难再做其他操作
     *  4.后台运行状态 ：
     *
     */
    //向操作系统申请后台运行的资格，能维持多久是不确定的
    UIBackgroundTaskIdentifier task = [application beginBackgroundTaskWithExpirationHandler:^{
        //当申请的后台运行时间已经结束（过期），就会掉用这个block
        [application endBackgroundTask:task];
    }];
    //在info。plist中设置 App plays audio or streams audio/video using AirPlay
    //搞一个0kb的MP3文件，没有声音
    //循环播放
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    SDWebImageManager *mgr = [SDWebImageManager sharedManager];
    //1.取消下载
    [mgr cancelAll];
    //2.清除内存中所有图片
    [mgr.imageCache clearMemory];
}
@end
