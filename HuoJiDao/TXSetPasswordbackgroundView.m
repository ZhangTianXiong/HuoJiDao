//
//  TXSetPasswordbackgroundView.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/5/19.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXSetPasswordbackgroundView.h"

@implementation TXSetPasswordbackgroundView
-(instancetype)init
{
    if (self =[super init])
    {
        self.backgroundColor                      = [UIColor whiteColor];
        UIImageView    * backgroundImage          = [[UIImageView alloc]init];
        _backgroundImage                          = backgroundImage;
        
        UILabel        * promptLabel              = [[UILabel alloc]init];
        _promptLabel                              = promptLabel;
        
        TXRegisteredInputBoxView * nickname       = [[TXRegisteredInputBoxView alloc]init];
        _nickname                                 = nickname;
        
        
        TXRegisteredInputBoxView * password       = [[TXRegisteredInputBoxView alloc]init];
         password.textField.secureTextEntry       = YES;//密文形式
        _password=password;
        
        TXRegisteredInputBoxView * verifyPassword = [[TXRegisteredInputBoxView alloc]init];
        verifyPassword.textField.secureTextEntry  = YES;//密文形式
        _verifyPassword=verifyPassword;
        
        
        UIButton * completeBut                    = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _completeBut                              = completeBut;
        
        [self addSubview:backgroundImage];
        [self addSubview:promptLabel];
        [self addSubview:nickname];
        [self addSubview:password];
        [self addSubview:verifyPassword];
        [self addSubview:completeBut];
        
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
    
    CGFloat margin              = 30;
    
    CGFloat promptLabelX        = margin;
    CGFloat promptLabelY        = 40;
    CGFloat promptLabelW        = 260;
    CGFloat promptLabelH        = 20;
    _promptLabel.frame          = CM(promptLabelX, promptLabelY, promptLabelW, promptLabelH);
    
    CGFloat nicknameX           = 0;
    CGFloat nicknameY           = CGRectGetMaxY(_promptLabel.frame)+margin;
    CGFloat nicknameW           = viewW;
    CGFloat nicknameH           = 40;
    _nickname.frame             = CM(nicknameX, nicknameY, nicknameW, nicknameH);
    
    
    
    CGFloat passwordX           = nicknameX;
    CGFloat passwordY           = CGRectGetMaxY(_nickname.frame)+margin;
    CGFloat passwordW           = nicknameW;
    CGFloat passwordH           = nicknameH;
    _password.frame             = CM(passwordX, passwordY, passwordW, passwordH);
    
    
    CGFloat verifyPasswordX     = passwordX;
    CGFloat verifyPasswordY     = CGRectGetMaxY(_password.frame)-1;
    CGFloat verifyPasswordW     = passwordW;
    CGFloat verifyPasswordH     = passwordH;
    _verifyPassword.frame       = CM(verifyPasswordX, verifyPasswordY, verifyPasswordW, verifyPasswordH);
    
    CGFloat completeButX        = 40;
    CGFloat completeButY        = CGRectGetMaxY(_verifyPassword.frame)+margin;
    CGFloat completeButW        = viewW-completeButX*2;
    CGFloat completeButH        = 40;
    _completeBut.frame          = CM(completeButX, completeButY, completeButW, completeButH);
    
}
-(void)setViewData
{
    //注意UILabel 实力化后一定要设置这几项
    _promptLabel.font                = [UIFont systemFontOfSize:13];
    _promptLabel.textColor           = [UIColor blackColor];
    _promptLabel.textAlignment       = NSTextAlignmentCenter;
    _promptLabel.text=@"设置密码后,你就可以使用手机登录火鸡岛啦!";
    
    
    _nickname.titleLabel.text             = @"昵称";
    _nickname.textField.placeholder       = @"3-16个字符以内，区分大小写";
    _password.titleLabel.text             = @"密码";
    _password.textField.placeholder       = @"6-30个字符以内";
    _verifyPassword.titleLabel.text       = @"密码验证";
    _verifyPassword.textField.placeholder = @"请再次输入密码";
    
    
    _completeBut.backgroundColor          = Navigation_Color;
    _completeBut.layer.cornerRadius       = 4;
}
@end
