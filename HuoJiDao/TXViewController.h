//
//  TXNavigationController.h
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/13.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface TXViewController : UIViewController
             
//返回
@property(nonatomic,strong)UIButton * backBut;
//主题
@property(nonatomic,strong)UILabel  * titleLabel;
//搜索
@property(nonatomic,strong)UIButton * searchBut;
//导航栏View
@property(nonatomic,strong)UIView   * navigationView;
//初始化数据
-(void)initData;
//初始化变量
-(void)initVar;
//初始化视图
-(void)initView;
@end
