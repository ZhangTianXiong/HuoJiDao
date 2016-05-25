//
//  TXSetPasswordbackgroundView.h
//  HuoJiDao
//
//  Created by IOS开发 on 16/5/19.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXView.h"
#import "TXRegisteredInputBoxView.h"
@interface TXSetPasswordbackgroundView : TXView
@property(nonatomic,strong)UIImageView              * backgroundImage;//背景图片
@property(nonatomic,strong)UILabel                  * promptLabel;
@property(nonatomic,strong)TXRegisteredInputBoxView * nickname;

@property(nonatomic,strong)TXRegisteredInputBoxView * password;
@property(nonatomic,strong)TXRegisteredInputBoxView * verifyPassword;
@property(nonatomic,strong)UIButton                 * completeBut;
@end
