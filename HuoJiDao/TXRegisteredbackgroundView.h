//
//  TXRegisteredbackgroundView.h
//  HuoJiDao
//
//  Created by IOS开发 on 16/5/18.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXView.h"
#import "TXRegisteredInputBoxView.h"
@interface TXRegisteredbackgroundView : TXView
@property(nonatomic,strong)UIImageView              * backgroundImage;//背景图片
@property(nonatomic,strong)TXRegisteredInputBoxView * country;
@property(nonatomic,strong)TXRegisteredInputBoxView * phoneNumber;

@property(nonatomic,strong)UIButton                 * obtainBut;
@property(nonatomic,strong)UILabel                  * promptLabel;
@property(nonatomic,strong)UIButton                 * protocolBut;



@end
