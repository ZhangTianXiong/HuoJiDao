//
//  TXVideoDetailsIntroduceFrameModel.h
//  HuoJiDao
//
//  Created by IOS开发 on 16/5/7.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NSString+TXCalculateSize.h"
#import "TXListModel.h"
@interface TXExhibitionDetailsViewFrameModel : NSObject
@property(nonatomic,strong)TXListModel *    model;
@property(nonatomic,assign,readonly)CGRect  titleLabelFrame;//标题
@property(nonatomic,assign,readonly)CGRect  iconFrame;//图标
@property(nonatomic,assign,readonly)CGRect  numFrame;//数量
@property(nonatomic,assign,readonly)CGRect  briefIntroductionLabelFrame;//介绍
@property(nonatomic,assign,readonly)CGRect  butFrame;//更多
@property(nonatomic,assign,readonly)CGRect  functionBarViewFrame;
@property(nonatomic,assign,readonly)CGFloat H;

-(instancetype)initWithModel:(TXListModel*)model;
+(instancetype)detailsIntroduceWithModel:(TXListModel*)model;

@end
