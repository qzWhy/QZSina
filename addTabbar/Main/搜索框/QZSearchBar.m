//
//  QZSearchBar.m
//  addTabbar
//
//  Created by 000 on 16/11/25.
//  Copyright © 2016年 faner. All rights reserved.
//

#import "QZSearchBar.h"
#import "UIView+Extestion.h"

@implementation QZSearchBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.font = [UIFont systemFontOfSize:15];
        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        self.placeholder = @"请输入搜索条件";
        UIImageView *searchIcon = [[UIImageView alloc] init];
        searchIcon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        searchIcon.width = 30;
        searchIcon.height = 30;
        searchIcon.contentMode = UIViewContentModeCenter;
        self.leftView = searchIcon;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

+ (instancetype)searchBar
{
    return [[self alloc] init];//这样做可以 进来后直接掉用initWithFrame：方法
}

@end
