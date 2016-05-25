//
//  TXSignInViewController.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/5/17.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXSignInViewController.h"
#import "AFNetworking.h"
#import "HomeController.h"
#import "TXRequestData.h"
#import "TXPersonalCenterModel.h"
@interface TXSignInViewController ()
{
    TXRegisteredViewController * _registeredViewController;
    HomeController             * _homeViewController;
}
@end

@implementation TXSignInViewController
#pragma mark==================设置导航栏==================
-(void)setNavigationView
{
    CGFloat  signInNavigationViewX         = 0;
    CGFloat  signInNavigationViewY         = 0;
    CGFloat  signInNavigationViewW         = self.view.frame.size.width;
    CGFloat  signInNavigationViewH         = 64;
    _signInNavigationView                  = [[TXSignInNavigationView alloc]init];
    _signInNavigationView.frame            = CM(signInNavigationViewX, signInNavigationViewY, signInNavigationViewW, signInNavigationViewH);
    _signInNavigationView.titleLabel.text  = @"登录";
    [_signInNavigationView.rightBut setTitle:@"忘记密码" forState:UIControlStateNormal];
    //导航栏返回按钮
    [_signInNavigationView.backBut addTarget:self action:@selector(signInNavigationViewBackBut:) forControlEvents:UIControlEventTouchUpInside];
    [_signInNavigationView.rightBut addTarget:self action:@selector(signInNavigationViewforgetPasswordBut:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_signInNavigationView];
}
#pragma mark==================初始化视图==================
-(void)initView
{
    CGFloat signInbackgroundViewX         = 0;
    CGFloat signInbackgroundViewY         = 64;
    CGFloat signInbackgroundViewW         = self.view.frame.size.width;
    CGFloat signInbackgroundViewH         = self.view.frame.size.height-signInbackgroundViewY;
    _signInbackgroundView                 = [[TXSignInbackgroundView alloc]init];
    _signInbackgroundView.frame           = CM(signInbackgroundViewX, signInbackgroundViewY,signInbackgroundViewW , signInbackgroundViewH);
    
    
    //账号输入框
    _signInbackgroundView.userAccount.textField.text  = @"yamiadei";
    //密码输入框
    _signInbackgroundView.userPassword.textField.text = @"323000";
    
    
    
    //注册按钮
    [_signInbackgroundView.registeredBut addTarget:self action:@selector(signInbackgroundViewRegisteredBut:) forControlEvents:UIControlEventTouchUpInside];
    //登录按钮
    [_signInbackgroundView.signInBut addTarget:self action:@selector(signInbackgroundViewSignInBut:) forControlEvents:UIControlEventTouchUpInside];
    
    //微博按钮
    [_signInbackgroundView.thirdPartyIoginView.weiboBut addTarget:self action:@selector(thirdPartyIoginViewWeiBoBut:) forControlEvents:UIControlEventTouchUpInside];
    //QQ按钮
     [_signInbackgroundView.thirdPartyIoginView.qqBut addTarget:self action:@selector(thirdPartyIoginViewQQbut:) forControlEvents:UIControlEventTouchUpInside];
    //微信按钮
    [_signInbackgroundView.thirdPartyIoginView.weixinBut addTarget:self action:@selector(thirdPartyIoginViewWeiXinBut:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_signInbackgroundView];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
     self.view.backgroundColor=[UIColor whiteColor];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark----------------导航栏返回按钮-------------------
-(void)signInNavigationViewBackBut:(UIButton * )but
{
    [self dismissViewControllerAnimated:NO completion:nil];
}
#pragma mark----------------导航栏忘记密码按钮-------------------
-(void)signInNavigationViewforgetPasswordBut:(UIButton *)but
{
    NSLog(@"导航栏——忘记密码按钮");
}
#pragma mark----------------登录按钮-------------------
-(void)signInbackgroundViewSignInBut:(UIButton*)but
{
    
    HomeController * homeViewController=[[HomeController alloc]init];
    [self presentViewController:homeViewController animated:YES completion:^{
        TXRequestData * data=[[TXRequestData alloc]init];
        [data signInWithUserAccount:_signInbackgroundView.userAccount.textField.text UserPassword:_signInbackgroundView.userPassword.textField.text];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"登录" object:self];
    }];
    NSLog(@"登录按钮");
}
#pragma mark----------------注册按钮-------------------
-(void)signInbackgroundViewRegisteredBut:(UIButton*)but
{
    NSLog(@"注册按钮");
    _registeredViewController=[[TXRegisteredViewController alloc]init];
    [self presentViewController:_registeredViewController animated:NO completion:nil];
}
#pragma mark----------------第三方登录———微博按钮-------------------
-(void)thirdPartyIoginViewWeiBoBut:(UIButton *)but
{
    
    
    NSLog(@"第三方登录——微博按钮");
}
#pragma mark----------------第三方登录———QQ按钮-------------------
-(void)thirdPartyIoginViewQQbut:(UIButton*)but
{
    NSLog(@"第三方登录——QQ按钮");
}
#pragma mark----------------第三方登录———微信按钮-------------------
-(void)thirdPartyIoginViewWeiXinBut:(UIButton *)but
{
    NSLog(@"第三方登录——微信按钮");
}
-(void)dealloc
{
    NSLog(@"登录页面--释放");
}
@end
