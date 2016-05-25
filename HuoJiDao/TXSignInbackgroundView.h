//
//  TXSignInbackgroundView.h
//  HuoJiDao
//
//  Created by IOS开发 on 16/5/17.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXView.h"
#import "TXInputBoxView.h"
#import "TXThirdPartyIoginView.h"
@interface TXSignInbackgroundView : TXView
@property(nonatomic,strong)UIImageView           * backgroundImage;//背景图片
@property(nonatomic,strong)TXInputBoxView        * userAccount;//用户账号
@property(nonatomic,strong)TXInputBoxView        * userPassword;//用户密码

@property(nonatomic,strong)UIButton              * registeredBut;//注册
@property(nonatomic,strong)UIButton              * signInBut;//登录

@property(nonatomic,strong)TXThirdPartyIoginView * thirdPartyIoginView;//第三方登录

@end
