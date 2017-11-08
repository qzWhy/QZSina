//
//  QZTabbarController.m
//  addTabbar
//
//  Created by 000 on 16/11/21.
//  Copyright © 2016年 faner. All rights reserved.
//

#import "QZTabbarController.h"
#import "QZNavigationController.h"
#import "QZHomeViewController.h"
#import "QZMessageViewController.h"
#import "QZDiscoverViewController.h"
#import "QZProfileViewController.h"
#import "UIView+Extestion.h"
#import "QZTabBar.h"
@interface QZTabbarController ()<QZTabBarDelegate>

@end

@implementation QZTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    QZHomeViewController *homeVc = [[QZHomeViewController alloc] init];
    [self addChildVc:homeVc title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
    QZMessageViewController *messageVc = [[QZMessageViewController alloc] init];
    [self addChildVc:messageVc title:@"信息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    
//    [self addChildViewController:[[UIViewController alloc] init]];
    
    QZDiscoverViewController *discoverVc = [[QZDiscoverViewController alloc] init];
    [self addChildVc:discoverVc title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    
    QZProfileViewController *profileVc = [[QZProfileViewController alloc] init];
    [self addChildVc:profileVc title:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
    
    //更换系统自带的tabBar
    QZTabBar *tabBar = [[QZTabBar alloc] init];
//    self.tabBar = [[QZTabBar alloc] init];
    [self setValue:tabBar forKey:@"tabBar"];//这行代码过后，tabBar的delegate就是QZTabBarViewController
//    tabBar.delegate = self;
    //说明不用再设置tabBar.delegate ＝ self；
    
    //如果再次修改tabBar的delegate属性，就会报错
    
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    int count = (int)self.tabBar.subviews.count;
//    for (int i = 0; i<count; i++) {
//        UIView *child = self.tabBar.subviews[i];
//        Class class = NSClassFromString(@"UITabBarButton");
//        if ([child isKindOfClass:class]) {
//            child.width = self.tabBar.width/count;
//        }
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  添加子控制器
 *
 *  @param childVc       子控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中图片
 */
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    childVc.title = title;//同时设置tabbar和navigationBar的文字
    
    //设置自控制器的图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //设置导航控制器
    QZNavigationController *nav = [[QZNavigationController alloc] initWithRootViewController:childVc];
    //添加为子控制器
    [self addChildViewController:nav];
}
#pragma mark - QZTabBarDelegate

- (void)tabBarDidClickPlusButton:(QZTabBar *)tabBar
{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor redColor];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
