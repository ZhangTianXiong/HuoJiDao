//
//  TXRegisteredInputBoxView.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/5/18.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXRegisteredInputBoxView.h"

@implementation TXRegisteredInputBoxView
-(instancetype)init
{
    if (self =[super init])
    {
        //是否显示圆角以外的部分
        self.layer.masksToBounds    = YES;
        //边框宽度
        self.layer.borderWidth      = 1;
        //边框颜色
        self.layer.borderColor      = Color(240, 240, 240, 1).CGColor;;
        self.backgroundColor        = [UIColor whiteColor];
        
        UILabel * titleLabel        = [[UILabel alloc]init];
        _titleLabel                 = titleLabel;
        
        UITextField * textField     = [[UITextField alloc]init];
        _textField                  = textField;
        [self addSubview:titleLabel];
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
    
    CGFloat viewW               = self.frame.size.width;
    CGFloat viewH               = self.frame.size.height;
    CGFloat margin              = 10;
    CGFloat titleLabelW         = 60;
    CGFloat titleLabelH         = 20;
    CGFloat titleLabelX         = margin;
    CGFloat titleLabelY         = (viewH-titleLabelH)/2;
    _titleLabel.frame           = CM(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    
    
    CGFloat textFieldX          = CGRectGetMaxX(_titleLabel.frame)+margin;
    CGFloat textFieldH          = 25;
    CGFloat textFieldY          = (viewH-textFieldH)/2;
    CGFloat textFieldW          = (viewW-textFieldX-margin);
    _textField.frame            = CM(textFieldX, textFieldY, textFieldW, textFieldH);
    
}
-(void)setViewData
{
    //注意UILabel 实力化后一定要设置这几项
    _titleLabel.font                = [UIFont systemFontOfSize:15];
    _titleLabel.textColor           = [UIColor blackColor];
    _titleLabel.textAlignment       = NSTextAlignmentCenter;
    
    
}
@end
