//
//  TXHomeModelo.h
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/16.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TXHomeModelo : NSObject
@property(nonatomic,strong)NSString        * icon;//图标的名字
@property(nonatomic,strong)NSString        * title;//组标题
@property(nonatomic,strong)NSArray         * content;//内容
@property(nonatomic,strong)NSString        * total;//总条数


//数据转模型的对象方法
-(instancetype)initWithDic:(NSDictionary *)dic;
//数据转模型的类方法
+(instancetype)homeWithDic:(NSDictionary *)dic;

@end
