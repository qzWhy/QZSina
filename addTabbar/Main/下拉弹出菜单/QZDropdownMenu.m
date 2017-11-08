//
//  QZDropdownMenu.m
//  addTabbar
//
//  Created by 000 on 16/11/25.
//  Copyright © 2016年 faner. All rights reserved.
//

#import "QZDropdownMenu.h"
#import "UIView+Extestion.h"

@interface QZDropdownMenu ()

@property (nonatomic, strong)UIImageView *containView;


@end

@implementation QZDropdownMenu
/**
 *  将来用来显示具体内容的容器
 */
- (UIImageView *)containView
{
    if (_containView == nil) {
        _containView = [[UIImageView alloc] init];
        _containView.image = [UIImage imageNamed:@"popover_background"];
//        _containView.width = 217;
//        _containView.height = 217;
        _containView.userInteractionEnabled = YES;//开启用户交互
    }
    return _containView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //清除颜色
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.containView];
    }
    return self;
}

+ (instancetype)menu
{
    return [[self alloc] init];
}
/**
 *  显示
 */
- (void)showFrom:(UIView *)from
{
    //1.获取主window
    UIWindow *window = [UIApplication sharedApplication].windows.lastObject;
    //2.添加自己倒窗口上
    [window addSubview:self];
    //3.设置尺寸
    self.frame = window.bounds;
    //4.调整灰色图片的位置
    CGRect newFrame = [from convertRect:from.bounds toView:window];
    
    self.containView.centerX = CGRectGetMidX(newFrame);
    self.containView.y = CGRectGetMaxY(newFrame);
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidShow:)]) {
        [self.delegate dropdownMenuDidShow:self];
    }

    
}
/**
 *  销毁
 */
- (void)dismiss
{
    [self removeFromSuperview];
    //通知外界 ，自己被销毁
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidDismiss:)]) {
        [self.delegate dropdownMenuDidDismiss:self];
    }

}

- (void)setContent:(UIView *)content
{
    _content = content;
    
    _content.x=10;
    _content.y=15;
    
    //调整内容的宽度
//    content.width = self.containView.width- 2*content.x;
    self.containView.width = CGRectGetMaxX(content.frame)+10;
    //设置灰色的高度
    self.containView.height = CGRectGetMaxY(content.frame)+10;
    
    
    //添加内容到灰色内容
    [self.containView addSubview:content];
}

- (void)setContentController:(UIViewController *)contentController
{
    _contentController = contentController;
    self.content = contentController.view;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismiss];
}
@end
