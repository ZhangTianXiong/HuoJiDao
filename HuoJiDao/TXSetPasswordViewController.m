//
//  TXSetPasswordViewController.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/5/19.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXSetPasswordViewController.h"
#import "TXSignInViewController.h"
@interface TXSetPasswordViewController ()

@end

@implementation TXSetPasswordViewController
-(void)setNavigationView
{
    CGFloat  registeredNavigationViewX         = 0;
    CGFloat  registeredNavigationViewY         = 0;
    CGFloat  registeredNavigationViewW         = self.view.frame.size.width;
    CGFloat  registeredNavigationViewH         = 64;
    _registeredNavigationView                  = [[TXRegisteredNavigationView alloc]init];
    _registeredNavigationView.frame            = CM(registeredNavigationViewX, registeredNavigationViewY, registeredNavigationViewW, registeredNavigationViewH);
    _registeredNavigationView.titleLabel.text  = @"设置密码";
    [self.view addSubview:_registeredNavigationView];
}
-(void)initView
{
    CGFloat setPasswordbackgroundViewX        = 0;
    CGFloat setPasswordbackgroundViewY        = 64;
    CGFloat setPasswordbackgroundViewW        = self.view.frame.size.width;
    CGFloat setPasswordbackgroundViewH        = self.view.frame.size.height-setPasswordbackgroundViewY;
    _setPasswordbackgroundView                = [[TXSetPasswordbackgroundView alloc]init];
    _setPasswordbackgroundView.frame          = CM(setPasswordbackgroundViewX, setPasswordbackgroundViewY, setPasswordbackgroundViewW, setPasswordbackgroundViewH);
    
    //昵称
    _setPasswordbackgroundView.nickname.textField.text       = @"西门吹雪";
    //密码
    _setPasswordbackgroundView.password.textField.text       = @"123456";
    //密码验证
    _setPasswordbackgroundView.verifyPassword.textField.text = @"123456";
    
    
    
    //完成按钮
    [_setPasswordbackgroundView.completeBut setTitle:@"完成" forState:UIControlStateNormal];
    [_setPasswordbackgroundView.completeBut addTarget:self action:@selector(setPasswordbackgroundViewCompleteBut:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_setPasswordbackgroundView];
    
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
#pragma mark------------------完成按钮------------------
-(void)setPasswordbackgroundViewCompleteBut:(UIButton *)but
{
    NSLog(@"完成按钮");
    TXSignInViewController * signInViewController=[[TXSignInViewController alloc]init];
    [self presentViewController:signInViewController animated:YES completion:nil];
}
@end
