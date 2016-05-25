//
//  TXThirdPartyIoginView.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/5/18.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXThirdPartyIoginView.h"
@interface TXThirdPartyIoginView()
{
    UIView  * _view1, *_view2;
    UILabel * _label;
}

    

@end
@implementation TXThirdPartyIoginView
-(instancetype)init
{
    if (self =[super init])
    {
        
        self.backgroundColor        = [UIColor whiteColor];
        
        _view1                      = [[UIView alloc]init];
        _view1.backgroundColor      = [UIColor grayColor];
        UILabel * label             = [[UILabel alloc]init];
        _label                      = label;
        _view2                      = [[UIView alloc]init];
        _view2.backgroundColor      = [UIColor grayColor];
        
        UIButton * weiboBut         = [UIButton buttonWithType:UIButtonTypeCustom];
        [weiboBut setImage:[UIImage imageNamed:@"新浪"] forState:UIControlStateNormal];
        _weiboBut                   = weiboBut;
        UIButton * qqBut=[UIButton buttonWithType:UIButtonTypeCustom];
        [qqBut setImage:[UIImage imageNamed:@"QQ"] forState:UIControlStateNormal];
        _qqBut=qqBut;
        UIButton * weixinBut        = [UIButton buttonWithType:UIButtonTypeCustom];
        [weixinBut setImage:[UIImage imageNamed:@"微信"] forState:UIControlStateNormal];
        _weixinBut                  = weixinBut;
        [self addSubview:_view1];
        [self addSubview:_label];
        [self addSubview:_view2];
        [self addSubview:weiboBut];
        [self addSubview:qqBut];
        [self addSubview:weixinBut];
        
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
    
    CGFloat viewW               = self.frame.size.width;
 
    CGFloat view1X              = 20;
    CGFloat view1Y              = 20;
    CGFloat view1W              = viewW/2-70;
    CGFloat view1H              = 1;
    _view1.frame                = CM(view1X, view1Y, view1W, view1H);
    
    
    CGFloat labelW              = 100;
    CGFloat labelX              = (viewW-labelW)/2;
    CGFloat labelY              = view1Y/2-5;
    CGFloat labelH              = 30;
    _label.frame                = CM(labelX, labelY, labelW, labelH);
    
    CGFloat view2X              = CGRectGetMaxX(_label.frame);
    CGFloat view2Y              = view1Y;
    CGFloat view2W              = view1W;
    CGFloat view2H              = 1;
    _view2.frame                = CM(view2X, view2Y, view2W, view2H);
    
    
    
    CGFloat margin              = 40;
    CGFloat butW_H              = 60;
    
    CGFloat weiboX              = viewW/3-butW_H/2-margin;
    CGFloat weiboY              = 80;
    _weiboBut.frame             = CM(weiboX, weiboY, butW_H, butW_H);
   
    CGFloat qqX                 = CGRectGetMaxX(_weiboBut.frame)+margin;
    CGFloat qqY                 = weiboY;
    _qqBut.frame                = CM(qqX, qqY, butW_H, butW_H);
   
    CGFloat weixinX             = CGRectGetMaxX(_qqBut.frame)+margin;
    CGFloat weixinY             = qqY;
    _weixinBut.frame            = CM(weixinX, weixinY, butW_H, butW_H);
   
    
    
    
    
    
}
-(void)setViewData
{
    _label.font                = [UIFont systemFontOfSize:15];
    _label.textColor           = [UIColor grayColor];
    _label.textAlignment       = NSTextAlignmentCenter;
    _label.text                = @"第三方登录";

}
@end
