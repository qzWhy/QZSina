//
//  QZTitleButton.m
//  addTabbar
//
//  Created by 000 on 16/12/6.
//  Copyright © 2016年 faner. All rights reserved.
//

#import "QZTitleButton.h"
#import "UIBarButtonItem+Extension.h"
#import "UIView+Extestion.h"

@implementation QZTitleButton
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
        self.imageView.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    //如果仅仅调整按钮内部titleLable和imageView的位置
    //1.计算titleLable的frame
    
    self.titleLabel.x = self.imageView.x;
    //2.计算imageView的frame
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame);
}
- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    //文字自适应
    [self sizeToFit];
}
- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    //图片自适应
    [self sizeToFit];
}
@end
