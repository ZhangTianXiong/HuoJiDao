//
//  TXView.h
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/13.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TXView :UIView
//获取父类Controller
@property(nonatomic,strong)UIViewController * getController;
-(void)initView;
-(void)setViewFrame;
-(void)setViewData;
-(void)initVar;

/*************************************************
 **                                             **
 ** 注意程序加载的次序。可以准确的说可划分为三个层次    **
 **  1.初始化视图---initView                     **
 **  2.设置视图位置---setViewFrame                **
 **  3.设置视图数据---setViewData                 **
 **************************************************/

/*******************************************************
 **  谨记在创建子控件时一定要设置为全局属性，不然在导致多次创建。*
 **内存过大                                             *
 *******************************************************/

@end
