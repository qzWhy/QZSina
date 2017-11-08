//
//  QZTabBar.h
//  addTabbar
//
//  Created by 000 on 16/11/30.
//  Copyright © 2016年 faner. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QZTabBar;

@protocol QZTabBarDelegate <UITabBarDelegate>
- (void)tabBarDidClickPlusButton:(QZTabBar *)tabBar;

@end

@interface QZTabBar : UITabBar

@property (nonatomic, weak) id<QZTabBarDelegate> delegate;

@end
