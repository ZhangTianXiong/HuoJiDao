//
//  TXScrollFigureViewController.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/5/12.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXScrollFigureViewController.h"

@interface TXScrollFigureViewController ()
{
    WKWebView * webView;
}
@end

@implementation TXScrollFigureViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.titleLabel.text=@"链接";
 
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getLink:) name:@"getLink" object:nil];
    
}
-(void)getLink:(NSNotification*)notifiction
{
    NSLog(@"%@",notifiction.userInfo[@"link"]);
    NSString * strURL=notifiction.userInfo[@"link"];
    CGFloat viewW=self.view.frame.size.width;
    CGFloat viewH=self.view.frame.size.height;
    CGFloat webViewX=0;
    CGFloat webViewY=64;
    CGFloat webViewW=viewW;
    CGFloat webViewH=viewH-64;
    webView=[[WKWebView alloc]initWithFrame:CM(webViewX, webViewY, webViewW, webViewH)];
    NSURL    * url=[NSURL URLWithString:strURL];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    [self.view addSubview:webView];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}



@end
