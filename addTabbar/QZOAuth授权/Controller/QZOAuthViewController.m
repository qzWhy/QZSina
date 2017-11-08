//
//  QZOAuthViewController.m
//  addTabbar
//
//  Created by 000 on 16/12/2.
//  Copyright © 2016年 faner. All rights reserved.
//  "access_token" = "2.00Q7nGaFFgFDCBab82040f85ojpLtC";
/*
    access_token 包含两个信息
    1.应用信息
    2.用户信息
 expires_in" = 157679999
  uid = 5114232208; ＝＝user_id
 */

#import "QZOAuthViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MS.h"
#import "QZAccountTool.h"
#import "UIWindow+Extension.h"
@interface QZOAuthViewController ()<UIWebViewDelegate>
@end

@implementation QZOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIWebView *webView = [[UIWebView alloc] init];
    webView.delegate = self;
    webView.frame = self.view.bounds;
    [self.view addSubview:webView];
    //2.用webView加载登陆页面（新浪提供的）
    //请求地址：https://api.weibo.com/oauth2/authorize
    /*请求参数：client_id＝946422317 ture string 申请应用时分配的Appkey
     redirect_uri ture string 授权回调地址，站外应用需与设置的回调地址一致，站内应用需填写canvas page的地址
     */
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=946422317&redirect_uri=http://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在加载数据..."];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}

/**
 *  拦截数据请求
 *
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //获得url
    NSString *url = request.URL.absoluteString;
    
    //2.判断是否为回调地址
    NSRange range = [url rangeOfString:@"code="];
    if (range.length !=0) {//是回调地址
        //街区code＝后面的参数值
        int fromIndex = (int)range.location + (int)range.length;
        NSString *code = [url substringFromIndex:fromIndex];
        NSLog(@"code=%@",code);
        
        //利用code换取一个accessToken
        [self accessTokenWithCode:code];
        //禁止加载回调地址
        return NO;//没必要加载回调
    }
    return YES;
}

- (void)accessTokenWithCode:(NSString *)code
{
    /*
     URL: https://api.weibo.com/oauth2/access_token
     请求参数：
     client_id	true	string	申请应用时分配的AppKey。
     client_secret	true	string	申请应用时分配的AppSecret。
     grant_type	true	string	请求的类型，填写authorization_code
     
     code	true	string	调用authorize获得的code值。
     redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。
     */
    //1.请求管理者
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];//默认的
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    //2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = @"946422317";
    params[@"client_secret"] = @"5d3e0c51027d9d970911be06441cfe7e";
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = @"http://www.baidu.com";
    
    //3.发送请求
    [manager POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUD];
        //将返回方法转为模型
        QZAccount *account = [QZAccount accountWithDic:responseObject];
        
        //存储帐号信息
        [QZAccountTool saveAccount:account];
        //切换跟控制器
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window switchRootViewController];
        
        //UIWindow的分类、QZWindowTool
        //UIViewController的分类、QZControllerTool

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUD];
        NSLog(@"%@",error);//在这儿可以看错误信息Error Domain=com.alamofire.error.serialization.response Code=-1016 "Request failed: unacceptable content-type: text/plain" 这就是因为content-type
    }];
}

@end
