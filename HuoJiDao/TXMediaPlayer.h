
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "TXMediaPlayerMaskView.h"


// 枚举值，包含水平移动方向和垂直移动方向
typedef NS_ENUM(NSInteger, PanDirection)
{
    PanDirectionHorizontalMoved, //横向移动
    PanDirectionVerticalMoved    //纵向移动
};

//播放器的几种状态
typedef NS_ENUM(NSInteger, ZFPlayerState)
{
    ZFPlayerStateBuffering,  //缓冲中
    ZFPlayerStatePlaying,    //播放中
    ZFPlayerStateStopped,    //停止播放
    ZFPlayerStatePause       //暂停播放
};

@interface TXMediaPlayer :UIView
/** 视频URL */
@property (nonatomic, strong) NSURL   *videoURL;

@property(nonatomic,strong)AVPlayer              * player;
@property(nonatomic,strong)AVPlayerItem          * playerItme;
@property(nonatomic,strong)AVPlayerLayer         * playerLayer;

@property(nonatomic,strong)TXMediaPlayerMaskView * maskView;

@property(nonatomic,assign)CGRect                  smallFrame;
@property(nonatomic,assign)CGRect                  bigFrame;

/** 定义一个实例变量，保存枚举值 */
@property (nonatomic, assign) PanDirection     panDirection;
@property(nonatomic,assign)   ZFPlayerState    playState;
//滑竿状态
@property(nonatomic,assign)   BOOL             isDragSlider;
/** 是否被用户暂停 */
@property (nonatomic,assign)  BOOL             isPauseByUser;
//全屏状态
@property(nonatomic,assign)   BOOL             isScreen;


@end



