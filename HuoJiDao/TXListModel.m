//
//  TXListModel.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/28.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXListModel.h"

@implementation TXListModel
-(instancetype)initWithDic:(NSDictionary *)dic
{
    if (self=[super init])
    {
        //赋值
        _blogid          = dic[@"blogid"];//内容id
        _uid             = dic[@"uid"];//发布者id
        _vid             = dic[@"vid"];//视频id，用于获取视频
        _link            = dic[@"link"];//链接，用于访问链接
        _img             = dic[@"img"];//缩略图，没有缩略图则返回字符 none
        _subject         = dic[@"subject"];//主标题
        _description_api = dic[@"description"];
        _like            = dic[@"like"];//点赞数
        _unlike          = dic[@"unlike"];//点踩数
        _replynum        = dic[@"replynum"];//回复数
        _favnum          = dic[@"favnum"];//收藏数
        _source          = dic[@"source"];//来源
        _dateline        = dic[@"dateline"];//时间
        _type            = dic[@"type"];//内容类型
    }
    return self;
}
+(instancetype)listWithModelDic:(NSDictionary *)dic
{
    return [[self alloc]initWithDic:dic];
}
@end
