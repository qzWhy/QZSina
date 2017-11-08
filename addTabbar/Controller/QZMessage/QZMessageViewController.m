//
//  QZMessageViewController.m
//  addTabbar
//
//  Created by 000 on 16/11/21.
//  Copyright © 2016年 faner. All rights reserved.
//

#import "QZMessageViewController.h"
#import "TestViewController.h"
#import "QZDropdownMenu.h"
#import "UIView+Extestion.h"


@interface QZMessageViewController ()

@end

@implementation QZMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"写私信" style:UIBarButtonItemStylePlain target:self action:@selector(compose)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    UIButton *button = [[UIButton alloc] init];
    button.frame = CGRectMake(100, 200, 100, 30);
    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];

}
- (void)titleClick:(UIButton *)btn
{
    QZDropdownMenu *menu = [QZDropdownMenu menu];
    
    UIButton *btn1 = [[UIButton alloc] init];
    btn1.width = 200;
    btn1.height = 100;
    btn1.backgroundColor = [UIColor redColor];
    
    menu.content = btn1;
    [menu showFrom:btn];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)compose
{
    NSLog(@"%s",__func__);
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"test-message-%d",(int)indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TestViewController *test1 = [[TestViewController alloc] init];
    test1.title = @"测试1控制器";
    //当test1控制器被push的时候， test1所在的tabbarcontroller的tabbar会自动隐藏
    //当test1控制器被pop的时候，test1所在的tabbarcontroller的tabbar会自动显示
    test1.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:test1 animated:YES];
    
}

@end
