//
//  TXPic_titleFrameModel.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/25.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXPic_titleFrameModel.h"

@implementation TXPic_titleFrameModel

-(void)setPic_titleModel:(TXListModel *)pic_titleModel
{
    _pic_titleModel             = pic_titleModel;
    
    //边距
    CGFloat margin              = 10;
    UIFont * font               = [UIFont systemFontOfSize:14];
    
    //标题
    CGSize  textSize            = [_pic_titleModel.subject calculateTextSize:CGSizeMake(VIEW_WIDTH-margin*2, MAXFLOAT) andFoun:font];
    
    CGFloat  titleLabelX        = margin;
    CGFloat  titleLabelY        = margin;
    CGFloat  titleLabelW        = textSize.width;
    CGFloat  titleLabelH        = textSize.height;
    _titleLabelFrame            = CM(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    
    //图片
    CGFloat picX                = 0;
    CGFloat picY                = CGRectGetMaxY(_titleLabelFrame)+margin;
    CGFloat picW                = VIEW_WIDTH;
    CGFloat picH                = 260;
    _pictureImageFrame          = CM(picX, picY, picW, picH);
    
    //类型View
    CGFloat typeViewX=0;
    CGFloat typeViewY=CGRectGetMaxY(_pictureImageFrame);
    CGFloat typeViewW=VIEW_WIDTH;
    CGFloat typeViewH=35;
    _typeViewFrame=CM(typeViewX, typeViewY, typeViewW, typeViewH);
    //功能条
    CGFloat functionBarViewX    = 0;
    CGFloat functionBarViewY    =CGRectGetMaxY(_typeViewFrame);
    CGFloat functionBarViewW    = VIEW_WIDTH;
    CGFloat functionBarViewH    = 40;
    
    _functionBarViewFrame       = CM(functionBarViewX, functionBarViewY, functionBarViewW, functionBarViewH);
    
    
    
    CGFloat rowH                = CGRectGetMaxY(_functionBarViewFrame)+margin;
    _rowH=rowH;
}
-(instancetype)initWithModel:(TXListModel *)pic_titleModel{
    if (self=[super init])
    {
        self.pic_titleModel=pic_titleModel;
    }
    return self;
}
+(instancetype)pic_titleWithModel:(TXListModel *)pic_titleModel{
    return [[self alloc]initWithModel:pic_titleModel];
}
@end
