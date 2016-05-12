//
//  TXScrollFigureModel.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/5/10.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXScrollFigureModel.h"

@implementation TXScrollFigureModel
-(instancetype)initWithDic:(NSDictionary *)dic
{
    if (self =[super init])
    {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
+(instancetype)scrollFigureWithDic:(NSDictionary*)dic
{
    return [[self alloc]initWithDic:dic];
}
@end
