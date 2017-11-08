//
//  QZTabBar.m
//  addTabbar
//
//  Created by 000 on 16/11/30.
//  Copyright © 2016年 faner. All rights reserved.
//

#import "QZTabBar.h"
#import "UIView+Extestion.h"

@interface QZTabBar ()
@property (nonatomic, strong) UIButton *plusBtn;
@end

@implementation QZTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self= [super initWithFrame:frame];
    if (self) {
        //2. 添加一个按钮到tabbar中
        UIButton *plusBtn = [[UIButton alloc] init];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        plusBtn.size = plusBtn.currentBackgroundImage.size;
        
        [plusBtn addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
        
        self.plusBtn = plusBtn;
        
        [self addSubview:plusBtn];
    }
    return self;
}

- (void)plusClick
{
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [self.delegate tabBarDidClickPlusButton:self];
    }

}

- (void)layoutSubviews
{   //  一定要掉用
    [super layoutSubviews];
    
    //1.设置加号按钮的位置
    self.plusBtn.centerX = self.width *0.5;
    self.plusBtn.centerY = self.height*0.5;
    //2.设置其他tabbarButton的位置和尺寸
    
    CGFloat tabbarButtonW = self.width/5;
    CGFloat tabbarButtonIndex = 0;
    int count = (int)self.subviews.count;
    for (int i = 0; i<count; i++) {
        UIView *child = self.subviews[i];
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            child.width = tabbarButtonW;
            child.x=tabbarButtonIndex*tabbarButtonW;
            tabbarButtonIndex ++;
            if ( tabbarButtonIndex == 2) {
                tabbarButtonIndex++;
            }
        }
    }
}

@end
