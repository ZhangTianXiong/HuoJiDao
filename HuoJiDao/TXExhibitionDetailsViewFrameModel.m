//
//  TXVideoDetailsIntroduceFrameModel.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/5/7.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXExhibitionDetailsViewFrameModel.h"
@interface TXExhibitionDetailsViewFrameModel()
@end

@implementation TXExhibitionDetailsViewFrameModel
-(instancetype)initWithModel:(TXListModel *)model
{
    if (self=[super init])
    {
        self.model=model;
    }
    return self;
}
+(instancetype)detailsIntroduceWithModel:(TXListModel *)model
{
    return [[self alloc]initWithModel:model];
}

-(void)setModel:(TXListModel *)model
{
    _model                                  = model;
    UIFont * titleFont                      = [UIFont systemFontOfSize:14];
    CGFloat margin                          = 10;
    CGSize titleSize                        = [model.subject calculateTextSize:CGSizeMake(375-margin, MAXFLOAT) andFoun:titleFont];
    
    
    CGFloat titleLabelFrameX                = margin;//标题
    CGFloat titleLabelFrameY                = margin;
    CGFloat titleLabelFrameW                = titleSize.width;
    CGFloat titleLabelFrameH                = titleSize.height;
    _titleLabelFrame                        = CM(titleLabelFrameX, titleLabelFrameY,titleLabelFrameW , titleLabelFrameH);
   
    CGFloat iconFrameX                      = margin;//图标
    CGFloat iconFrameY                      = CGRectGetMaxY(_titleLabelFrame)+margin;
    CGFloat iconFrameW                      = 15;
    CGFloat iconFrameH                      = 12;
    _iconFrame                              = CM(iconFrameX, iconFrameY, iconFrameW, iconFrameH);
    
    
    
    CGFloat numFrameX                       = CGRectGetMaxX(_iconFrame)+5;//数量
    CGFloat numFrameY                       = iconFrameY;
    CGFloat numFrameW                       = 45;
    CGFloat numFrameH                       = iconFrameH;
    _numFrame                               = CM(numFrameX, numFrameY, numFrameW, numFrameH);
    
    UIFont * briefIntroductionFout          = [UIFont systemFontOfSize:13];
    CGSize briefIntroductionFoutSize        = [_model.description_api calculateTextSize:CGSizeMake(365, MAXFLOAT) andFoun:briefIntroductionFout];
    CGFloat briefIntroductionLabelFrameX    = margin;//介绍
    CGFloat briefIntroductionLabelFrameY    = CGRectGetMaxY(_numFrame)+margin;
    CGFloat briefIntroductionLabelFrameW    = briefIntroductionFoutSize.width;
    CGFloat briefIntroductionLabelFrameH    = briefIntroductionFoutSize.height;
    _briefIntroductionLabelFrame            = CM(briefIntroductionLabelFrameX, briefIntroductionLabelFrameY, briefIntroductionLabelFrameW, briefIntroductionLabelFrameH);
    CGFloat butFrameX                       = margin;//更多
    CGFloat butFrameY                       = CGRectGetMaxY(_briefIntroductionLabelFrame);
    CGFloat butFrameW                       = 50;
    CGFloat butFrameH                       = 15;
    _butFrame                               = CM(butFrameX, butFrameY, butFrameW, butFrameH);

    CGFloat functionBarViewFrameX           = margin;
    CGFloat functionBarViewFrameY           = CGRectGetMaxY(_butFrame)+margin;
    CGFloat functionBarViewFrameW           = 355;
    CGFloat functionBarViewFrameH           = 40;
    _functionBarViewFrame                   = CGRectMake(functionBarViewFrameX, functionBarViewFrameY, functionBarViewFrameW, functionBarViewFrameH);
    _H=CGRectGetMaxY(_functionBarViewFrame)+margin;

}
@end
