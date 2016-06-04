//
//  TXView.m
//  创建View虚线
//
//  Created by IOS开发 on 16/4/26.
//  Copyright © 2016年 IOS开发. All rights reserved.
//
#import "TXTheDottedLineView.h"
@implementation TXTheDottedLineView

-(void)theDottedLineViewBut:(UIButton * )but
{
    if ([_delegate respondsToSelector:@selector(theDottedLineView:Button:)])
    {
        [_delegate theDottedLineView:self Button:_but];
    }
}
-(void)setViewFrame
{
    
    
    //初始化Layer的大小
    _borderLayer.bounds     = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    //初始化Layer的X,Y坐标
    _borderLayer.position   = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    
    //矩形虚线
    _borderLayer.path       = [UIBezierPath bezierPathWithRect:_borderLayer.bounds].CGPath;
    
    //    //圆形虚线
    //        borderLayer.path = [UIBezierPath bezierPathWithRoundedRect:borderLayer.bounds cornerRadius:CGRectGetWidth(borderLayer.bounds)/2].CGPath;
    
    //边框的宽度
    _borderLayer.lineWidth = 0.5;
    
    //虚线边框
    _borderLayer.lineDashPattern = @[@0.5, @1];//分别是宽度 ， 和密度
    //实线边框
    //    borderLayer.lineDashPattern = nil;
    //内部颜色
    _borderLayer.fillColor      = Color(0.5, 0.5, 0.5, 0).CGColor;
    //外部颜色
    _borderLayer.strokeColor    = [UIColor grayColor].CGColor;
    //将该Layer层添加在自身上
    
    
    
    CGFloat margin              = 5;
    CGFloat viewW               = self.frame.size.width;
    CGFloat viewH               = self.frame.size.height;
    //图标
    CGFloat  iconX              = margin;
    CGFloat  iconW_H            = 20;
    CGFloat  Y                  = (viewH-iconW_H)/2;
    _icon.frame                 = CGRectMake(iconX, Y, iconW_H, iconW_H);
    
    //数量
    CGFloat labelX              = CGRectGetMaxX(_icon.frame);
    CGFloat labelW              = viewW-iconW_H-margin;
    CGFloat labelH              = iconW_H;
    _label.frame                = CGRectMake(labelX, Y, labelW, labelH);
    //BUtton
    _but.frame                  = CGRectMake(0, 0, viewW, viewH);
    
    
}
-(void)initView
{
    UIImageView           * icon = [[UIImageView alloc]init];//创建图标
    _icon=icon;
    UILabel               * label= [[UILabel alloc]init];//创建数量
    label.textAlignment          = NSTextAlignmentCenter;
    label.font                   = [UIFont systemFontOfSize:11];
    _label                       = label;
    UIButton              * but  = [UIButton buttonWithType:UIButtonTypeCustom];//创建点击事件
    
    
    
    [but addTarget:self action:@selector(theDottedLineViewBut:) forControlEvents:UIControlEventTouchUpInside];
    [but setImage:[UIImage imageNamed:@"button全透明"] forState:UIControlStateNormal];
    [but setImage:[UIImage imageNamed:@"button半透明"] forState:UIControlStateHighlighted];
    _but                         = but;
    
    /*******************************************************
     **  谨记在创建子控件时一定要设置为全局属性，不然在导致多次创建。*
     **内存过大                                             *
     *******************************************************/
     //添加自定义Layer层
    //解决重复被创建内存过大
    CAShapeLayer * borderLayer  = [CAShapeLayer layer];
   
    _borderLayer                = borderLayer;
    [self addSubview:icon];
    [self addSubview:label];
    [self addSubview:but];
    [self.layer addSublayer:borderLayer];
}
-(void)drawRect:(CGRect)rect
{
    
    /******************************************
     *  注意：必须记住                          *
     *  init 初始化控件                        *
     *  drawRect:(CGRect)rect设置控件的位置    *
     *****************************************/
  
    [self setViewFrame];

    
}
#pragma mark------------重写init方法-----------
-(instancetype)init
{
    if (self =[super init])
    {
        _state                  = NO;//状态
        [self initView];
        self.backgroundColor    = [UIColor whiteColor];
    }
    return self;
}

@end
