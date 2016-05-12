//
//  TXDisplaybar.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/22.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXRecommendDisplaybarView.h"

@implementation TXRecommendDisplaybarView
#pragma mark---------------重写setFrameModel方法-----------
-(void)setFrameModel:(TXListFrameModel *)frameModel
{
    _frameModel = frameModel;
    [self setViewFrame];
    [self setViewData];
}
#pragma mark---------------设置视图数据-----------
-(void)setViewData{
    _thumbs_upNum.text       = _frameModel.model.like;
    _treadNum.text           = _frameModel.model.unlike;
    _commenNum.text          = _frameModel.model.replynum;
    _thumbs_upIcon.image     = [UIImage imageNamed:@"01点赞"];
    _treadIcon.image         = [UIImage imageNamed:@"02点踩"];
    _commendIcon.image       = [UIImage imageNamed:@"03评论"];
}
#pragma mark---------------设置视图框架-----------
-(void)setViewFrame
{
    
    CGFloat viewH             = self.frame.size.height;
    
   
    CGFloat Y                 = 0;
    CGFloat textW             = 50;
    //点赞图标
    CGFloat thumbs_upIconX    = 0;
    _thumbs_upIcon.frame      = CM(thumbs_upIconX, Y, viewH, viewH);
    //点赞个数
    CGFloat thumbs_upNumX     = CGRectGetMaxX(_thumbs_upIcon.frame);
    CGFloat thumbs_upNumY     = 0;
    _thumbs_upNum.frame       = CM(thumbs_upNumX, thumbs_upNumY, textW, viewH);
    
    //点踩图标
    CGFloat treadIconX        = CGRectGetMaxX(_thumbs_upNum.frame);
    _treadIcon.frame          = CM(treadIconX, Y, viewH, viewH);
    //点踩个数
    CGFloat treadNumX         = CGRectGetMaxX(_treadIcon.frame);
    _treadNum.frame           = CM(treadNumX, Y, textW, viewH);
    //评论图标
    CGFloat commendIconX      = CGRectGetMaxX(_treadNum.frame);
    _commendIcon.frame        = CM(commendIconX, Y, viewH, viewH);
    //评论个数
    CGFloat commendNumX       = CGRectGetMaxX(_commendIcon.frame);
    _commenNum.frame          = CM(commendNumX, Y, textW, viewH);
}
#pragma mark---------------初始化视图-----------
-(void)initView
{
    //创建点赞图标
    UIImageView     * thumbs_upIcon = [[UIImageView alloc]init];
    _thumbs_upIcon                  = thumbs_upIcon;
    
    //创建点踩图标
    UIImageView     * treadIcon     = [[UIImageView alloc]init];
    _treadIcon                      = treadIcon;
    //创建评论图标
    UIImageView     * commendIcon   = [[UIImageView alloc]init];
    _commendIcon                    = commendIcon;
    
    //管理字体的大小以及颜色
    UIFont * textFont=[UIFont systemFontOfSize:11];
    UIColor * textColor=[UIColor grayColor];
    
    //创建点赞个数
    UILabel         * thumbs_upNum  = [[UILabel alloc]init];
    thumbs_upNum.font=textFont;
    thumbs_upNum.textColor=textColor;
    thumbs_upNum.textAlignment      = NSTextAlignmentCenter;
    _thumbs_upNum                   = thumbs_upNum;
    
    //创建点踩个数
    UILabel         * treadNum      = [[UILabel alloc]init];
    treadNum.font=textFont;
    treadNum.textColor=textColor;
    treadNum.textAlignment          = NSTextAlignmentCenter ;
    _treadNum                       = treadNum;
    
    //创建评论个数
    UILabel         * commenNum     = [[UILabel alloc]init];
    commenNum.font=textFont;
    commenNum.textColor=textColor;
    commenNum.textAlignment         = NSTextAlignmentCenter ;
    _commenNum                      = commenNum;
    
    [self addSubview:thumbs_upIcon];
    [self addSubview:treadIcon];
    [self addSubview:commendIcon];
    [self addSubview:thumbs_upNum];
    [self addSubview:treadNum];
    [self addSubview:commenNum];
    
    
    
}

#pragma mark---------------重写init方法法-----------
-(instancetype)init
{
    if (self=[super init])
    {
        /*************************************************
         **                                             **
         ** 注意程序加载的次序。可以准确的说可划分为三个层次    **
         **  1.初始化视图---initView                     **
         **  2.设置视图位置---setViewFrame                **
         **  3.设置视图数据---setViewData                 **
         **************************************************/
        [self initView];
        self.backgroundColor=[UIColor whiteColor];
    }
    return self;
}
@end
