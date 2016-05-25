//
//  TXRegisteredbackgroundView.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/5/18.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXRegisteredbackgroundView.h"

@implementation TXRegisteredbackgroundView

-(instancetype)init
{
    if (self = [super init])
    {
        self.backgroundColor                    = [UIColor whiteColor];
        UIImageView    * backgroundImage        = [[UIImageView alloc]init];
        _backgroundImage                        = backgroundImage;
        
        TXRegisteredInputBoxView * country      = [[TXRegisteredInputBoxView alloc]init];
        _country                                = country;
        
        TXRegisteredInputBoxView * phoneNumber  = [[TXRegisteredInputBoxView alloc]init];
        _phoneNumber                            = phoneNumber;
        
        UIButton * obtainBut                    = [UIButton buttonWithType:UIButtonTypeCustom];
        _obtainBut                              = obtainBut;
        UILabel  * promptLabel                  = [[UILabel alloc]init];
        _promptLabel                            = promptLabel;
        UIButton * protocolBut                  = [UIButton buttonWithType:UIButtonTypeCustom];
        _protocolBut                            = protocolBut;
        
        
        [self addSubview:backgroundImage];
        [self addSubview:country];
        [self addSubview:phoneNumber];
        [self addSubview:obtainBut];
        [self addSubview:promptLabel];
        [self addSubview:protocolBut];
        
        
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
    
    CGFloat countryX            = 0;
    CGFloat countryY            = 60;
    CGFloat countryW            = viewW;
    CGFloat countryH            = 50;
    _country.frame              = CM(countryX, countryY, countryW, countryH);
    
    
    CGFloat phoneNumberX        = countryX;
    CGFloat phoneNumberY        = CGRectGetMaxY(_country.frame)+margin;
    CGFloat phoneNumberW        = countryW;
    CGFloat phoneNumberH        = countryH;
    _phoneNumber.frame          = CM(phoneNumberX, phoneNumberY, phoneNumberW, phoneNumberH);
    
    CGFloat obtainButX          = 40;
    CGFloat obtainButY          = CGRectGetMaxY(_phoneNumber.frame)+margin;
    CGFloat obtainButW          = viewW-obtainButX*2;
    CGFloat obtainButH          = 45;
    _obtainBut.frame            = CM(obtainButX, obtainButY, obtainButW, obtainButH);
    
    
    CGFloat promptLabelX        = 35;
    CGFloat promptLabelY        = CGRectGetMaxY(_obtainBut.frame)+margin;
    CGFloat promptLabelW        = 240;
    CGFloat promptLabelH        = 20;
    _promptLabel.frame          = CM(promptLabelX, promptLabelY, promptLabelW, promptLabelH);
   
    CGFloat protocolButX        = CGRectGetMaxX(_promptLabel.frame);
    CGFloat protocolButY        = promptLabelY;
    CGFloat protocolButW        = 60;
    CGFloat protocolButH        = 20;
    _protocolBut.frame          = CM(protocolButX, protocolButY, protocolButW, protocolButH);
  
    
}

-(void)setViewData
{
   
    _country.titleLabel.text            = @"中国";
    _country.textField.hidden           = YES;
    _phoneNumber.titleLabel.text        = @"+86";
    _obtainBut.backgroundColor          = Navigation_Color;
    _obtainBut.layer.cornerRadius       = 4;
    
    _promptLabel.font                   = [UIFont systemFontOfSize:15];
    _promptLabel.textColor              = [UIColor grayColor];
    _promptLabel.textAlignment          = NSTextAlignmentCenter;
    _promptLabel.text                   = @"点击“获取验证码”按钮，即表示同意";
    _protocolBut.titleLabel.font        = [UIFont systemFontOfSize:15];
    [_protocolBut setTitleColor:Navigation_Color forState:UIControlStateNormal];
    [_protocolBut setTitle:@"注册协议" forState:UIControlStateNormal];
  
    
}
@end
