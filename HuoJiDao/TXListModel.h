//
//  TXListModel.h
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/28.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TXListModel : NSObject

@property(nonatomic,copy)NSString * blogid;//内容id
@property(nonatomic,copy)NSString * uid;//发布者id
@property(nonatomic,copy)NSString * vid;//视频id，用于获取视频
@property(nonatomic,copy)NSString * link;//链接，用于访问链接
@property(nonatomic,copy)NSString * img;//缩略图，没有缩略图则返回字符 none
@property(nonatomic,copy)NSString * subject;//主标题
@property(nonatomic,copy)NSString * description_api;//副标题
@property(nonatomic,copy)NSString * like;//点赞数
@property(nonatomic,copy)NSString * unlike;//点踩数
@property(nonatomic,copy)NSString * replynum;//回复数
@property(nonatomic,copy)NSString * favnum;//收藏数
@property(nonatomic,copy)NSString * source;//来源
@property(nonatomic,copy)NSString * dateline;//时间
@property(nonatomic,copy)NSString * type;//内容类型
-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)listWithModelDic:(NSDictionary *)dic;

@end
