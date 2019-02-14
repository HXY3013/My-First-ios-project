//
//  ViewController.m
//  JiaoZuoEmergency
//
//  Created by sc on 2019/2/12.
//  Copyright © 2019年 hxy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setStatusBarBackgroundColor:[UIColor colorWithRed:44/255.0 green:102/255.0 blue:211/255.0 alpha:1]];
    // Do any additional setup after loading the view, typically from a nib.
    UIWebView * webview = [[UIWebView alloc]initWithFrame:self.view.frame];
    webview.delegate = self;
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.15.60"]]];
    [self.view addSubview:webview];
//    self.view.backgroundColor = [UIColor colorWithRed:44/255.0 green:102/255.0 blue:211/255.0 alpha:1];
}

//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

#pragma mark -- 拦截webview用户触击了一个链接

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //判断是否是单击
    if (navigationType == UIWebViewNavigationTypeLinkClicked)
    {
        NSString *url = [request.URL absoluteString];
        //拦截链接跳转到货源圈的动态详情
        if ([url rangeOfString:@"baidumap:"].location != NSNotFound)
        {
            if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"baidumap://"]])
            {
                //百度地图
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:url] options:nil completionHandler:nil];
            }else
            {
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"未安装百度地图,请前去下载安装" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * DownLoadBtn = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/bai-du-tu-shou-ji-tu-lu-xian/id452186370?mt=8&v0=WWW-GCCN-ITSTOP100-FREEAPPS&l=&ign-mpt=uo%3D4"]];
                }];
                [alert addAction:DownLoadBtn];
                [self presentViewController:alert animated:true completion:nil];
            }
            return NO;//返回NO,此页面的链接点击不会继续执行,只会执行跳转到你想跳转的页面
        }
    }
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
