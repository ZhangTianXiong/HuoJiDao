//
//  TXVideoExhibitionNavigationView.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/5/6.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXExhibitionNavigationView.h"
@interface TXExhibitionNavigationView()
{
    UIImageView * icon;
    UILabel     * label;
}
@end
@implementation TXExhibitionNavigationView

-(void)layoutSubviews
{
    [self setViewFrame];
}
-(void)setViewFrame
{
    CGFloat viewW       = self.frame.size.width;
    CGFloat viewH       = self.frame.size.height+20;
    
    //返回按钮
    CGFloat margins     = 10;
    CGFloat backButW_H  = 25;
    CGFloat backButX    = margins;
    CGFloat backButY    = (viewH-backButW_H)/2;
    _backBut.frame      = CM(backButX, backButY, backButW_H, backButW_H);
    
    //but按钮
    CGFloat butW        = 100;
    CGFloat butH        = backButW_H;
    CGFloat butX        = (viewW-butW)/2;
    CGFloat butY        = backButY;
    _but.frame          = CM(butX, butY, butW, butH);
    
    CGFloat iconX       = 0;
    CGFloat iconW_H     = 15;
    CGFloat iconY       = (butH-iconW_H)/2;
    icon.frame          = CM(iconX, iconY, iconW_H, iconW_H);
    
    CGFloat labelX      = CGRectGetMaxX(icon.frame)+margins/2;
    CGFloat labelY      = iconY;
    CGFloat labelW      = butW-iconW_H-margins/2;
    CGFloat labelH      = iconW_H;
    label.frame         = CM(labelX, labelY, labelW, labelH);
    
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
        
        UIButton * backBut      = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBut setImage:[UIImage imageNamed:@"back-2"] forState:UIControlStateNormal];
        _backBut                = backBut;
        
        UIButton * but          = [UIButton buttonWithType:UIButtonTypeCustom];
        icon                    = [[UIImageView alloc]init];
        icon.image              = [UIImage imageNamed:@"small_播放_icon"];
        label                   = [[UILabel alloc]init];
        label.textColor         = [UIColor whiteColor];
        label.text              = @"点击播放";
        _but                    = but;
        
        [self addSubview:backBut];
        [self addSubview:but];
        
        [but addSubview:icon];
        [but addSubview:label];
        
        
        
        
    }
    return self;
}


@end
