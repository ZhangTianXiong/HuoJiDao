//
//  TXListFrameModel.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/28.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXListFrameModel.h"

@implementation TXListFrameModel

/*************************************************
 **   为什么要在重写的Model中计算位置呢？            **
 **    因为模型数据每一次都在变化                    **
 **    所以计算时的位置都不一样                     **
 **                                             **
 **                                             **
 **                                             **
 *************************************************/
//计算Frame
-(void)setModel:(TXListModel *)model{
    _model=model;
    //边距
    CGFloat  margin             = 10;
    //图片Frame
    CGFloat  pictureX           = margin;
    CGFloat  pictureY           = margin;
    CGFloat  pictureW           = 100;
    CGFloat  pictureH           = 80;
    _pictureFrame               = CM(pictureX, pictureY, pictureW, pictureH);
    
    //标题
    UIFont * font               = [UIFont systemFontOfSize:13];
    CGSize   titleSize          = [self.model.subject calculateTextSize:CGSizeMake(240, MAXFLOAT) andFoun:font];
    CGFloat  titleX             = CGRectGetMaxX(_pictureFrame)+margin;
    CGFloat  titleY             = margin;
    CGFloat  titleW             = titleSize.width;
    CGFloat  titleH             = titleSize.height;
    _titleFrame                 = CM(titleX, titleY, titleW, titleH);
    
    //频道
    CGFloat chaneViewX          = titleX;
    CGFloat chaneViewY          = CGRectGetMaxY(_titleFrame)+margin;
    CGFloat chaneViewW          = 80;
    CGFloat chaneViewH          = 21;
    _chaneViewFrame             = CM(chaneViewX, chaneViewY, chaneViewW, chaneViewH);
    
    //时间显示
    CGFloat datelineLabelX      = CGRectGetMaxX(_chaneViewFrame)+margin;
    CGFloat datelineLabelY      = chaneViewY;
    CGFloat datelineLabelW      = 80;
    CGFloat datelineLabelH      = 21;
    _datelineLabelFrame         = CM(datelineLabelX, datelineLabelY, datelineLabelW, datelineLabelH);
    
    
    //显示条
    CGFloat displaybarViewX     = titleX;
    CGFloat displaybarViewY     = CGRectGetMaxY(_datelineLabelFrame)+margin;
    CGFloat displaybarViewW     = 200;
    CGFloat displaybarViewH     = 21;
    _displaybarViewFrame        = CM(displaybarViewX, displaybarViewY, displaybarViewW, displaybarViewH);
    
    //计算行高
    /****************************************************************************
     ** 在计算行高时：根据所需要的自适应方法来计算行高                                 **
     **  1.这里的需要是：根据文字来自适应行高。                                       **
     **  2.为什要进行判断：                                                       **
     **    a.当图片的最大Y值大于最后一个控件的Y值时那么就以图片的最大Y值加上间距          **
     **    b.当图片的最大Y值小于最后一个控件的Y值时那么就以最后一个控件的最大Y值加上边距    **
     ******************************************************************************/
    if (CGRectGetMaxY(_displaybarViewFrame)<CGRectGetMaxY(_pictureFrame)) {
        _rowH = CGRectGetMaxY(_pictureFrame)+margin;
    }else{
        _rowH = CGRectGetMaxY(_displaybarViewFrame)+margin;
    }
    
}
/*************************************************
 **                                             **
 ** 主要用于计算Frame                             **
 ** 1、initWithModel:重写该方法主要用于计算Frame     **
 **                                             **
 **                                             **
 ************************************************/
-(instancetype)initWithModel:(TXListModel*)model
{
    if (self=[super init])
    {
        self.model = model;
    }
    return self;
}
+(instancetype)recommendWithModel:(TXListModel*)model
{
    return [[self alloc]initWithModel:model];
}
@end
