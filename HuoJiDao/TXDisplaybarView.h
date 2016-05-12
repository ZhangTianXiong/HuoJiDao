//
//  TXAllDisplaybarView.h
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/28.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXView.h"
#import "TXListFrameModel.h"
@interface TXDisplaybarView : TXView
@property(nonatomic,strong)TXListFrameModel * frameModel;
@property(nonatomic,strong)UIImageView      * thumbs_upIcon;//点赞图标
@property(nonatomic,strong)UIImageView      * treadIcon;//点踩图标
@property(nonatomic,strong)UIImageView      * commendIcon;//评论图标

@property(nonatomic,strong)UILabel          * thumbs_upNum;//点赞个数
@property(nonatomic,strong)UILabel          * treadNum;//点踩个数
@property(nonatomic,strong)UILabel          * commenNum;//评论个数

@end
