//
//  TXVerificationViewController.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/5/18.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXVerificationViewController.h"
#import "TXSetPasswordViewController.h"
@interface TXVerificationViewController ()

@end

@implementation TXVerificationViewController
-(void)setNavigationView
{
    CGFloat  registeredNavigationViewX           = 0;
    CGFloat  registeredNavigationViewY           = 0;
    CGFloat  registeredNavigationViewW           = self.view.frame.size.width;
    CGFloat  registeredNavigationViewH           = 64;
    _registeredNavigationView                    = [[TXRegisteredNavigationView alloc]init];
    _registeredNavigationView.frame              = CM(registeredNavigationViewX, registeredNavigationViewY, registeredNavigationViewW, registeredNavigationViewH);
    _registeredNavigationView.titleLabel.text    = @"验证手机号";
    [self.view addSubview:_registeredNavigationView];
}
-(void)initView
{
    CGFloat verificationbackgroundViewX          = 0;
    CGFloat verificationbackgroundViewY          = 64;
    CGFloat verificationbackgroundViewW          = self.view.frame.size.width;
    CGFloat verificationbackgroundViewH          = self.view.frame.size.height-verificationbackgroundViewY;
    _verificationbackgroundView                  = [[TXVerificationbackgroundView alloc]init];
    _verificationbackgroundView.frame=CM(verificationbackgroundViewX, verificationbackgroundViewY, verificationbackgroundViewW, verificationbackgroundViewH);
    
    //验证码输入框
    _verificationbackgroundView.textField.text   = @"146875";
    
    [_verificationbackgroundView.nextBut setTitle:@"下一步" forState:UIControlStateNormal];
    [_verificationbackgroundView.nextBut addTarget:self action:@selector(verificationbackgroundViewNextBut:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_verificationbackgroundView];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-----------------下一步按钮-----------------
-(void)verificationbackgroundViewNextBut:(UIButton *)but
{
    NSLog(@"下一步按钮");
    TXSetPasswordViewController * setPasswordViewController=[[TXSetPasswordViewController alloc]init];
    [self presentViewController:setPasswordViewController animated:NO completion:nil];
    
}

@end
