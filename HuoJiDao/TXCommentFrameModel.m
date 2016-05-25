//
//  TXCommentFrameModel.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/5/9.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXCommentFrameModel.h"

@implementation TXCommentFrameModel
-(instancetype)initWithModel:(TXCommentModel *)model
{
    if (self=[super init])
    {
        self.model=model;
    }
    return self;
}
+(instancetype)commentWithModel:(TXCommentModel *)model
{
    return [[self alloc]initWithModel:model];
}
-(void)setModel:(TXCommentModel *)model
{
    _model                          = model;

    //计算Frame
    CGFloat margin                  = 15;
    
    CGFloat userIconFrameX          = margin;//用户头像
    CGFloat userIconFrameY          = margin;
    CGFloat userIconFrameW_H        = 50;
    _userIconFrame                  = CGRectMake(userIconFrameX, userIconFrameY, userIconFrameW_H, userIconFrameW_H);
    
    
    
    CGFloat userNameFrameX          = CGRectGetMaxX(_userIconFrame)+margin;//用户名称
    CGFloat userNameFrameY          = CGRectGetMinY(_userIconFrame)+3;
    CGFloat userNameFrameW          = 150;
    CGFloat userNameFrameH          = 20;
    _userNameFrame                  = CGRectMake(userNameFrameX, userNameFrameY, userNameFrameW, userNameFrameH);
    
    
    
    CGFloat datelineFrameX          = userNameFrameX;//发表时间
    CGFloat datelineFrameY          = CGRectGetMaxY(_userNameFrame)+5;
    CGFloat datelineFrameW          = 100;
    CGFloat datelineFrameH          = 20;
    _datelineFrame                  = CGRectMake(datelineFrameX, datelineFrameY, datelineFrameW, datelineFrameH);
    
   
    CGFloat likeViewFrameX          = 300;//点赞View
    CGFloat likeViewFrameY          = CGRectGetMaxY(_userNameFrame)+2;
    CGFloat likeViewFrameW          = 80;
    CGFloat likeViewFrameH          = 20;
    _likeViewFrame                  = CGRectMake(likeViewFrameX, likeViewFrameY, likeViewFrameW, likeViewFrameH);
    
    
    CGFloat unlikeViewFrameX        = CGRectGetMaxX(_likeViewFrame)+margin;//点踩View
    CGFloat unlikeViewFrameY        = likeViewFrameY;
    CGFloat unlikeViewFrameW        = likeViewFrameW;
    CGFloat unlikeViewFrameH        = likeViewFrameH;
    _unlikeViewFrame                = CGRectMake(unlikeViewFrameX, unlikeViewFrameY, unlikeViewFrameW, unlikeViewFrameH);
    
    UIFont * messageFont            = [UIFont systemFontOfSize:12];
    CGSize  messageSize             = [_model.message calculateTextSize:CGSizeMake(375-65-15, MAXFLOAT) andFoun:messageFont];
    
    CGFloat messageFrameX           = userNameFrameX;
    CGFloat messageFrameY           = CGRectGetMaxY(_datelineFrame)+margin;
    CGFloat messageFrameW           = messageSize.width;
    CGFloat messageFrameH           = messageSize.height;
    _messageFrame                   = CGRectMake(messageFrameX, messageFrameY, messageFrameW, messageFrameH);
    
    //行高
    _rowH                           = CGRectGetMaxY(_messageFrame)+margin;
    
}
@end
