//
//  TestViewController.m
//  addTabbar
//
//  Created by 000 on 16/11/21.
//  Copyright © 2016年 faner. All rights reserved.
//

#import "TestViewController.h"
#import "est2ViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    est2ViewController *test2 = [[est2ViewController alloc] init];
    test2.title = @"测试2控制器";
    [self.navigationController pushViewController:test2 animated:YES];
}
@end
