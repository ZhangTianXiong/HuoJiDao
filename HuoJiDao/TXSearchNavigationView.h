//
//  TXSearchNavigationView.h
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/29.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXView.h"

@interface TXSearchNavigationView : TXView
@property(nonatomic,strong)UIButton    * backBut;
@property(nonatomic,strong)UIView      * carrierView;
@property(nonatomic,strong)UIImageView * icon;
@property(nonatomic,strong)UITextField * textField;
@property(nonatomic,strong)UIButton    * searchBut;
@property(nonatomic,strong)UIButton    * cancelBut;
@end
