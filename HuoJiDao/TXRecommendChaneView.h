//
//  TXChaneView.h
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/22.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXView.h"

#import "TXListFrameModel.h"
@interface TXRecommendChaneView : UIView
@property(nonatomic,strong)TXListFrameModel * frameModel;//创建模型

@property(nonatomic,strong)UIImageView           * chaneIcon;//创建频道图标
@property(nonatomic,strong)UILabel               * chaneNameLabel;//创建频道名称
@property(nonatomic,strong)UIButton              * chaneBut;//创建频道点击事件


@end
