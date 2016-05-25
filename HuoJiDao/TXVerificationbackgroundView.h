//
//  TXVerificationbackgroundView.h
//  HuoJiDao
//
//  Created by IOS开发 on 16/5/18.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXView.h"

@interface TXVerificationbackgroundView : TXView
@property(nonatomic,strong)UIImageView    * backgroundImage;//背景图片
@property(nonatomic,strong)UILabel        * promptLabel;
@property(nonatomic,strong)UILabel        * phoneNumberLabel;
@property(nonatomic,strong)UITextField    * textField;
@property(nonatomic,strong)UILabel        * countdownLabel;
@property(nonatomic,strong)UIButton       * nextBut;

@end
