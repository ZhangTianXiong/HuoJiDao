//
//  TXRegisteredViewController.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/5/18.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXRegisteredViewController.h"
@interface TXRegisteredViewController ()
{
    TXVerificationViewController * _verificationViewController;
}
@end

@implementation TXRegisteredViewController
-(void)setNavigationView
{
    CGFloat  registeredNavigationViewX        = 0;
    CGFloat  registeredNavigationViewY        = 0;
    CGFloat  registeredNavigationViewW        = self.view.frame.size.width;
    CGFloat  registeredNavigationViewH        = 64;
    _registeredNavigationView                 = [[TXRegisteredNavigationView alloc]init];
    _registeredNavigationView.frame           = CM(registeredNavigationViewX, registeredNavigationViewY, registeredNavigationViewW, registeredNavigationViewH);
    _registeredNavigationView.titleLabel.text = @"注册账户";
    [self.view addSubview:_registeredNavigationView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
}
-(void)initView
{
    CGFloat registeredbackgroundViewX        = 0;
    CGFloat registeredbackgroundViewY        = 64;
    CGFloat registeredbackgroundViewW        = self.view.frame.size.width;
    CGFloat registeredbackgroundViewH        = self.view.frame.size.height-registeredbackgroundViewY;
    _registeredbackgroundView                = [[TXRegisteredbackgroundView alloc]init];
    _registeredbackgroundView.frame          = CM(registeredbackgroundViewX, registeredbackgroundViewY, registeredbackgroundViewW, registeredbackgroundViewH);
    
    //获取验证码按钮
    
    [_registeredbackgroundView.obtainBut addTarget:self action:@selector(registeredbackgroundViewObtainBut:) forControlEvents:UIControlEventTouchUpInside];
    [_registeredbackgroundView.obtainBut setTitle:@"获取验证码" forState:UIControlStateNormal];
    //协议按钮
    [_registeredbackgroundView.protocolBut addTarget:self action:@selector(registeredbackgroundViewProtocolButBut:) forControlEvents:UIControlEventTouchUpInside];

    
    [self.view addSubview:_registeredbackgroundView];
    
    
}
-(void)registeredNavigationViewBackBut:(UIButton*)but
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark------------------获取验证码按钮-----------------
-(void)registeredbackgroundViewObtainBut:(UIButton *)but
{
    NSLog(@"获取验证码按钮");
    _verificationViewController=[[TXVerificationViewController alloc]init];
    [self presentViewController:_verificationViewController animated:NO completion:nil];
}
#pragma mark------------------注册协议按钮-----------------
-(void)registeredbackgroundViewProtocolButBut:(UIButton *)but
{
    NSLog(@"注册协议按钮");
}

@end
