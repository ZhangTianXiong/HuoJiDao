//
//  TXDetailsIntroduce.h
//  HuoJiDao
//
//  Created by IOS开发 on 16/5/7.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXView.h"
#import "TXExhibitionDetailsViewFrameModel.h"

#import "TXFunctionBarView.h"

@interface TXExhibitionDetailsView : TXView
@property(nonatomic,strong)TXExhibitionDetailsViewFrameModel    * frameModel;
@property(nonatomic,strong)UILabel                              * titleLabel;//标题
@property(nonatomic,strong)UIImageView                          * icon;//图标
@property(nonatomic,strong)UILabel                              * num;//数量
@property(nonatomic,strong)UILabel                              * briefIntroductionLabel;//介绍
@property(nonatomic,strong)UIButton                             * but;//更多
@property(nonatomic,strong)TXFunctionBarView                    * functionBarView;

@end
