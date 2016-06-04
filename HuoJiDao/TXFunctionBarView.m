//
//  TXFunctionBarView.m
//  创建View虚线
//
//  Created by IOS开发 on 16/4/26.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXFunctionBarView.h"
#import "UMSocial.h"
@interface TXFunctionBarView()<TXTheDottedLineViewDelegate,UMSocialUIDelegate>
@end
@implementation TXFunctionBarView

-(void)setViewData
{
    
}
-(void)setViewFrame
{
    //通用
    CGFloat Y                   = 0;
    CGFloat W                   = self.frame.size.width/5;
    CGFloat H                   = self.frame.size.height;
    //点赞
    CGFloat thumbs_upViewX      = 0;
    _thumbs_upView.frame        = CGRectMake(thumbs_upViewX, Y, W, H);
    //点踩
    CGFloat treadViewX          = CGRectGetMaxX(_thumbs_upView.frame);
    _treadView.frame            = CGRectMake(treadViewX, Y, W, H);
    //收藏
    CGFloat collectionViewX     = CGRectGetMaxX(_treadView.frame);
    _collectionView.frame       = CGRectMake(collectionViewX, Y, W, H);
    //评论
    CGFloat commendViewX        = CGRectGetMaxX(_collectionView.frame);
    _commendView.frame          = CGRectMake(commendViewX, Y, W, H);
    
    //分享
    CGFloat shareViewX          = CGRectGetMaxX(_commendView.frame);
    _shareView.frame            = CGRectMake(shareViewX, Y, W, H);
    
}

-(void)drawRect:(CGRect)rect
{
    
    /******************************************
     *  注意：必须记住                          *
     *  init 初始化控件                        *
     *  drawRect:(CGRect)rect设置控件的位置    *
     *****************************************/
   
    [self setViewFrame];
    [self setViewData];
}
#pragma mark------------重写init方法-----------
-(instancetype)init
{
    if (self=[super init])
    {
        self.backgroundColor                    = [UIColor whiteColor];
        TXTheDottedLineView * thumbs_upView     = [[TXTheDottedLineView alloc]init];//点赞View
        thumbs_upView.delegate                  = self;
        
        _thumbs_upView                          = thumbs_upView;
        
        TXTheDottedLineView * treadView         = [[TXTheDottedLineView alloc]init];//点踩View
        treadView.delegate                      = self;
        _treadView=treadView;
        
        TXTheDottedLineView * collectionView    = [[TXTheDottedLineView alloc]init];//收藏View
        collectionView.delegate                 = self;
        _collectionView                         = collectionView;
        
        TXTheDottedLineView * commendView       = [[TXTheDottedLineView alloc]init];;//评论
        commendView.delegate                    = self;
        _commendView                            = commendView;
        
        TXTheDottedLineView * shareView         = [[TXTheDottedLineView alloc]init];;//分享
        shareView.delegate                      = self;
        _shareView                              = shareView;
        
        
        [self addSubview:thumbs_upView];
        [self addSubview:treadView];
        [self addSubview:collectionView];
        [self addSubview:commendView];
        [self addSubview:shareView];
        _thumbs_upView.icon.image               = [UIImage imageNamed:@"01点赞"];
        _treadView.icon.image                   = [UIImage imageNamed:@"02点踩"];
        _collectionView.icon.image              = [UIImage imageNamed: @"03收藏"];
        _commendView.icon.image                 = [UIImage imageNamed:@"04评论"];
        _shareView.icon.image                   = [UIImage imageNamed:@"05分享"];
        
        
        _thumbs_upView.but.tag                  = 0;
        _treadView.but.tag                      = 1;
        _collectionView.but.tag                 = 2;
        _commendView.but.tag                    = 3;
        _shareView.but.tag                      = 4;
        
        
        
        _thumbs_upView.label.text               = @"123";
        _treadView.label.text                   = @"426";
        _collectionView.label.text              = @"856";
        _commendView.label.text                 = @"566";
        _shareView.label.text                   = @"136";
        

    }
    return self;
}
-(void)theDottedLineView:(TXTheDottedLineView *)theDottedLineView Button:(UIButton *)but
{
    if (but.tag==0)
    {
        if (theDottedLineView.state==NO)
        {
           _thumbs_upView.icon.image = [UIImage imageNamed:@"0322_10"];
            theDottedLineView.state  = YES;
           
        }
        else if (theDottedLineView.state==YES)
        {
            _thumbs_upView.icon.image = [UIImage imageNamed:@"01点赞"];
            theDottedLineView.state   = NO;
        }
        
    }
    if (but.tag==1)
    {
        if (theDottedLineView.state==NO)
        {
           _treadView.icon.image    = [UIImage imageNamed:@"0322_13"];
            
            theDottedLineView.state = YES;
            
        }
        else if (theDottedLineView.state==YES)
        {
            _treadView.icon.image   = [UIImage imageNamed:@"02点踩"];
            theDottedLineView.state = NO;
        }

    }
    if (but.tag==2)
    {
        if (theDottedLineView.state==NO)
        {
            _collectionView.icon.image = [UIImage imageNamed:@"0322_15"];
            
            theDottedLineView.state = YES;
            
        }
        else if (theDottedLineView.state==YES)
        {
            _collectionView.icon.image = [UIImage imageNamed:@"03收藏"];
            theDottedLineView.state    = NO;
        }

    }
    if (but.tag==3)
    {
        if (theDottedLineView.state==NO)
        {
            _commendView.icon.image = [UIImage imageNamed:@"0322_17"];
            
            theDottedLineView.state = YES;
            
        }
        else if (theDottedLineView.state==YES)
        {
            _commendView.icon.image = [UIImage imageNamed:@"04评论"];
            theDottedLineView.state = NO;
        }

    }
    if (but.tag==4)
    {
        NSLog(@"分享");
        //如果需要分享回调，请将delegate对象设置self，并实现下面的回调方法
        [UMSocialSnsService presentSnsIconSheetView:self.getController
                                             appKey:AppKey
                                          shareText:@"友盟社会化分享让您快速实现分享等社会化功能，http://umeng.com/social"
                                         shareImage:[UIImage imageNamed:@"icon"]
                                    shareToSnsNames:@[UMShareToWechatSession,UMShareToQQ,UMShareToSina,UMShareToWechatTimeline,UMShareToQzone]
                                           delegate:self];
        
    }
}
-(void)setModel:(TXListModel *)model
{
    _model                          = model;
    _thumbs_upView.label.text       = _model.like;//点赞数
    _treadView.label.text           = _model.unlike;//点踩数
//    _collectionView.label.text    = _model.favnum;//收藏数
    _commendView.label.text         = _model.replynum;//评论数
//    _shareView.label.text         = @"122";//分享数
}
#pragma mark------------------友盟第三方分享回调------------------
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}
@end
