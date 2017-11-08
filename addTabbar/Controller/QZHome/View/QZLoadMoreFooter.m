//
//  QZLoadMoreFooter.m
//  addTabbar
//
//  Created by 000 on 16/12/8.
//  Copyright © 2016年 faner. All rights reserved.
//

#import "QZLoadMoreFooter.h"

@implementation QZLoadMoreFooter

+ (instancetype)footer
{
    return [[NSBundle mainBundle] loadNibNamed:@"QZLoadMoreFooter" owner:nil options:nil].lastObject;
}

@end
