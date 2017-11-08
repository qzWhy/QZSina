//
//  QZNewFeatureViewController.m
//  addTabbar
//
//  Created by 000 on 16/11/30.
//  Copyright © 2016年 faner. All rights reserved.
//

#import "QZNewFeatureViewController.h"
#import "UIView+Extestion.h"
#import "QZTabbarController.h"

#define QZNewfeatureCount 4
@interface QZNewFeatureViewController ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIPageControl *pageControl;
@end

@implementation QZNewFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.创建一个scrollView：显示所有的新特性图片
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    //2.添加图片到scrollView中
    CGFloat scrollW = scrollView.width;
    CGFloat scrollH = scrollView.height;//这样不用多次掉用get方法
    for (int i = 0; i<QZNewfeatureCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.userInteractionEnabled = YES;
        imageView.width = scrollW;
        imageView.height = scrollH;
        imageView.y=0;
        imageView.x = i *scrollW;
        //显示图片
        NSString *name = [NSString stringWithFormat:@"new_feature%d",i+1];
        imageView.image = [UIImage imageNamed:name];
        [scrollView addSubview:imageView];
        //如果是最后一个imageView，就往里面添加其他内容
        if ( i == QZNewfeatureCount-1) {
            [self setupLastImageView:imageView];
        }
        
    }
    //3.如果想要某个方向上不能滚动，那么这个方向对应的尺寸数值0即可
    scrollView.contentSize = CGSizeMake(QZNewfeatureCount*scrollW, 0);
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    
    //4.添加pageControl：分页，展示目前看的是第几页
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = QZNewfeatureCount;
    //    pageControl.backgroundColor = [UIColor redColor];

    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    pageControl.centerX = scrollW*0.5;
    pageControl.centerY = scrollH-50;
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
    
    //UIPageControl 没有尺寸也能显示
    //    pageControl.width = 100;
    //    pageControl.height = 50;没有高度 就没有可点击
    //    pageControl.userInteractionEnabled = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double page = scrollView.contentOffset.x/scrollView.width;
    self.pageControl.currentPage = (int)(page+0.5);
    //四舍五入
    /**
     *  数＋0.5 转成整数  就是四舍五入
     */
}
/**
 *  初始化最后一个imageView
 *
 *  @param imageView 最后一个imageView
 */
- (void)setupLastImageView:(UIImageView *)imageView
{
    //1.分享给大家（checkbox）
    UIButton *shareBtn = [[UIButton alloc] init];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [shareBtn setTitle:@"分享给大家" forState:UIControlStateNormal];
//    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shareBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    shareBtn.width = 200;
    shareBtn.height = 30;
    shareBtn.centerX = imageView.width*0.5;
    shareBtn.centerY = imageView.height*0.65;
    [shareBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:shareBtn];
    shareBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    //2.开始微博
    UIButton *starBtn = [[UIButton alloc] init];
    [starBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [starBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    [starBtn setImage:[UIImage imageNamed:@"new_feature_button"] forState:UIControlStateNormal];
    [starBtn setImage:[UIImage imageNamed:@"new_feature_button_highlighted"] forState:UIControlStateHighlighted];
    starBtn.size = starBtn.currentBackgroundImage.size;
    starBtn.centerX = shareBtn.centerX;
    starBtn.centerY = imageView.height *0.75;
    [starBtn addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
//    [starBtn setTitle:@"开始微博" forState:UIControlStateNormal];    
    [imageView addSubview:starBtn];
}
- (void)shareClick:(UIButton *)shareBtn
{
    shareBtn.selected = !shareBtn.isSelected;
}
- (void)startClick
{
    //切换到QZTabBarController
    /*
     1.push： 依赖于UINavgationController，控制器的切换是可逆的，比如A切换到B，B又可以回到A
     2.modal： 控制器是可逆的
     3.切换window的rootViewController  不可逆
     */
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [[QZTabbarController alloc] init];
}
@end
