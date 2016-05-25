//
//  TXCommentHeadView.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/5/13.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXCommentHeadView.h"

@implementation TXCommentHeadView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self =[super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
        
    }
    return self;
    
}
-(void)initView
{
    self.backgroundColor = [UIColor whiteColor];
    UIView  * view       = [[UIView alloc]init];
    view.backgroundColor = Color(228, 108, 159, 1);
    _view                = view;
    
    UILabel * numLabel   = [[UILabel alloc]init];
    numLabel.font        = [UIFont systemFontOfSize:14];
    _numLabel            = numLabel;
   
    [self addSubview:view];
    [self addSubview:numLabel];
}
-(void)drawRect:(CGRect)rect
{
    [self setViewFrame];
    
}

-(void)setViewFrame
{
    CGFloat viewH           = self.frame.size.height;
    CGFloat margin          = 10;
    CGFloat myViewX         = margin;
    CGFloat myViewY         = 0;
    CGFloat myViewW         = 2;
    CGFloat myViewH         = viewH;
    _view.frame             = CGRectMake(myViewX, myViewY, myViewW, myViewH);
    CGFloat numLabelX       = CGRectGetMaxX(_view.frame)+margin;
    CGFloat numLabelH       = 20;
    CGFloat numLabelY       = (viewH-numLabelH)/2;
    CGFloat numLabelW       = 100;
     _numLabel.frame        = CGRectMake(numLabelX, numLabelY, numLabelW, numLabelH);
    
}

-(void)setNum:(int)num
{
    _num = num;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.00001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _numLabel.text=[NSString stringWithFormat:@"评论 %i",_num];
    });
}
@end
