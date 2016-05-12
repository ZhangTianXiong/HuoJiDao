//
//  TXCommentModel.h
//  HuoJiDao
//
//  Created by IOS开发 on 16/5/9.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TXCommentModel : NSObject
@property(nonatomic,copy)NSString * replycontent; //回复内容
@property(nonatomic,copy)NSString * replyname;    //回复人
@property(nonatomic,copy)NSString * cid;          //评论内容id
@property(nonatomic,copy)NSString * author;       //评论者的昵称
@property(nonatomic,copy)NSString * replyto;      //被回复评论的id，此评论不为回复则返回 0
@property(nonatomic,copy)NSString * avatar;       //评论者的头像地址
@property(nonatomic,copy)NSString * message;      //评论内容
@property(nonatomic,copy)NSString * level;        //回复级数，也就是缩进层次
@property(nonatomic,copy)NSString * dateline;     //评论时间
@property(nonatomic,copy)NSString * like;         //点赞数
@property(nonatomic,copy)NSString * unlike;       //点踩数

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)commentWithDic:(NSDictionary * )dic;


@end
