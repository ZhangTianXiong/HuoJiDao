//
//  TXTypeView.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/6/6.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXTypeView.h"

@implementation TXTypeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)init
{
    if (self = [super init])
    {
        self.backgroundColor=[UIColor whiteColor];
        UIImageView * icon=[[UIImageView alloc]init];
        _icon=icon;
        
        UILabel     * typeLabel=[[UILabel alloc]init];
        _typeLabel=typeLabel;
        
        UILabel     * timeLabel=[[UILabel alloc]init];
        _timeLabel=timeLabel;
        
        
        [self addSubview:icon];
        [self addSubview:typeLabel];
        [self addSubview:timeLabel];
        
    }
    return self;
}
-(void)drawRect:(CGRect)rect
{
    [self setViewFrame];
//    [self setViewData];
    
}
-(void)setViewFrame
{
    CGFloat veiwH=self.frame.size.height;
    CGFloat margin=10;
    CGFloat iconX=margin;
    CGFloat iconW_H= 15;
    CGFloat iconY=(veiwH-iconW_H)/2;
    _icon.frame=CM(iconX, iconY, iconW_H, iconW_H);
    
    CGFloat typeLabelX=CGRectGetMaxX(_icon.frame);
    CGFloat typeLabelY=iconY;
    CGFloat typeLabelW=50;
    CGFloat typeLabelH=iconW_H;
    _typeLabel.frame=CM(typeLabelX, typeLabelY, typeLabelW, typeLabelH);
    
    CGFloat timeLabelX=CGRectGetMaxX(_typeLabel.frame);
    CGFloat timeLabelH=10;
    CGFloat timeLabelY=(veiwH-timeLabelH)/2;
    CGFloat timeLabelW=100;
    _timeLabel.frame=CM(timeLabelX, timeLabelY, timeLabelW, timeLabelH);
}
-(void)setViewData
{
    _icon.image=[UIImage imageNamed:@"图片"];
    _typeLabel.font                = [UIFont systemFontOfSize:16];
    _typeLabel.textColor           = TitleLab_Color;
    _typeLabel.textAlignment       = NSTextAlignmentCenter;
    _typeLabel.text=_model.type;
    _typeLabel.textColor=Color(121, 200, 169, 1);
    
    _timeLabel.font=[UIFont systemFontOfSize:11];
    _timeLabel.textColor=[UIColor grayColor];
    _timeLabel.text=[NSString stringWithFormat:@"@ %@",_model.dateline];
    

}
-(void)setModel:(TXListModel *)model
{
    _model=model;
    [self setViewData];
    
}

@end
