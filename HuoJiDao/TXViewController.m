//
//  TXNavigationController.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/13.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXViewController.h"
#import "TXSearchViewController.h"
#import "TXRequestData.h"

@interface TXViewController ()
@end

@implementation TXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self initVar];
    [self setNavigationView];
    [self initView];

}
#pragma mark++++++++++初始化数据++++++++++
-(void)initData
{
    
    
}
#pragma mark++++++++++初始化变量++++++++++
-(void)initVar
{
    
}
#pragma mark===============初始化视图===============
-(void)initView{
    
    
}
#pragma mark-------------Button点击事件-------------
-(void)navigationButton:(UIButton *)sender
{
    switch (sender.tag)
    {
        case backButton:{
            [self dismissViewControllerAnimated:YES completion:nil];
        }
            break;
        case searchButton:
        {
            TXSearchViewController * searchViewController=[[TXSearchViewController alloc]init];
            [self presentViewController:searchViewController animated:YES completion:nil];
        }
        default:
            break;
    }
}
#pragma mark-------------设置导航栏-------------
-(void)setNavigationView
{
    //创建导航View
    _navigationView                 = [[UIView alloc]init];
    _titleLabel                     = [[UILabel alloc]init];
    _backBut                        = [UIButton buttonWithType:UIButtonTypeCustom];
    _searchBut                      = [UIButton buttonWithType:UIButtonTypeCustom];
    //设置属性
    //navigationView
    _navigationView.backgroundColor = Navigation_Color;
    //标题
    _titleLabel.font                = [UIFont systemFontOfSize:19];
    _titleLabel.textColor           = TitleLab_Color;
    _titleLabel.textAlignment       = NSTextAlignmentCenter;
    //返回按钮
    _backBut.tag=0;
    UIImage *backImageI             = [UIImage imageNamed:@"Back"];
    [_backBut setImage:backImageI forState:UIControlStateNormal];
    [_backBut addTarget:self action:@selector(navigationButton:) forControlEvents:UIControlEventTouchUpInside];
   //搜索按钮
    _searchBut.tag=1;
    UIImage *searchButImageI        = [UIImage imageNamed:@"搜索"];
    [_searchBut setImage:searchButImageI forState:UIControlStateNormal];
    [_searchBut addTarget:self action:@selector(navigationButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_navigationView];
    [self.view addSubview:_titleLabel];
    [self.view addSubview:_backBut];
    [self.view addSubview:_searchBut];
    [self setNavigationViewFrame];
}
#pragma mark=================设置导航栏位置=================
-(void)setNavigationViewFrame
{
    _navigationView.frame        = NavigationView_Frame;
    //设置Frame
    CGFloat viewW                = _navigationView.frame.size.width;
    CGFloat viewH                = _navigationView.frame.size.height+20;
    
    //返回
    CGFloat backX                = 10;
    CGFloat backW_H              = 25;
    CGFloat backY                = (viewH-backW_H)/2;
    _backBut.frame               = CM(backX, backY, backW_H, backW_H);
    
    CGFloat titleLabW            = 100;
    CGFloat titleLabX            = _navigationView.frame.size.width/2-titleLabW/2;
    CGFloat titleLabY            = backY;
    CGFloat titleLabH            = 30;
    _titleLabel.frame            = CM(titleLabX, titleLabY, titleLabW, titleLabH);
    //搜索按钮
    _searchBut.frame             = CM(viewW-35, backY, backW_H, backW_H);
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}

#pragma mark-------------是否支持屏幕旋转-------------

- (BOOL)shouldAutorotate

{
    return NO;
    
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
    
}

#pragma mark-------------只支持这一个方向(正常的方向)-------------
-(UIInterfaceOrientationMask)supportedInterfaceOrientations

{
    return UIInterfaceOrientationMaskPortrait;//只支持这一个方向(正常的方向)
    
}

@end
