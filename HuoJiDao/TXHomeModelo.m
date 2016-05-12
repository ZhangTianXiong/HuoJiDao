//
//  TXHomeModelo.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/16.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXHomeModelo.h"
#import "TXListModel.h"
@implementation TXHomeModelo
//数据转模型的对象方法
-(instancetype)initWithDic:(NSDictionary *)dic
{
    if (self=[super init])
    {
        [self setValuesForKeysWithDictionary:dic];
        
        //数据转模型
        NSMutableArray    * muarray=[NSMutableArray array];
        for (NSDictionary * dic in _content)
        {
            //数据转模型
            TXListModel * listModel = [TXListModel listWithModelDic:dic];
            [muarray addObject:listModel];
        }
        _content = muarray;
    }
    return self;
}
//数据转模型的类方法
+(instancetype)homeWithDic:(NSDictionary *)dic
{
    return [[self alloc]initWithDic:dic];
}
@end
