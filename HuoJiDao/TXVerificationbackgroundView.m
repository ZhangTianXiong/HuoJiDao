//
//  TXVerificationbackgroundView.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/5/18.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXVerificationbackgroundView.h"

@implementation TXVerificationbackgroundView

-(instancetype)init
{
    if (self =[super init])
    {
        self.backgroundColor                = [UIColor whiteColor];
        UIImageView    * backgroundImage    = [[UIImageView alloc]init];
        _backgroundImage                    = backgroundImage;
        
        UILabel        * promptLabel        = [[UILabel alloc]init];
        _promptLabel                        = promptLabel;
        UILabel        * phoneNumberLabel   = [[UILabel alloc]init];
        _phoneNumberLabel                   = phoneNumberLabel;
        UITextField    * textField          = [[UITextField alloc]init];
        //光标的位置
        UIView *paddingView                 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 30)];
        textField.leftView                  = paddingView;
        textField.leftViewMode              = UITextFieldViewModeAlways;
        _textField=textField;
        
        UILabel        * countdownLabel     = [[UILabel alloc]init];
        _countdownLabel                     = countdownLabel;
        
        UIButton       * nextBut            = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextBut                            = nextBut;
        
        [self addSubview:backgroundImage];
        [self addSubview:promptLabel];
        [self addSubview:phoneNumberLabel];
        [self addSubview:textField];
        [self addSubview:countdownLabel];
        [self addSubview:nextBut];
        
        
        

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
    _backgroundImage.frame      = CM(0, 0, viewW, viewH);
    
    
    CGFloat margin              = 20;
    
    CGFloat promptLabelX        = 40;
    CGFloat promptLabelY        = 30;
    CGFloat promptLabelW        = viewW-promptLabelX*2;
    CGFloat promptLabelH        = 20;
    _promptLabel.frame          = CM(promptLabelX, promptLabelY, promptLabelW, promptLabelH);
    
    CGFloat phoneNumberLabelW   = 200;
    CGFloat phoneNumberLabelX   = (viewW-phoneNumberLabelW)/2;
    CGFloat phoneNumberLabelY   = CGRectGetMaxY(_promptLabel.frame)+margin;
    CGFloat phoneNumberLabelH   = 30;
    _phoneNumberLabel.frame     = CM(phoneNumberLabelX, phoneNumberLabelY, phoneNumberLabelW, phoneNumberLabelH);
    
    CGFloat textFieldW          = 120;
    CGFloat textFieldX          = viewW-textFieldW*2-8;
    CGFloat textFieldY          = CGRectGetMaxY(_phoneNumberLabel.frame)+margin;
    CGFloat textFieldH          = 40;
    _textField.frame            = CM(textFieldX, textFieldY, textFieldW, textFieldH);
    
    CGFloat countdownLabelW     = 120;
    CGFloat countdownLabelX     = (viewW-countdownLabelW)/2;
    CGFloat countdownLabelY     = CGRectGetMaxY(_textField.frame)+margin;
    CGFloat countdownLabelH     = 30;
    _countdownLabel.frame       = CM(countdownLabelX, countdownLabelY, countdownLabelW, countdownLabelH);
    
    CGFloat nextButX            = 40;
    CGFloat nextButW            = viewW-nextButX*2;
    CGFloat nextButY            = CGRectGetMaxY(_countdownLabel.frame)+margin;
    CGFloat nextButH            = 40;
    _nextBut.frame              = CM(nextButX, nextButY, nextButW, nextButH);
    
    
}
-(void)setViewData
{
    //注意UILabel 实力化后一定要设置这几项
    _promptLabel.font                     = [UIFont systemFontOfSize:13];
    _promptLabel.textColor                = [UIColor blackColor];
    _promptLabel.textAlignment            = NSTextAlignmentCenter;
    _promptLabel.text=@"验证码已发送到一下手机,请在5分钟内完成注册";
    
    //注意UILabel 实力化后一定要设置这几项
    _phoneNumberLabel.font                = [UIFont systemFontOfSize:17];
    _phoneNumberLabel.textColor           = [UIColor blackColor];
    _phoneNumberLabel.textAlignment       = NSTextAlignmentCenter;
    _phoneNumberLabel.text                = [NSString stringWithFormat:@"+86 %@",@"18867501081"];
    
    
    //是否显示圆角以外的部分
    _textField.layer.masksToBounds        = YES;
    //边框宽度
    _textField.layer.borderWidth          = 1;
    //边框颜色
    _textField.layer.borderColor          = Color(240, 240, 240, 1).CGColor;;
    _textField.backgroundColor            = [UIColor whiteColor];
    _textField.layer.cornerRadius         = 5;
    //注意UILabel 实力化后一定要设置这几项
    _countdownLabel.font                  = [UIFont systemFontOfSize:15];
    _countdownLabel.textColor             = [UIColor grayColor];
    _countdownLabel.textAlignment         = NSTextAlignmentCenter;
    _countdownLabel.text                  = [NSString stringWithFormat:@"%@秒后可以重发",@"60"];
    _nextBut.backgroundColor              = Navigation_Color;
    _nextBut.layer.cornerRadius           = 4;
}
@end
