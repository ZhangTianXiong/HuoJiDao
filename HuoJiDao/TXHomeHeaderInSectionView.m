//
//  TXHomeHeaderInSectionView.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/21.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXHomeHeaderInSectionView.h"
#import "UIImageView+WebCache.h"
@implementation TXHomeHeaderInSectionView
-(void)TXHomeHeaderInSectionViewButton:(UIButton *)but
{
    NSLog(@"更多点击啦");
}
-(void)setModel:(TXHomeModelo *)model{
    _model=model;
    [self setViewData];
}
#pragma mark++++++++++++++重写设置视图数据++++++++++++++

-(void)setViewData
{
    //图标
    [_icon sd_setImageWithURL:[NSURL URLWithString:_model.icon]];
    //设置主题
    _themeLabel.text        = _model.title;
    _themeLabel.textColor   = [UIColor blackColor];
    
}
#pragma mark==============设置视图框架==============
-(void)setViewFrame
{
    CGFloat viewW           = self.frame.size.width;
    CGFloat viewH           = self.frame.size.height;
    //icon
    CGFloat iconX           = 15;
    CGFloat iconW_H         = 20;
    CGFloat iconY           = (viewH-iconW_H)/2;
    _icon.frame             = CM(iconX, iconY, iconW_H, iconW_H);
    
    //主题
    CGFloat themeLabelX     = CGRectGetMaxX(_icon.frame)+10;
    CGFloat themeLabelY     = iconY;
    CGFloat themeLabelW     = 100;
    CGFloat themeLabelH     = 20;
    _themeLabel.frame       = CM(themeLabelX, themeLabelY, themeLabelW, themeLabelH);
    
    //button
    CGFloat  butW           = 40;
    CGFloat  butX           = viewW-butW-10;
    CGFloat  butY           = iconY;
    CGFloat  butH           = 20;
    _but.frame              = CM(butX, butY, butW, butH);
    
}
#pragma mark==============初始化视图==============
-(void)initView
{
    UIImageView * icon       = [[UIImageView alloc]init];
    _icon=icon;
    //主题
    UILabel     * themeLabel = [[UILabel alloc]init];
    themeLabel.font=[UIFont systemFontOfSize:14];
    _themeLabel              = themeLabel;
    //按钮
    UIButton    * but        = [UIButton buttonWithType:UIButtonTypeCustom];
    NSString    * titleName  = @"更多";
    [but setTitle:titleName forState:UIControlStateNormal];
    but.titleLabel.font=[UIFont systemFontOfSize:12];
    
    [but setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [but setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];

    [but addTarget:self action:@selector(TXHomeHeaderInSectionViewButton:) forControlEvents:UIControlEventTouchUpInside];
    
    _but                     = but;
    
    [self addSubview:icon];
    [self addSubview:themeLabel];
    [self addSubview:but];
    
}

#pragma mark==============重写initWithFrame方法==============
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
        /*************************************************
         **                                             **
         ** 注意程序加载的次序。可以准确的说可划分为三个层次    **
         **  1.初始化视图---initView                     **
         **  2.设置视图位置---setViewFrame                **
         **  3.设置视图数据---setViewData                 **
         **************************************************/
        [self initView];
        [self setViewFrame];
        
    }
    return self;
}
-(void)dealloc
{
    
}

@end
