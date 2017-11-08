//
//  QZDropdownMenu.h
//  addTabbar
//
//  Created by 000 on 16/11/25.
//  Copyright © 2016年 faner. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QZDropdownMenu;

@protocol QZDropdownMenuDelegate <NSObject>
@optional
- (void)dropdownMenuDidDismiss:(QZDropdownMenu *)menu;
- (void)dropdownMenuDidShow:(QZDropdownMenu *)menu;

@end

@interface QZDropdownMenu : UIView

@property (nonatomic, weak) id<QZDropdownMenuDelegate> delegate;

+ (instancetype)menu;
/**
 *  显示
 */
- (void)showFrom:(UIView *)from;
/**
 *  销毁
 */
- (void)dismiss;
/**
 *  里面的内容
 */
@property (nonatomic, strong) UIView *content;
/**
 *  内容控制器
 */
@property (nonatomic, strong) UIViewController *contentController;
@end
