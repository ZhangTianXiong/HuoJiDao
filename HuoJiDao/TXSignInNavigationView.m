//
//  TXSignInNavigationView.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/5/17.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXSignInNavigationView.h"

@implementation TXSignInNavigationView
-(instancetype)init
{
    if (self =[super init])
    {
        self.backgroundColor   = Navigation_Color;
        UIButton * backBut     = [UIButton buttonWithType:UIButtonTypeCustom];
        _backBut=backBut;
        //标题
        UILabel  * titleLabel  = [[UILabel alloc]init];
        _titleLabel            = titleLabel;
        UIButton * rightBut    = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBut              = rightBut;
        [self addSubview:backBut];
        [self addSubview:titleLabel];
        [self addSubview:rightBut];
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
    CGFloat viewW                = self.frame.size.width;
    CGFloat viewH                = self.frame.size.height+20;
    //返回
    CGFloat backX                = 10;
    CGFloat backW_H              = 30;
    CGFloat backY                = (viewH-backW_H)/2;
    _backBut.frame               = CM(backX, backY, backW_H, backW_H);
    CGFloat titleLabW            = 100;
    CGFloat titleLabX            = (viewW-titleLabW)/2;
    CGFloat titleLabY            = backY;
    CGFloat titleLabH            = 30;
    _titleLabel.frame            = CM(titleLabX, titleLabY, titleLabW, titleLabH);
    
    CGFloat rightButX            = viewW-95;
    CGFloat rightButH            = 20;
    CGFloat rightButY            = (viewH-rightButH)/2;
    CGFloat rightButW            = 100;
    _rightBut.frame              = CM(rightButX,rightButY ,rightButW ,rightButH);
}

-(void)setViewData
{
    [_backBut setImage:[UIImage imageNamed:@"Back"] forState:UIControlStateNormal];
   
    
    _titleLabel.font                = [UIFont systemFontOfSize:18];
    
    _titleLabel.textColor           = TitleLab_Color;
    _titleLabel.textAlignment       = NSTextAlignmentCenter;
    _rightBut.titleLabel.font=[UIFont systemFontOfSize:17];
     
}
@end
