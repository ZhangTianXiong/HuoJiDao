//
//  TXSearchViewController.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/29.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXSearchViewController.h"

@interface TXSearchViewController ()

@end

@implementation TXSearchViewController
#pragma mark--------------返回按钮点击事件--------------
-(void)back:(UIButton*)but
{
    [self dismissViewControllerAnimated:NO completion:nil];
}
-(void)cancel:(UIButton*)but
{
    but.hidden=YES;
    _searchNavigationView.searchBut.hidden=NO;
    NSLog(@"取消");
    
}
-(void)search:(UIButton*)but
{
    but.hidden=YES;
    _searchNavigationView.cancelBut.hidden=NO;
    
    NSLog(@"搜索");
    
    
}
-(void)setNavigationViewData
{
    //设置返回按钮
    [_searchNavigationView.backBut setImage:[UIImage imageNamed:@"Back"] forState:UIControlStateNormal];
    [_searchNavigationView.backBut addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    //设置icon
    _searchNavigationView.icon.image=[UIImage imageNamed:@"012_03"];
    //设置textfield水印
    _searchNavigationView.textField.placeholder=@"请输入关键词或编号";
    //设置搜索按钮
    [_searchNavigationView.searchBut setTitle:@"搜索" forState:UIControlStateNormal];
    [_searchNavigationView.searchBut addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
    [_searchNavigationView.searchBut setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    //设置取消按钮
    [_searchNavigationView.cancelBut setTitle:@"取消" forState:UIControlStateNormal];
    [_searchNavigationView.cancelBut addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [_searchNavigationView.cancelBut setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    
}
//重写导航栏
-(void)setNavigationView
{
    _searchNavigationView=[[TXSearchNavigationView alloc ]init];
    _searchNavigationView.frame=NavigationView_Frame;
    _searchNavigationView.backgroundColor=Navigation_Color;
    [self.view addSubview:_searchNavigationView];
    [self setNavigationViewData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
