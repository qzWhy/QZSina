//
//  QZHomeViewController.m
//  addTabbar
//
//  Created by 000 on 16/11/21.
//  Copyright © 2016年 faner. All rights reserved.
//

#import "QZHomeViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "UIView+Extestion.h"
#import "QZDropdownMenu.h"
#import "QZTitleViewController.h"
#import "AFNetworking.h"
#import "QZAccountTool.h"
#import "QZTitleButton.h"
#import "UIImageView+WebCache.h"
#import "QZUser.h"
#import "QZStatus.h"
#import "MJExtension.h"
#import "QZLoadMoreFooter.h"
@interface QZHomeViewController ()<QZDropdownMenuDelegate>
/**
 *  微博数组（里面放的都是QZStatus模型(字典)，一个QZStatus模型（字典）就代表一条微博）
 */
@property (nonatomic, strong) NSMutableArray *statuses;
@end

@implementation QZHomeViewController

- (NSMutableArray *)statuses
{
    if (_statuses == nil) {
        _statuses = [NSMutableArray array];
    }
    return _statuses;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏内容
    [self setupNav];
    
    //获得用户信息（昵称）
    [self setupUserInfo];
    
    //集成下拉刷新控件
    [self setupDownRefresh];
    
    //集成上拉刷新控件
    [self setupUpRefresh];
    
    //获得未读数
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(setupUnreadCount) userInfo:nil repeats:YES];
    //不管加不加runloop 它都已经在runloop中 默认模式
    //主线程也会抽时间处理一下timer(不管主线程是否正在处理其他事件)
    //不加这句话 当一直滑动tableView时time timer是不会计时的
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
}
/**
 *  获得未读数
 */
