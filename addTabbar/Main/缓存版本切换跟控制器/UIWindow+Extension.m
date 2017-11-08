//
//  UIWindow+Extension.m
//  addTabbar
//
//  Created by 000 on 16/12/5.
//  Copyright © 2016年 faner. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "QZTabbarController.h"
#import "QZNewFeatureViewController.h"
@implementation UIWindow (Extension)
- (void)switchRootViewController
{
    NSString *key = @"CFBundleVersion";
    //存储在沙盒中的版本号（上一次的使用版本）
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    //当前软件版本号（从info。plist中获得）
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    if ([currentVersion isEqualToString:lastVersion]) {//版本号相同：这次打开和上次打开的是同一个版本
        self.rootViewController = [[QZTabbarController alloc] init];
    } else {
        //将版本号存进沙盒
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        self.rootViewController = [[QZNewFeatureViewController alloc] init];
    }

}
@end
