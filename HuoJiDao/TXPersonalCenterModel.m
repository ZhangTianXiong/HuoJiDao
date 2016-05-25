//
//  TXPersonalCenterModel.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/5/19.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXPersonalCenterModel.h"

@implementation TXPersonalCenterModel
-(instancetype)initWithDic:(NSDictionary *)dic
{
    if (self =[super init])
    {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
+(instancetype)userInformationWithDic:(NSDictionary *)dic
{
    return [[self alloc]initWithDic:dic];
}

//将用户模型转化为aCoder 数据
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.username forKey:@"username"];
    [aCoder encodeObject:self.nickname forKey:@"nickname"];
    [aCoder encodeObject:self.sex forKey:@"sex"];
    [aCoder encodeObject:self.residecity forKey:@"residecity"];
    [aCoder encodeObject:self.avatar forKey:@"avatar"];
    [aCoder encodeObject:self.credit forKey:@"credit"];
    [aCoder encodeObject:self.notenum forKey:@"notenum"];
    [aCoder encodeObject:self.newpm forKey:@"newpm"];
    [aCoder encodeObject:self.note forKey:@"note"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    
    if (self =[super init])
    {
        self.username=[aDecoder decodeObjectForKey:@"username"];
        self.nickname=[aDecoder decodeObjectForKey:@"nickname"];
        self.sex=[aDecoder decodeObjectForKey:@"sex"];
        self.residecity=[aDecoder decodeObjectForKey:@"residecity"];
        self.avatar=[aDecoder decodeObjectForKey:@"avatar"];
        self.credit=[aDecoder decodeObjectForKey:@"credit"];
        self.notenum=[aDecoder decodeObjectForKey:@"notenum"];
        self.newpm=[aDecoder decodeObjectForKey:@"newpm"];
        self.note=[aDecoder decodeObjectForKey:@"note"];
        self.uid=[aDecoder decodeObjectForKey:@"uid"];
    }
    return self;
}
@end
