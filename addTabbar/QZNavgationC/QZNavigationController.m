//
//  QZNavigationController.m
//  addTabbar
//
//  Created by 000 on 16/11/21.
//  Copyright © 2016年 faner. All rights reserved.
//

#import "QZNavigationController.h"

#import "UIBarButtonItem+Extension.h"

@implementation QZNavigationController

+ (void)initialize
{
    //设置整个项目所有item的主题样式
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    //设置普通状态
    // key : NS***AttributeName
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName]=[UIColor orangeColor];
    textAttrs[NSFontAttributeName]=[UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    //设置不可用状态
    // key : NS***AttributeName
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
    disableTextAttrs[NSForegroundColorAttributeName]=[UIColor lightGrayColor];
    disableTextAttrs[NSFontAttributeName]=[UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
        [super pushViewController:viewController animated:animated];
    if (self.viewControllers.count > 1) {//这时push进来的控制器viewController，不是第一个自控制器（不是根控制器）自动显示和隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
        
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"navigationbar_back_icon"  hignImage:@"navigationbar_pic_back_icon"];
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(more) image:@"tabbar_profile" hignImage:@"tabbar_profile_selected"];
    }    
}
- (void)back
{
    //回到根控制器
    [self popViewControllerAnimated:YES];
}

- (void)more
{
    [self popToRootViewControllerAnimated:YES];
}
@end
