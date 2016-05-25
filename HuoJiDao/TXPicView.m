//
//  TXPicView.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/5/12.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXPicView.h"

@implementation TXPicView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)init
{
    if (self =[super init])
    {
        [self initView];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self=[super initWithFrame:frame])
    {
        [self initView];
    }
    return self;
}
-(void)initView
{
    UIImageView        * picImageView       = [[UIImageView alloc]init];
    _picImageView                           = picImageView;
    [self addSubview:picImageView];
}

-(void)setViewFrame
{
    CGFloat viewW                           = self.frame.size.width;
    CGFloat viewH                           = self.frame.size.height;
    
    CGFloat picImageViewX                   = 0;
    CGFloat picImageViewY                   = 0;
    CGFloat picImageViewW                   = viewW;
    CGFloat picImageViewH                   = viewH;
    _picImageView.frame                     = CM(picImageViewX, picImageViewY, picImageViewW, picImageViewH);
    
}
-(void)drawRect:(CGRect)rect
{
    [self setViewFrame];
}

@end
