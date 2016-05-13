//
//  TXVideoDetailsIntroduce.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/5/7.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXExhibitionDetailsView.h"

@implementation TXExhibitionDetailsView
-(instancetype)init
{
    if (self=[super init])
    {
        self.backgroundColor=[UIColor whiteColor];
        UILabel * titleLabel=[[UILabel alloc]init];//标题
        titleLabel.font=[UIFont systemFontOfSize:14];
        titleLabel.numberOfLines=0;
        _titleLabel=titleLabel;
        UIImageView * icon=[[UIImageView alloc]init];//图标
        icon.image=[UIImage imageNamed:@"视频图"];
        _icon=icon;
        UILabel * num=[[UILabel alloc]init];//数量
        num.font=[UIFont systemFontOfSize:12];
        num.textColor=[UIColor grayColor];
        _num=num;
        
        UILabel * briefIntroductionLabel=[[UILabel alloc]init];//介绍
        briefIntroductionLabel.font=[UIFont systemFontOfSize:13];
        briefIntroductionLabel.textColor=[UIColor grayColor];
        briefIntroductionLabel.numberOfLines=2;
        _briefIntroductionLabel=briefIntroductionLabel;
        
        UIButton * but=[UIButton buttonWithType:UIButtonTypeCustom];//更多
        [but setTitle:@"...更多" forState:UIControlStateNormal];
        but.titleLabel.font=[UIFont systemFontOfSize:12];
        [but setTitleColor:Color(249, 126, 160, 1)forState:UIControlStateNormal];
        _but=but;
        
        //videoDisplaybarView
        TXFunctionBarView * functionBarView=[[TXFunctionBarView alloc]init];
        functionBarView.backgroundColor=[UIColor redColor];
        _functionBarView=functionBarView;
        
        
        [self addSubview:titleLabel];
        [self addSubview:icon];
        [self addSubview:num];
        [self addSubview:briefIntroductionLabel];
        [self addSubview:but];
        [self addSubview:functionBarView];
    }
    return self;
}
-(void)setFrameModel:(TXExhibitionDetailsViewFrameModel *)frameModel
{
    _frameModel=frameModel;
    
    //设置Frame
    _titleLabel.frame=_frameModel.titleLabelFrame;
    _icon.frame=_frameModel.iconFrame;
    _num.frame=_frameModel.numFrame;
    _briefIntroductionLabel.frame=_frameModel.briefIntroductionLabelFrame;
    _but.frame=_frameModel.butFrame;
    _functionBarView.frame=_frameModel.functionBarViewFrame;
    
    //设置数据
    _titleLabel.text=_frameModel.model.subject;
    _briefIntroductionLabel.text=_frameModel.model.description_api;
    _num.text=@"7万";
    _functionBarView.model=_frameModel.model;
}

@end
