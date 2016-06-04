//
//  TXRegisteredNavigationView.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/5/18.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXRegisteredNavigationView.h"

@implementation TXRegisteredNavigationView

-(instancetype)init
{
    if (self =[super init])
    {
    
        self.backgroundColor        = Navigation_Color;
        UIButton * backBut          = [UIButton buttonWithType:UIButtonTypeCustom];
        _backBut=backBut;
        UILabel  * titleLabel       = [[UILabel alloc]init];
        _titleLabel                 = titleLabel;
        
        [self addSubview:backBut];
        [self addSubview:titleLabel];
        
    }
    
    return self;
}

-(void)drawRect:(CGRect)rect
{
    [self setViewFrame];
    [self setViewData];
}
-(void)setViewFrame
{
    //设置Frame
    CGFloat viewW                   = self.frame.size.width;
    CGFloat viewH                   = self.frame.size.height+20;
    //返回
    CGFloat backX                   = 10;
    CGFloat backW_H                 = 25;
    CGFloat backY                   = (viewH-backW_H)/2;
    _backBut.frame                  = CM(backX, backY, backW_H, backW_H);
    CGFloat titleLabW               = 100;
    CGFloat titleLabX               = (viewW-titleLabW)/2;
    CGFloat titleLabY               = backY;
    CGFloat titleLabH               = backW_H;
    _titleLabel.frame               = CM(titleLabX, titleLabY, titleLabW, titleLabH);

}
-(void)setViewData
{
    [_backBut setImage:[UIImage imageNamed:@"Back"] forState:UIControlStateNormal];
    [_backBut addTarget:self action:@selector(backBut:) forControlEvents:UIControlEventTouchUpInside];
    _titleLabel.font                = [UIFont systemFontOfSize:19];
    _titleLabel.textColor           = TitleLab_Color;
    _titleLabel.textAlignment       = NSTextAlignmentCenter;
   
}
-(void)backBut:(UIButton *)but
{
    [self.getController dismissViewControllerAnimated:YES completion:nil];
    
}

@end
