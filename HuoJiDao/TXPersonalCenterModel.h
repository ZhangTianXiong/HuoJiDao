//
//  TXPersonalCenterModel.h
//  HuoJiDao
//
//  Created by IOS开发 on 16/5/19.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TXPersonalCenterModel : NSObject<NSCoding>
@property(nonatomic,strong)NSString * username;
@property(nonatomic,strong)NSString * nickname;
@property(nonatomic,strong)NSString * sex;
@property(nonatomic,strong)NSString * residecity;
@property(nonatomic,strong)NSString * avatar;
@property(nonatomic,strong)NSString * credit;
@property(nonatomic,strong)NSString * notenum;
@property(nonatomic,strong)NSString * newpm;
@property(nonatomic,strong)NSString * note;
@property(nonatomic,strong)NSString * uid;
-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)userInformationWithDic:(NSDictionary *)dic;
@end
