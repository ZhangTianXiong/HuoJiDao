//
//  TXChaneView.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/22.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXRecommendChaneView.h"

@implementation TXRecommendChaneView
#pragma mark---------------重写setsetFrameModel方法-----------
-(void)setFrameModel:(TXListFrameModel *)frameModel
{
    //加载模型数据
    _frameModel=frameModel;
    [self setViewFrame];
    [self setViewData];
    
    
}
#pragma mark--------------频道点击事件-----------
-(void)chaneViewButton:(UIButton*)but{
    NSLog(@"频道点击啦");
}

#pragma mark---------------设置视图数据-----------
-(void)setViewData
{
    _chaneIcon.image                = [UIImage imageNamed:@"苹果6-UI设计_37"];
    _chaneNameLabel.font            = [UIFont systemFontOfSize:11.2];
    _chaneNameLabel.text            = _frameModel.model.type;
    
}
#pragma mark---------------设置视图框架-----------
-(void)setViewFrame
{
    
    CGFloat viewW                   = self.frame.size.width;
    CGFloat viewH                   = self.frame.size.height;
    CGFloat margin                  = 5;
    
    //chaneIcon
    
    CGFloat chaneIconX              = 0;
    CGFloat chaneIconY              = 0;
    CGFloat chaneIconW_H            = viewH;
    _chaneIcon.layer.masksToBounds  = YES;
    _chaneIcon.layer.cornerRadius   = chaneIconW_H/2;
    _chaneIcon.frame                = CM(chaneIconX, chaneIconY, chaneIconW_H, chaneIconW_H);
    
    //chaneNameLabel
    CGFloat chaneNameLabelX         = CGRectGetMaxX(_chaneIcon.frame)+margin;
    CGFloat chaneNameLabelY         = chaneIconY;
    CGFloat chaneNameLabelW         = viewW-chaneIconW_H-margin;
    CGFloat chaneNameLabelH         = viewH;
    _chaneNameLabel.frame           = CM(chaneNameLabelX, chaneNameLabelY, chaneNameLabelW, chaneNameLabelH);
    
    //chaneBut
    _chaneBut.frame                 = CM(0, 0, viewW, viewH);
}
#pragma mark---------------初始化视图-----------
-(void)initView
{
    self.backgroundColor =[UIColor whiteColor];
    
    //创建频道图标
    UIImageView    * chaneIcon      = [[UIImageView alloc]init];
    _chaneIcon                      = chaneIcon;
    //创建频道主题
    UILabel        * chaneNameLabel = [[UILabel alloc]init];
    _chaneNameLabel                 = chaneNameLabel;
    //创建频道点击事件
    UIButton       * chaneBut       = [UIButton buttonWithType:UIButtonTypeCustom];
    [chaneBut addTarget:self action:@selector(chaneViewButton:) forControlEvents:UIControlEventTouchUpInside];
    _chaneBut                       = chaneBut;
    
    
    [self addSubview:chaneIcon];
    [self addSubview:chaneNameLabel];
    [self addSubview:chaneBut];
}
#pragma mark---------------重写initWithFrame方法-----------
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
        
        
    }
    return self;
}

@end
