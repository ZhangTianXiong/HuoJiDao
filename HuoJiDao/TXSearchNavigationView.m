//
//  TXSearchNavigationView.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/29.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXSearchNavigationView.h"

@implementation TXSearchNavigationView
-(void)setViewFrame
{
    //设置Frame
    CGFloat viewW                = self.frame.size.width;
    CGFloat viewH                = self.frame.size.height+20;
    CGFloat margin               = 10;
    //返回
    
    CGFloat backX                = margin;
    CGFloat backW_H              = 30;
    CGFloat Y                    = (viewH-backW_H)/2;
    _backBut.frame               = CM(backX, Y, backW_H, backW_H);
    
    //载体View
    CGFloat carrierViewX         = CGRectGetMaxX(_backBut.frame)+margin+5;
    CGFloat carrierViewY         = Y;
    CGFloat carrierViewW         = viewW-(margin+backW_H+margin+60+margin);
    CGFloat carrierViewH         = 30;
    _carrierView.frame           = CM(carrierViewX, carrierViewY, carrierViewW, carrierViewH);
    
   
    
    //icon
    CGFloat iconX                = margin/2;
    CGFloat iconW_H              = 20;
    CGFloat iconY                = (carrierViewH-iconW_H)/2;
    _icon.frame                  = CM(iconX, iconY, iconW_H, iconW_H);
    
    //textField
    CGFloat textFieldX           = CGRectGetMaxX(_icon.frame)+margin/2;
    CGFloat textFieldY           = iconY;
    CGFloat textFieldW           = _carrierView.frame.size.width-CGRectGetMaxX(_icon.frame)-margin/2-10;
    CGFloat textFieldH           = iconW_H;
    _textField.frame             = CM(textFieldX, textFieldY, textFieldW, textFieldH);
    //搜索按钮
    CGFloat searchX              = CGRectGetMaxX(_carrierView.frame)+margin;
    CGFloat searchW              = 50;
    CGFloat searchH              = 30;
    _searchBut.frame             = CM(searchX,Y, searchW, searchH);
    
    CGFloat cancelButX           = CGRectGetMaxX(_carrierView.frame)+margin;
    CGFloat cancelButW           = 50;
    CGFloat cancelButH           = 30;
    _cancelBut.frame             = CM(cancelButX,Y, cancelButW, cancelButH);

}

-(void)drawRect:(CGRect)rect
{
    [self setViewFrame];
}
-(instancetype)init
{
    if (self=[super init])
    {
        UIButton    * backBut      = [UIButton buttonWithType:UIButtonTypeCustom];
        backBut.tag=0;
        _backBut                   = backBut;
        UIView      * carrierView  = [[UIView alloc]init];
        carrierView.layer.masksToBounds=YES;
        carrierView.layer.cornerRadius=5;
        carrierView.backgroundColor=[UIColor whiteColor];
        _carrierView               = carrierView;
        
        UIImageView * icon         = [[UIImageView alloc]init];
        _icon                      = icon;
        UITextField * textField    = [[UITextField alloc]init];
        _textField                 = textField;
        UIButton    * searchBut    = [UIButton buttonWithType:UIButtonTypeCustom];
        searchBut.tag=1;
        _searchBut                 = searchBut;
        UIButton    * cancelBut    = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBut.hidden=YES;
        cancelBut.tag=2;
        _cancelBut                 = cancelBut;
        
        
        [self addSubview:backBut];
        [self addSubview:carrierView];
        [self.carrierView addSubview:icon];
        [self.carrierView addSubview:textField];
        [self addSubview:_searchBut];
        [self addSubview:_cancelBut];

    }
    return self;
}

@end