- (void)setupUnreadCount
{
    // 通知 NSNotification 不可见
    // 本地通知
    //远程推送通知
    
//    NSLog(@"setupUnreadCount");
    //1.请求管理者
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    
    //2.拼接请求参数
    QZAccount *account = [QZAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"]= account.uid;
    
    //3.发送请求
    [manager GET:@"https://api.weibo.com/2/remind/unread_count.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // 微博的未读数
//        int status = [responseObject[@"status"] intValue];
//        //设置提醒数字d
//        self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",status];
        
        // 直接将NSNumber-->NSString
        NSString *status = [responseObject[@"status"]description];
        NSLog(@"1111%@",status);
        if ([status isEqualToString:@"0"]) { //当tabbar右上角数组为o时
            self.tabBarItem.badgeValue = nil;
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
            float version = [[[UIDevice currentDevice] systemVersion] floatValue];
            //iOS8以前，不能带它，iOS8及以后必须带它
            if (version >= 8.0) {
                UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
                [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
            }
        } else {
            self.tabBarItem.badgeValue = status;
            [UIApplication sharedApplication].applicationIconBadgeNumber = status.intValue;
            float version = [[[UIDevice currentDevice] systemVersion] floatValue];
            //iOS8以前，不能带它，iOS8及以后必须带它
            if (version >= 8.0) {
                UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
                [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
                
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];

}
- (void)setupUpRefresh
{
    QZLoadMoreFooter *footer = [QZLoadMoreFooter footer];
    self.tableView.tableFooterView = footer;
}
/**
 *  集成下拉刷新控件
 */
- (void)setupDownRefresh
{
    //1.添加刷新控件
    UIRefreshControl *control = [[UIRefreshControl alloc] init];
    [control addTarget:self action:@selector(refreshStateChange:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:control];
    //2.马上进入刷新状态（仅仅是显示刷新状态，并不会触发UIControlEventValueChanged事件）
    [control beginRefreshing];
    [self refreshStateChange:control];
}
/**
 *  UIRefreshControl进入刷新状态：加载最新的数据
 */
- (void)refreshStateChange:(UIRefreshControl *)control
{
    //1.请求管理者
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    //2.拼接请求参数
    QZAccount *account = [QZAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    //    params[@"count"]=@10;//默认20；
    QZStatus *firstStatus = [self.statuses firstObject];
    if (firstStatus) {
        //若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博，默认为0）
        params[@"since_id"] = firstStatus.idstr;
    }
    
    //3.发送请求
    [manager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        /** 字典数组转模型数组  方法二： 简单用法 */
        NSArray *newStatus = [QZStatus mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        //将最新的微博数组，添加到总数组的最前面
//        [self.statuses addObjectsFromArray:newStatus];
        NSRange range = NSMakeRange(0, newStatus.count);
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statuses insertObjects:newStatus atIndexes:set];
        //刷新数组
        [self.tableView reloadData];
        //结束刷新
        [control endRefreshing];
        //显示最新微博的数量
        [self showNewStatusCount:(int)newStatus.count];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [control endRefreshing];
    }];

}
/**
 *  显示最新微博数量
 *
 *  @param count 最新微博数量
 */
- (void)showNewStatusCount:(int)count
{
    //刷新成功(清空微博数量)
    self.tabBarItem.badgeValue = nil;
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
     float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    //iOS8以前，不能带它，iOS8及以后必须带它
    if (version >= 8.0) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        
    }

    //1.创建label
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.width = [UIScreen mainScreen].bounds.size.width;
    label.height = 35;
    
    //2.设置其他属性
    if (count == 0) {
        label.text = @"没有新的微博数据，稍后再试";
    } else {
        label.text = [NSString stringWithFormat:@"共有%d条新的微博",count];
    }
    label.textColor = [UIColor whiteColor];
    label.textAlignment=NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:16];
    
    //3.添加
    /**
     *  window不行 tabview 不行 navView
     */
    label.y = 64- label.height;
//    [self.navigationController.view addSubview:label];//这个会盖住导航栏
    //将label添加到导航控制器的view中，并且该在导航栏的下边
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    //4.动画
    CGFloat duration = 1.0;//动画时间
    [UIView animateWithDuration:duration animations:^{
//        label.y+= label.height;
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
    } completion:^(BOOL finished) {
        CGFloat delay = 1.0;
        [UIView animateWithDuration:duration delay:delay options:
         // UIViewAnimationOptionCurveLinear 匀速
         UIViewAnimationOptionCurveLinear animations:^{
//             label.y-=label.height;
             label.transform = CGAffineTransformIdentity;
         } completion:^(BOOL finished) {
             [label removeFromSuperview];
         }];
    }];
    /**
     *  如果某个动画执行完毕后又回到原来的状态，建议用transform CGAffineTransformIdentity（回到原来的样子）
     *
     */
}
/**
 *  //获得用户信息（昵称）
 */
- (void)setupUserInfo
{
    //https://api.weibo.com/2/users/show.json
    //access_token	true	string	采用OAuth授权方式为必填参数，OAuth授权后获得。
    //uid	false	int64	需要查询的用户ID。
    //1.请求管理者
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    //2.拼接请求参数
    QZAccount *account = [QZAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    //3.发送请求
    [manager GET:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
        //设置名字
        QZUser *user = [QZUser mj_objectWithKeyValues:responseObject];
        [titleButton setTitle:user.name forState:UIControlStateNormal];
        
        //存储昵称到沙盒中
        account.name = user.name;
        //设置按钮自适应
        [titleButton sizeToFit];
        [QZAccountTool saveAccount:account];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];

}
/**
 *  设置导航栏内容
 */
- (void)setupNav
{
    /* 设置导航栏上面的内容 */
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendsearch) image:@"navigationbar_friendsearch" hignImage:@"navigationbar_friendsearch_highlighted"];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" hignImage:@"navigationbar_pop_highlighted"];
    
    
    //中间标题按钮
    QZTitleButton *titleBtn = [[QZTitleButton alloc] init];
    
    // 设置图片和文字
    NSString *name = [QZAccountTool account].name;
    [titleBtn setTitle:name?name:@"首页" forState:UIControlStateNormal];
    
    
    [titleBtn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    //设置按钮自适应
    [titleBtn sizeToFit];
    self.navigationItem.titleView = titleBtn;

}
- (void)titleClick:(UIButton *)titleButton
{
    //1. 创建下拉菜单
    QZDropdownMenu *menu = [QZDropdownMenu menu];
    menu.delegate = self;
    //2.设置内容
    
    QZTitleViewController *vc = [[QZTitleViewController alloc] init];
    vc.view.height = 44*3;
    vc.view.width = 150;
    menu.contentController = vc;
    
    //3.显示
    [menu showFrom:titleButton];
    
}

- (void)friendsearch
{
    NSLog(@"%s",__func__);
}
- (void)pop
{
    NSLog(@"%s",__func__);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.statuses.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    //取出这行对应的微博字典
    QZStatus *status = self.statuses[indexPath.row];

    QZUser *user = status.user;
    cell.textLabel.text = user.name;
    
    cell.detailTextLabel.text = status.text;
    
    //设置头像
    NSString *imageUrl = user.profile_image_url;
    UIImage *placeholder = [UIImage imageNamed:@"avatar_default_small"];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:placeholder];
    return cell;
}
#pragma mark - QZDropdownMenuDelegate
/**
 *  下拉菜单销毁
 *
 */
- (void)dropdownMenuDidDismiss:(QZDropdownMenu *)menu
{   //4.让箭头向下
    UIButton *titleBtn = (UIButton *)self.navigationItem.titleView;
    titleBtn.selected = NO;
}
/**
 *  下拉菜单创建
 *
 */
- (void)dropdownMenuDidShow:(QZDropdownMenu *)menu
{
    //4.让箭头向上
    UIButton *titleBtn = (UIButton *)self.navigationItem.titleView;
    titleBtn.selected = YES;
//    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
}
/**
 1.将字典转为模型
 2.能够下拉刷新微博数据
 3.上拉加载更多的数据
 */

@end
