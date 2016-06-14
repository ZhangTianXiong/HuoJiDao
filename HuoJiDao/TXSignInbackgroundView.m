//
//  TXSignInbackgroundView.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/5/17.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXSignInbackgroundView.h"

@implementation TXSignInbackgroundView

-(instancetype)init
{
    if (self =[super init])
    {
        self.backgroundColor                        = [UIColor whiteColor];
        UIImageView    * backgroundImage            = [[UIImageView alloc]init];
        _backgroundImage                            = backgroundImage;
        //用户账号
        TXInputBoxView * userAccount                = [[TXInputBoxView alloc]init];
        _userAccount                                = userAccount;
        
        //用户密码
        TXInputBoxView * userPassword               = [[TXInputBoxView alloc]init];
        userPassword.textField.secureTextEntry      = YES;//密文形式
        _userPassword=userPassword;
        
        //注册
        UIButton       * registeredBut              = [[UIButton alloc]init];
        registeredBut.layer.masksToBounds           = YES;
        registeredBut.layer.borderWidth             = 1;
        registeredBut.layer.borderColor             = Color(240, 240, 240, 1).CGColor;;
        registeredBut.layer.cornerRadius            = 3;
        [registeredBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _registeredBut=registeredBut;

        //登录
        UIButton       * signInBut=[[UIButton alloc]init];
        
        signInBut.layer.cornerRadius                = 3;
        signInBut.backgroundColor                   = Navigation_Color;
        _signInBut                                  = signInBut;

        
        TXThirdPartyIoginView * thirdPartyIoginView = [[TXThirdPartyIoginView alloc]init];
        _thirdPartyIoginView                        = thirdPartyIoginView;
        
        
        
        [self addSubview:backgroundImage];
        
        [self addSubview:userAccount];
        [self addSubview:userPassword];
        [self addSubview:signInBut];
        [self addSubview:registeredBut];
        [self addSubview:thirdPartyIoginView];
        

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
    CGFloat margin=15;
    CGFloat userAccountX        = 0;
    CGFloat userAccountY        = self.frame.size.width/6;
    CGFloat userAccountW        = viewW;
    CGFloat userAccountH        = 45;
    _userAccount.frame          = CM(userAccountX, userAccountY, userAccountW, userAccountH);
    
    CGFloat userPasswordX       = 0;
    CGFloat userPasswordY       = CGRectGetMaxY(_userAccount.frame)-1;
    CGFloat userPasswordW       = viewW;
    CGFloat userPasswordH       = userAccountH;
    _userPassword.frame         = CM(userPasswordX, userPasswordY, userPasswordW, userPasswordH);
    
    CGFloat registeredButX      = margin;
    CGFloat registeredButY      = CGRectGetMaxY(_userPassword.frame)+margin;
    CGFloat registeredButW      = viewW/2-25;
    CGFloat registeredButH      = 40;
    _registeredBut.frame        = CM(registeredButX, registeredButY, registeredButW, registeredButH);
    
    CGFloat signInButX          = CGRectGetMaxX(_registeredBut.frame)+margin+5;
    CGFloat signInButY          = registeredButY;
    CGFloat signInButW          = registeredButW;
    CGFloat signInButH          = registeredButH;
    _signInBut.frame            = CM(signInButX, signInButY, signInButW, signInButH);
    
    
    CGFloat thirdPartyIoginViewX= 0;
    CGFloat thirdPartyIoginViewH= viewH/2.5;
    CGFloat thirdPartyIoginViewY= viewH-thirdPartyIoginViewH;
    CGFloat thirdPartyIoginViewW= viewW;
    
    _thirdPartyIoginView.frame  = CM(thirdPartyIoginViewX, thirdPartyIoginViewY, thirdPartyIoginViewW, thirdPartyIoginViewH);
    
}

-(void)setViewData
{
    _userAccount.icon.image              = [UIImage imageNamed:@"用户"];
    _userAccount.textField.placeholder   = @"在这里输入账号/手机号/邮箱";
    _userPassword.icon.image             = [UIImage imageNamed:@"密码"];
    _userPassword.textField.placeholder  = @"请输入密码";
    
    [_registeredBut setTitle:@"注册" forState:UIControlStateNormal];
    [_signInBut setTitle:@"登录" forState:UIControlStateNormal];
}
@end
