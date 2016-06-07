//
//  TXTypeView.h
//  HuoJiDao
//
//  Created by IOS开发 on 16/6/6.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXView.h"
#import "TXListModel.h"
@interface TXTypeView : TXView
@property(nonatomic,strong)TXListModel * model;
@property(nonatomic,strong)UIImageView * icon;
@property(nonatomic,strong)UILabel * typeLabel;
@property(nonatomic,strong)UILabel * timeLabel;

@end
