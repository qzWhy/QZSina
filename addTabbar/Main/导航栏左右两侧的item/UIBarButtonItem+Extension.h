//
//  UIBarButtonItem+Extension.h
//  addTabbar
//
//  Created by 000 on 16/11/25.
//  Copyright © 2016年 faner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
/**
 *  创建一个item
 *
 *  @param target    点击item后掉用哪个对象的方法
 *  @param action    点击item后掉用target的那个方法
 *  @param image     图片
 *  @param hignImage 高亮图片
 *
 *  @return 创建完的item
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image hignImage:(NSString *)hignImage;

@end
