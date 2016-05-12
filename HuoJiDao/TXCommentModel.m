//
//  TXCommentModel.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/5/9.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXCommentModel.h"

@implementation TXCommentModel
-(instancetype)initWithDic:(NSDictionary *)dic
{
    if (self=[super init])
    {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
+(instancetype)commentWithDic:(NSDictionary *)dic
{
    return [[self alloc]initWithDic:dic];
}
@end
