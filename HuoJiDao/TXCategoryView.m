//
//  TXCategoryView.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/15.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXCategoryView.h"
@interface TXCategoryView()
{
    UILabel * _allLabel;
    UILabel * _viewoLabel;
    UILabel * _pictureLabel;
    UILabel * _linkLabel;
}
@end
@implementation TXCategoryView
#pragma mark-----------------------点击事件----------------
-(void)CategoryViewButton:(UIButton*)sender
{
    switch (sender.tag)
    {
            case 0:
        {
            //NSLog(@"全部");
            if ([_delegate respondsToSelector:@selector(categoryView:AllBut:)])
            {
                [_delegate categoryView:self AllBut:_allBut];
            }
            
        }
            break;
            case 1:
        {
            //NSLog(@"视频");
            if ([_delegate respondsToSelector:@selector(categoryView: AllBut:)])
            {
                [_delegate categoryView:self VideoBut:_videoBut];
            }
        }
            break;
            case 2:
        {
            //NSLog(@"图片");
            if ([_delegate respondsToSelector:@selector(categoryView:PictureBut:)])
            {
                [_delegate categoryView:self PictureBut:_pictureBut];
            }
        }
            break;
            case 3:
        {
            //NSLog(@"链接");
            if ([_delegate respondsToSelector:@selector(categoryView: LinkBut:)])
            {
                [_delegate categoryView:self LinkBut:_linkBut];
            }
        }
        default:
            break;
    }
}
#pragma mark-----------------------设置视图数据----------------
-(void)setViewData
{
   
    //全部Button
    _allBut.tag                    = 0;
    [_allBut setImage:[UIImage imageNamed:@"全部"] forState:UIControlStateNormal];
    _allBut.layer.masksToBounds = YES; //是否显示圆角以外的部分
    [_allBut addTarget:self action:@selector(CategoryViewButton:) forControlEvents:UIControlEventTouchUpInside];
    
    //视频Button
    _videoBut.tag                    = 1;
    [_videoBut setImage:[UIImage imageNamed:@"视频"] forState:UIControlStateNormal];
    _videoBut.layer.masksToBounds=YES; //是否显示圆角以外的部分
    [_videoBut addTarget:self action:@selector(CategoryViewButton:) forControlEvents:UIControlEventTouchUpInside];
    //图片Button
    _pictureBut.tag                  = 2;
    [_pictureBut setImage:[UIImage imageNamed:@"图片"] forState:UIControlStateNormal];
    _pictureBut.layer.masksToBounds  = YES; //是否显示圆角以外的部分
    [_pictureBut addTarget:self action:@selector(CategoryViewButton:) forControlEvents:UIControlEventTouchUpInside];
    
    //链接Button
    _linkBut.tag                     = 3;
    [_linkBut setImage:[UIImage imageNamed:@"文章"] forState:UIControlStateNormal];
    _linkBut.layer.masksToBounds     =YES; //是否显示圆角以外的部分
    [_linkBut addTarget:self action:@selector(CategoryViewButton:) forControlEvents:UIControlEventTouchUpInside];
    
    //设置Label
//    UIColor             * textColor = [UIColor orangeColor];//同一设置颜色
    UIFont              * textFont  = [UIFont systemFontOfSize:12];
    
    _allLabel.text                = @"全部";
    _allLabel.textColor           = Color(241, 194, 56, 1);
    _allLabel.font                = textFont;
    _allLabel.textAlignment       = NSTextAlignmentCenter;
    
    _viewoLabel.text                = @"视频";
    _viewoLabel.textColor           = Color(157, 188, 240, 1);
    _viewoLabel.font                = textFont;
    _viewoLabel.textAlignment       = NSTextAlignmentCenter;
    
    
    _pictureLabel.text              = @"图片";
    _pictureLabel.textColor         = Color(118, 211, 168, 1);
    _pictureLabel.font              = textFont;
    _pictureLabel.textAlignment     = NSTextAlignmentCenter;
    
    
    _linkLabel.text                 = @"文章";
    _linkLabel.textColor            = Color(225, 189, 189, 1);
    _linkLabel.font                 = textFont;
    _linkLabel.textAlignment        = NSTextAlignmentCenter;
    
    
}
#pragma mark-----------------------设置视图框架----------------
-(void)setViewFrame
{
    CGFloat viewW                    = self.frame.size.width;
    CGFloat viewH                    = self.frame.size.height;
   
    
    int num=4;//button的个数
    CGFloat fillet=8;//圆角
    
    
    //全部Button
    CGFloat ButtonW_H                = 40;//Button 宽和高
    CGFloat ButtonY                  = 5;
    CGFloat allbutX                  = (viewW/num-ButtonW_H)/2;
    _allBut.layer.cornerRadius       = fillet;//圆角的半径
    _allBut.frame                    = CM(allbutX, ButtonY, ButtonW_H,ButtonW_H);
    //视频Button
    CGFloat videoButX                = CGRectGetMaxX(_allBut.frame)+(viewW/num-ButtonW_H);
    _videoBut.layer.cornerRadius     = fillet;//圆角的半径
    _videoBut.frame                  = CM(videoButX, ButtonY, ButtonW_H, ButtonW_H);
    //图片Button
    CGFloat pictureButX              = CGRectGetMaxX(_videoBut.frame)+(viewW/num-ButtonW_H);
    _pictureBut.layer.cornerRadius   = fillet;//圆角的半径
    _pictureBut.frame                = CM(pictureButX, ButtonY, ButtonW_H, ButtonW_H);
    //链接Button
    CGFloat linkButX                 = CGRectGetMaxX(_pictureBut.frame)+(viewW/num-ButtonW_H);
    _linkBut.layer.cornerRadius      = fillet;//圆角的半径
    _linkBut.frame                   = CM(linkButX, ButtonY, ButtonW_H, ButtonW_H);
    
    //Label位置
    CGFloat allLabelX                = allbutX;
    CGFloat allLabelY                = CGRectGetMaxY(_allBut.frame)-2;
    CGFloat allLabelW                = ButtonW_H;
    CGFloat allLabelH                = viewH-ButtonW_H;
    _allLabel.frame                  = CM(allLabelX,allLabelY,allLabelW , allLabelH);
    
    CGFloat viewoLabelX              = videoButX;
    CGFloat viewoLabelY              = CGRectGetMaxY(_videoBut.frame)-2;
    CGFloat viewoLabelW              = ButtonW_H;
    CGFloat viewoLabelH              = viewH-ButtonW_H;
    _viewoLabel.frame                = CM(viewoLabelX,viewoLabelY, viewoLabelW, viewoLabelH);
    
    CGFloat pictureLabelX            = pictureButX;
    CGFloat pictureLabelY            = CGRectGetMaxY(_pictureBut.frame)-2;
    CGFloat pictureLabelW            = ButtonW_H;
    CGFloat pictureLabelH            = viewH-ButtonW_H;
    _pictureLabel.frame              = CM(pictureLabelX, pictureLabelY,pictureLabelW, pictureLabelH);
    
    CGFloat linkLabelX               = linkButX;
    CGFloat linkLabelY               = CGRectGetMaxY(_linkBut.frame)-2;
    CGFloat linkLabelW               = ButtonW_H;
    CGFloat linkLabelH               = viewH-ButtonW_H;
    _linkLabel.frame                 = CM(linkLabelX, linkLabelY, linkLabelW, linkLabelH);
    [self setViewData];
}
#pragma mark-----------------------初始化视图----------------
-(void)initView
{
    //实例化Button
    _allBut             = [UIButton buttonWithType:UIButtonTypeCustom];
    _videoBut           = [UIButton buttonWithType:UIButtonTypeCustom];
    _pictureBut         = [UIButton buttonWithType:UIButtonTypeCustom];
    _linkBut            = [UIButton buttonWithType:UIButtonTypeCustom];
    //实例化Label
    _allLabel           = [[UILabel alloc]init];
    _viewoLabel         = [[UILabel alloc]init];
    _pictureLabel       = [[UILabel alloc]init];
    _linkLabel          = [[UILabel alloc]init];
    
    
    //添加视图
    [self addSubview:_allBut];
    [self addSubview:_videoBut];
    [self addSubview:_pictureBut];
    [self addSubview:_linkBut];
    
    [self addSubview:_allLabel];
    [self addSubview:_viewoLabel];
    [self addSubview:_pictureLabel];
    [self addSubview:_linkLabel];
    
}
#pragma mark-----------------------重写initWithFrame方法----------------
-(instancetype)initWithFrame:(CGRect)frame
{

    if (self =[super initWithFrame:frame])
    {
        /*************************************************
         **                                             **
         ** 注意程序加载的次序。可以准确的说可划分为三个层次    **
         **  1.初始化视图---initView                     **
         **  2.设置视图位置---setViewFrame                **
         **  3.设置视图数据---setViewData                 **
         **************************************************/
        [self initView];
        [self setViewFrame];
        [self setViewData];
        
        
    }
    return self;
}
@end
