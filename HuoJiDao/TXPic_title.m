//
//  TXPic_title.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/25.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXPic_title.h"

@implementation TXPic_title
-(instancetype)initWithDic:(NSDictionary *)dic
{
    if (self=[super init])
    {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
+(instancetype)Pic_titleWithDic:(NSDictionary *)dic
{
    return [[self alloc]initWithDic:dic];
}
@end
