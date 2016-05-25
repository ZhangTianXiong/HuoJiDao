//
//  TXCommentFrameModel.h
//  HuoJiDao
//
//  Created by IOS开发 on 16/5/9.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TXCommentModel.h"
#import "NSString+TXCalculateSize.m"
@interface TXCommentFrameModel : NSObject
@property(nonatomic,strong)TXCommentModel   *   model;
@property(nonatomic,assign,readonly)CGRect      userIconFrame;//用户头像
@property(nonatomic,assign,readonly)CGRect      userNameFrame;//用户名称
@property(nonatomic,assign,readonly)CGRect      datelineFrame;//发表时间
//准备将他创建成公用的类
@property(nonatomic,assign,readonly)CGRect      likeViewFrame;//点赞View
@property(nonatomic,assign,readonly)CGRect      unlikeViewFrame;//点踩View
@property(nonatomic,assign,readonly)CGRect      messageFrame;//消息
@property(nonatomic,assign,readonly)CGFloat     rowH;

@property(nonatomic,strong)UILabel          *   message;//消息
-(instancetype)initWithModel:(TXCommentModel *)model;
+(instancetype)commentWithModel:(TXCommentModel *)model;
@end
