//
//  UIBarButtonItem+Extension.m
//  addTabbar
//
//  Created by 000 on 16/11/25.
//  Copyright © 2016年 faner. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#import "UIView+Extestion.h"
@implementation UIBarButtonItem (Extension)
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image hignImage:(NSString *)hignImage
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    //设置图片
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:hignImage] forState:UIControlStateHighlighted];
    btn.size = btn.currentBackgroundImage.size;
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}

@end
