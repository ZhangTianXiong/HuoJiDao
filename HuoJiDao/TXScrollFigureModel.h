//
//  TXScrollFigureModel.h
//  HuoJiDao
//
//  Created by IOS开发 on 16/5/10.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TXScrollFigureModel : NSObject
@property(nonatomic,strong)NSString * url;
@property(nonatomic,strong)NSString * link;
-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)scrollFigureWithDic:(NSDictionary*)dic;

@end
