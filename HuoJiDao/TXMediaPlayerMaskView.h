
#import <UIKit/UIKit.h>
#import "CFDanmakuView.h"
typedef NS_ENUM(NSInteger)
{
    display,//显示
    hide//隐藏
    
}navigationBarState;

@interface TXMediaPlayerMaskView :UIView

//获取该页的控制器
@property(nonatomic,strong)UIViewController         * getController;

//关闭显示导航条
@property(nonatomic,strong)UIButton                 * gestureBut;


#pragma mark-------------------顶部导航栏View-----------------
@property(nonatomic,strong)UIImageView              * topImageView;
@property(nonatomic,strong)UIButton                 * backBut;
@property(nonatomic,strong)UILabel                  * titleLabel;
//大播放按钮
@property(nonatomic,strong)UIButton                 * bigstartBut;
#pragma mark-------------------底部导航栏View-----------------
@property(nonatomic,strong)UIImageView              * bottomImageView;
//打开弹幕
@property(nonatomic,strong)UIButton                 * barrageBut;
//开始播放按钮
@property(nonatomic,strong)UIButton                 * startBut;
//当前播放时长label
@property (strong, nonatomic)UILabel                * currentTimeLabel;
//视频总时长label
@property (strong, nonatomic)UILabel                * totalTimeLabel;
//缓冲进度条
@property (strong, nonatomic)UIProgressView         * progressView;
//滑杆
@property (strong, nonatomic)UISlider               * videoSlider;
//全屏按钮
@property (strong, nonatomic)UIButton               * fullScreenBtn;
//系统菊花
@property (nonatomic,strong)UIActivityIndicatorView * activity;
//状态栏状态
@property(nonatomic,assign)navigationBarState       * barState;
@property (nonatomic,strong)NSTimer                 * timer;
@property (nonatomic,assign)BOOL                      state;
-(void)addTimer;
//弹幕View
@property(nonatomic,strong)CFDanmakuView * danmakuView;
@property(nonatomic,assign)CGFloat  totalLength;
@end
