//
//  TXInputBoxView.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/5/17.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXInputBoxView.h"


@implementation TXInputBoxView
-(instancetype)init
{
    if ( self =[super init])
    {
        
        //是否显示圆角以外的部分
        self.layer.masksToBounds        = YES;
        //边框宽度
        self.layer.borderWidth          = 1;
        //边框颜色
        self.layer.borderColor          = Color(240, 240, 240, 1).CGColor;;
        self.backgroundColor            = [UIColor whiteColor];
        UIImageView * icon              = [[UIImageView alloc]init];
        _icon=icon;
        UITextField * textField         = [[UITextField alloc]init];
        _textField=textField;
        [self addSubview:icon];
        [self addSubview:textField];
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
    CGFloat viewW                       = self.frame.size.width;
    CGFloat viewH                       = self.frame.size.height;
    CGFloat margin                      = 20;
    CGFloat iconW                       = 25;
    CGFloat iconH                       = 30;
    CGFloat iconX                       = margin;
    CGFloat iconY                       = (viewH-iconH)/2;
    _icon.frame                         = CM(iconX, iconY, iconW, iconH);
    
    
    
    CGFloat textFieldX                  = CGRectGetMaxX(_icon.frame)+margin;
    CGFloat textFieldH                  = 25;
    CGFloat textFieldY                  = (viewH-textFieldH)/2;
    CGFloat textFieldW                  = (viewW-textFieldX-margin);
    _textField.frame                    = CM(textFieldX, textFieldY, textFieldW, textFieldH);
  
    
}
-(void)setViewData
{
    
}
@end
