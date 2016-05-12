//
//  TXPic_title.h
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/25.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TXPic_title : NSObject

@property(nonatomic,copy)NSString * img;//图片地址
@property(nonatomic,copy)NSString * explain;//图片标题

-(instancetype)initWithDic:(NSDictionary * )dic;
+(instancetype)Pic_titleWithDic:(NSDictionary *)dic;
@end
