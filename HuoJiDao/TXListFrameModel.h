//
//  TXListFrameModel.h
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/28.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+TXCalculateSize.h"
#import "TXListModel.h"
#import <UIKit/UIKit.h>
@interface TXListFrameModel : NSObject
//创建模型
@property(nonatomic,strong)TXListModel        * model;
@property(nonatomic,assign,readonly)CGRect      pictureFrame;//图片Frame
@property(nonatomic,assign,readonly)CGRect      titleFrame;//标题Frame
@property(nonatomic,assign,readonly)CGRect      chaneViewFrame;//频道Frame
@property(nonatomic,assign,readonly)CGRect      datelineLabelFrame;//发布时间Frame
@property(nonatomic,assign,readonly)CGRect      displaybarViewFrame;//显示条Frame
@property(nonatomic,assign,readonly)CGFloat     rowH;//计算行高

-(instancetype)initWithModel:(TXListModel*)model;
+(instancetype)recommendWithModel:(TXListModel*)model;
@end
