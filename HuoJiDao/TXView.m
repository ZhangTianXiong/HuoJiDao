//
//  TXView.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/13.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXView.h"

@implementation TXView
#pragma mark------------获取父类Controller-------------
-(UIViewController*)getController
{
    id controller  = [self nextResponder];
    while (![controller isKindOfClass:[UIViewController class]]&&controller!=nil)
    {
        controller = [controller nextResponder];
    }
    UIViewController  * mainController=(UIViewController*)controller;
    return mainController;
}

/*************************************************
 **                                             **
 ** 注意程序加载的次序。可以准确的说可划分为三个层次    **
 **  1.初始化视图---initView                     **
 **  2.设置视图位置---setViewFrame                **
 **  3.设置视图数据---setViewData                 **
 **************************************************/
#pragma mark++++++++++++++设置视图数据++++++++++++++
-(void)setViewData
{
    
}
#pragma mark==============设置视图Frame==============
-(void)setViewFrame
{
    
}

#pragma mark==============初始化视图==============
-(void)initView
{
    
}
-(void)drawRect:(CGRect)rect
{
    /******************************************
     *  注意：必须记住                          *
     *  init 初始化控件                        *
     *  drawRect:(CGRect)rect设置控件的位置    *
     *                                       *
     *                                      *
     *                                      *
     *                                      *
     *****************************************/
    
}


@end
