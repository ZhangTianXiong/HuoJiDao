//
//  TXPic_titleFrameModel.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/25.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXPic_titleFrameModel.h"

@implementation TXPic_titleFrameModel

-(void)setPic_titleModel:(TXPic_title *)pic_titleModel
{
    _pic_titleModel=pic_titleModel;
    
    //边距
    CGFloat margin=10;
    UIFont * font=[UIFont systemFontOfSize:14];
    
    //标题
    CGSize  textSize=[_pic_titleModel.explain calculateTextSize:CGSizeMake(357, MAXFLOAT) andFoun:font];
    
    CGFloat  titleLabelX=margin;
    CGFloat  titleLabelY=margin;
    CGFloat  titleLabelW=textSize.width;
    CGFloat  titleLabelH=textSize.height;
    _titleLabelFrame=CM(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    
    //图片
    CGFloat picX = 0;
    CGFloat picY = CGRectGetMaxY(_titleLabelFrame)+margin;
    CGFloat picW = 375;
    CGFloat picH = 260;
    _pictureImageFrame=CM(picX, picY, picW, picH);
    
    //功能条
    CGFloat functionBarViewX=0;
    CGFloat functionBarViewY=CGRectGetMaxY(_pictureImageFrame)+margin;
    CGFloat functionBarViewW=375;
    CGFloat functionBarViewH=40;
    
    _functionBarViewFrame=CM(functionBarViewX, functionBarViewY, functionBarViewW, functionBarViewH);
    
    
    
    CGFloat rowH=CGRectGetMaxY(_functionBarViewFrame)+margin;
    _rowH=rowH;
}
-(instancetype)initWithModel:(TXPic_title *)pic_titleModel{
    if (self=[super init])
    {
        self.pic_titleModel=pic_titleModel;
    }
    return self;
}
+(instancetype)pic_titleWithModel:(TXPic_title *)pic_titleModel{
    return [[self alloc]initWithModel:pic_titleModel];
}
@end
