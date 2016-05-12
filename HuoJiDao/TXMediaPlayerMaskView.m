

#import "TXMediaPlayerMaskView.h"
#import <AVFoundation/AVFoundation.h>

@interface TXMediaPlayerMaskView ()


@end

@implementation TXMediaPlayerMaskView
-(void)addTimer
{
    _timer=[NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(removeTop_bottom_View:) userInfo:nil repeats:YES];
}
-(void)removeTop_bottom_View:(NSTimer*)timer
{
    
    
    [UIView animateWithDuration:0.3 animations:^
     {
         _topImageView.alpha    = 0;
         _bottomImageView.alpha = 0;
         _bigstartBut.alpha=0;
         
         [_timer invalidate];//暂停timer
         _timer=nil;//清空timer
         _state=hide;
     }];
    
    NSLog(@"被掉用");
    
    
}
-(void)addTop_bottom_ViewGesture:(UIButton*)button
{
    
    //判断显示 如果是显示就让其隐藏
    if (_state==display)
    {
        
        [UIView animateWithDuration:0.3 animations:^
         {
             _topImageView.alpha    = 0;
             _bottomImageView.alpha = 0;
             _bigstartBut.alpha=0;
             _state=hide;
             [_timer invalidate];
             _timer=nil;
             NSLog(@"移除定时器");
             
         }];
        
    }
    //判断隐藏 如果是隐藏就让其显示
    else if (_state==hide)
    {
        [UIView animateWithDuration:0.3 animations:^
         {
             _topImageView.alpha    = 1;
             _bottomImageView.alpha = 1;
             _bigstartBut.alpha=1;
             _state=display;
             [self addTimer];
             NSLog(@"添加定时器");
         }];
        
        
    }
    
}
-(void)setViewFrame
{
    
    CGFloat viewW=self.frame.size.width;
    CGFloat viewH=self.frame.size.height;
    
    CGFloat gestureX=0;
    CGFloat gestureY=0;
    CGFloat gestureW=viewW;
    CGFloat gestureH=viewH;
    _gestureBut.frame=CGRectMake(gestureX, gestureY, gestureW, gestureH);
    
    CGFloat topViewX=0;
    CGFloat topViewY=0;
    CGFloat topViewW=viewW;
    CGFloat topViewH=30;
    _topImageView.frame=CGRectMake(topViewX, topViewY, topViewW, topViewH);

    

    //返回
    CGFloat backX                = 15;
    CGFloat backW_H              = 20;
    CGFloat backY                = (_topImageView.frame.size.height-backW_H)/2;
    _backBut.frame               = CM(backX, backY, backW_H, backW_H);
    
    CGFloat titleLabW            = 100;
    CGFloat titleLabX            = _topImageView.frame.size.width/2-titleLabW/2;
    CGFloat titleLabY            = backY;
    CGFloat titleLabH            = 30;
    _titleLabel.frame            = CM(titleLabX, titleLabY, titleLabW, titleLabH);
    
    
    
    
    //大播放按钮的Frame
    CGFloat bigstartButW_H=50;
    CGFloat bigstartButX=(viewW-bigstartButW_H)/2;
    
    CGFloat bigstartButY=(viewH-bigstartButW_H)/2;
    _bigstartBut.frame=CGRectMake(bigstartButX, bigstartButY, bigstartButW_H, bigstartButW_H);
    
    
    
    
    CGFloat bottomViewX=0;
    CGFloat bottomViewH=30;
    CGFloat bottomViewW=viewW;
    CGFloat bottomViewY=viewH-bottomViewH;
    _bottomImageView.frame=CGRectMake(bottomViewX, bottomViewY, bottomViewW, bottomViewH);
    
    
    
    CGFloat margin=15;
    
    CGFloat  butW_H=20;
    CGFloat  butY=(bottomViewH-butW_H)/2;
    
    CGFloat  openBarrageButW=20;
    CGFloat  openBarrageButH=15;
    CGFloat  openBarrageButY=(bottomViewH-openBarrageButH)/2;
    CGFloat  openBarrageButX=margin;
    
    _openBarrageBut.frame=CGRectMake(openBarrageButX, openBarrageButY, openBarrageButW, openBarrageButH);
    
    CGFloat startButX=CGRectGetMaxX(_openBarrageBut.frame)+margin;
    CGFloat startButW_H=butW_H;
    _startBut.frame=CGRectMake(startButX, butY, startButW_H, startButW_H);
    
    CGFloat currentTimeLabelX=CGRectGetMaxX(_startBut.frame)+margin;
    CGFloat currentTimeLabelW=40;
    CGFloat currentTimeLabelH=butW_H;
    _currentTimeLabel.frame=CGRectMake(currentTimeLabelX, butY, currentTimeLabelW, currentTimeLabelH);
    
    CGFloat progressViewX=CGRectGetMaxX(_currentTimeLabel.frame)+margin;
    
    CGFloat progressViewH=1;
    CGFloat progressViewY=bottomViewH/2-progressViewH;
    
    CGFloat progressViewW=viewW-CGRectGetMaxX(_currentTimeLabel.frame) -margin-currentTimeLabelW-margin-butW_H-margin*2;
    _progressView.frame=CGRectMake(progressViewX, progressViewY, progressViewW, progressViewH);
    
    CGFloat videoSliderX=progressViewX;
    CGFloat videoSliderH=20
    ;
    CGFloat videoSliderY=(bottomViewH-videoSliderH)/2;
    CGFloat videoSliderW=progressViewW;
    _videoSlider.frame=CGRectMake(videoSliderX, videoSliderY, videoSliderW, videoSliderH);
    
    
    CGFloat totalTimeLabelX=CGRectGetMaxX(_videoSlider.frame)+margin;
    CGFloat totalTimeLabelY=butY;
    CGFloat totalTimeLabelW=currentTimeLabelW;
    CGFloat totalTimeLabelH=currentTimeLabelH;
    _totalTimeLabel.frame=CGRectMake(totalTimeLabelX, totalTimeLabelY, totalTimeLabelW, totalTimeLabelH);
    CGFloat fullScreenBtnX=CGRectGetMaxX(_totalTimeLabel.frame)+margin;
    _fullScreenBtn.frame=CGRectMake(fullScreenBtnX, butY, butW_H, butW_H);
    
    _activity.frame=CGRectMake(viewW/2-30, viewH/2-30, 30, 30);
    
   
    
}
#pragma mark----------------获取该页控制器---------------
-(UIViewController*)getController
{
    id controller  = [self nextResponder];
    while (![controller isKindOfClass:[UIViewController class]]&&controller!=nil)
    {
        controller = [controller nextResponder];
    }
    UIViewController  * mainController=(UIViewController*)controller;
    return mainController;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [self setViewFrame];
    
}
-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame])
    {
        
        //显示关闭导航条
        UIButton    *gestureBut=[[UIButton alloc]init];
        [gestureBut addTarget:self action:@selector(addTop_bottom_ViewGesture:) forControlEvents:UIControlEventTouchUpInside];
        _gestureBut=gestureBut;
        
        
        
        UIColor     * backgroundColor       = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.3];
        //实例化头部View
        UIImageView * topImageView          = [[UIImageView alloc]init];
        topImageView.hidden=YES;
        topImageView.backgroundColor        = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0];
        topImageView.userInteractionEnabled = YES;
        
        _topImageView         = topImageView;
        
        UIButton * backBut    = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBut setImage:[UIImage imageNamed:@"back-2"] forState:UIControlStateNormal];
        
        _backBut=backBut;
        
        UILabel  * titleLabel = [[UILabel alloc]init];
        _titleLabel           = titleLabel;
        
        //大播放按钮
        UIButton * bigstartBut=[UIButton buttonWithType:UIButtonTypeCustom];
        [bigstartBut setImage:[UIImage imageNamed:@"big_播放_icon"] forState:UIControlStateNormal];
        _bigstartBut=bigstartBut;
        
        //实例化底部View
        UIImageView  * bottomImageView         = [[UIImageView alloc]init];
        bottomImageView.backgroundColor        = backgroundColor;
        bottomImageView.userInteractionEnabled = YES;
        _bottomImageView                       = bottomImageView;
        
        //打开弹幕
        UIButton                 * openBarrageBut=[UIButton buttonWithType:UIButtonTypeCustom];
        [openBarrageBut setImage:[UIImage imageNamed:@"弹幕-1"] forState:UIControlStateNormal];
      
        
        
        _openBarrageBut=openBarrageBut;
        
        
        //开始播放按钮
        UIButton                 * startBut=[UIButton buttonWithType:UIButtonTypeCustom];
        [startBut setImage:[UIImage imageNamed:@"small_播放_icon"] forState:UIControlStateNormal];
        
        _startBut=startBut;

        
        UIColor * textColor=[UIColor whiteColor];
        UIFont  * textFont=[UIFont systemFontOfSize:14];
        
        //当前播放时长label
        UILabel                  * currentTimeLabel=[[UILabel alloc]init];
        currentTimeLabel.text=@"00:00";
        currentTimeLabel.textColor = textColor;
        currentTimeLabel.textAlignment=NSTextAlignmentCenter;
        currentTimeLabel.font=textFont;
        
        _currentTimeLabel=currentTimeLabel;
        //视频总时长label
        UILabel                  * totalTimeLabel=[[UILabel alloc]init];
        totalTimeLabel.text=@"00:00";
        totalTimeLabel.textAlignment=NSTextAlignmentCenter;
        totalTimeLabel.textColor=textColor;
        totalTimeLabel.font=textFont;
        
        _totalTimeLabel=totalTimeLabel;
        //缓冲进度条
        UIProgressView           * progressView=[[UIProgressView alloc]init];
        _progressView=progressView;
        //滑杆
        UISlider                 * videoSlider=[[UISlider alloc]init];
        [videoSlider setThumbImage:[UIImage imageNamed:@"slider"] forState:UIControlStateNormal];
        
        videoSlider.minimumTrackTintColor = [UIColor whiteColor];
        videoSlider.maximumTrackTintColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.3];
        _videoSlider=videoSlider;
        
        //全屏按钮
        UIButton                 * fullScreenBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [fullScreenBtn setImage:[UIImage imageNamed:@"最大化_icon"] forState:UIControlStateNormal];
        
        _fullScreenBtn=fullScreenBtn;
        //系统菊花
        UIActivityIndicatorView  * activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _activity=activity;
        
        
        //添加显示关闭导航条BUtton
        [self addSubview:gestureBut];
        //添加头部导航条
        [self addSubview:topImageView];
        
        [topImageView addSubview:backBut];
        [topImageView addSubview:titleLabel];
        
        //添加大播放按钮
        [self addSubview:bigstartBut];
        
        //添加底部导航条
        [self addSubview:bottomImageView];
        
        [bottomImageView addSubview:openBarrageBut];
        [bottomImageView addSubview:startBut];
        [bottomImageView addSubview:currentTimeLabel];
        [bottomImageView addSubview:totalTimeLabel];
        [bottomImageView addSubview:progressView];
        [bottomImageView addSubview:videoSlider];
        [bottomImageView addSubview:fullScreenBtn];
        //添加菊花
        [self addSubview:activity];
        //设置监听导航条显示状态
         _state=display;
        [self addTimer];
        
    }
    return self;
}


@end
