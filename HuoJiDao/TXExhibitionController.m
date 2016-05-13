//
//  TXVideoExhibitionController.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/27.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXExhibitionController.h"
#import "AFNetworking.h"
#import "UIImage+GIF.h"
#import "TXTheDottedLineView.h"//功能条
#import "TXExhibitionDetailsView.h"//展示条
#import "TXDetailsTableVieewCell.h"
#import "TXCommentFrameModel.h"

@interface TXExhibitionController ()
<
UITableViewDelegate,UITableViewDataSource
>
{
    NSNotificationCenter                   * _notifiction;//通知中心
    UIView                                 * _myTableHeaderView;//_myTableHeaderView
    TXExhibitionDetailsView                * _exhibitionDetailsView;//添加在_myTableHeaderView上的详情View
    TXExhibitionDetailsViewFrameModel      * _frameModel;//详情View的FrameModel
    CGFloat                                  navigationViewH;//导航栏的高
    CGFloat                                  _playerH;//视频播放器的高
    NSMutableArray                         * _pinglunModel;//评论数据
    
}
@end

@implementation TXExhibitionController

#pragma mark------------------------屏幕旋转-------------------------
-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation))
    {
        NSLog(@"现在是竖屏");
        
        //设置导航栏
        //显示导航栏
        _exhibitionNavigationView.hidden=NO;
        //隐藏topImageView
        _player.maskView.topImageView.hidden=YES;
        
        //设置exhibitionNavigationView的Frame
        CGFloat exhibitionNavigationViewX=0;
        CGFloat exhibitionNavigationViewY=0;
        CGFloat exhibitionNavigationViewW=VIEW_WIDTH;
        CGFloat exhibitionNavigationViewH=navigationViewH;
        [_exhibitionNavigationView setFrame:CGRectMake(exhibitionNavigationViewX, exhibitionNavigationViewY, exhibitionNavigationViewW,exhibitionNavigationViewH )];
        //播放器的Frame
        CGFloat playerX=0;
        CGFloat playerY=0;
        CGFloat playerW=VIEW_WIDTH;
        CGFloat playerH=_playerH;
        [_player setFrame:CM(playerX, playerY,playerW , playerH)];
        //设置exhibitionDetailsView的Frame
        CGFloat exhibitionDetailsViewX=0;
        CGFloat exhibitionDetailsViewY=_playerH;
        CGFloat exhibitionDetailsViewW=self.view.frame.size.width;
        CGFloat exhibitionDetailsViewH=_frameModel.H;
        _exhibitionDetailsView.frame=CGRectMake(exhibitionDetailsViewX,exhibitionDetailsViewY,exhibitionDetailsViewW ,exhibitionDetailsViewH);
        //设置exhibitionTableView的Frame
        CGFloat exhibitionTableViewX=0;
        CGFloat exhibitionTableViewY=0;
        CGFloat exhibitionTableViewW=VIEW_WIDTH;
        CGFloat exhibitionTableViewH=VIEW_HEIGHT;
        [_exhibitionTableView setFrame:CM(exhibitionTableViewX,exhibitionTableViewY,exhibitionTableViewW, exhibitionTableViewH)];
        //设置tableHeaderView的Frame
        CGFloat myTableHeaderViewX=0;
        CGFloat myTableHeaderViewY=0;
        CGFloat myTableHeaderViewW=VIEW_WIDTH;
        CGFloat myTableHeaderViewH=_playerH+_frameModel.H;
        [_myTableHeaderView setFrame:CM(myTableHeaderViewX, myTableHeaderViewY,myTableHeaderViewW , myTableHeaderViewH)];
        //设置fullScreenBtn图标
        [_player.maskView.fullScreenBtn setImage:[UIImage imageNamed:@"最大化_icon"] forState:UIControlStateNormal];
    }
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation))
    {
        NSLog(@"现在是横屏");
        //设置导航栏
        //显示导航栏
        _exhibitionNavigationView.hidden=YES;
        //隐藏topImageView
        _player.maskView.topImageView.hidden=NO;
        //设置exhibitionNavigationViewX的Frame
        CGFloat exhibitionNavigationViewX=0;
        CGFloat exhibitionNavigationViewY=0;
        CGFloat exhibitionNavigationViewW=VIEW_WIDTH;
        CGFloat exhibitionNavigationViewH=navigationViewH;
        //设置exhibitionNavigationView的Frame
        [_exhibitionNavigationView setFrame:CGRectMake(exhibitionNavigationViewX, exhibitionNavigationViewY, exhibitionNavigationViewW, exhibitionNavigationViewH)];
        //设置player的Frame
        CGFloat playerX=0;
        CGFloat playerY=0;
        CGFloat playerW=VIEW_WIDTH;
        CGFloat playerH=VIEW_HEIGHT;
        [_player setFrame:CM(playerX, playerY,playerW , playerH)];
        _exhibitionDetailsView.frame=CGRectMake(0, CGRectGetMaxY(_player.frame), self.view.frame.size.width,_frameModel.H);
        //设置exhibitionDetailsView的Frame
        CGFloat exhibitionDetailsViewX=0;
        CGFloat exhibitionDetailsViewY=CGRectGetMaxY(_player.frame);
        CGFloat exhibitionDetailsViewW=self.view.frame.size.width;
        CGFloat exhibitionDetailsViewH=_frameModel.H;
        _exhibitionDetailsView.frame=CGRectMake(exhibitionDetailsViewX,exhibitionDetailsViewY,exhibitionDetailsViewW ,exhibitionDetailsViewH);
        //设置exhibitionTableView的Frame
        CGFloat exhibitionTableViewX=0;
        CGFloat exhibitionTableViewY=0;
        CGFloat exhibitionTableViewW=VIEW_WIDTH;
        CGFloat exhibitionTableViewH=VIEW_HEIGHT;
        [_exhibitionTableView setFrame:CM(exhibitionTableViewX, exhibitionTableViewY, exhibitionTableViewW, exhibitionTableViewH)];
        //设置tableHeaderView的Frame
        CGFloat myTableHeaderViewX=0;
        CGFloat myTableHeaderViewY=0;
        CGFloat myTableHeaderViewW=VIEW_WIDTH;
        CGFloat myTableHeaderViewH=VIEW_HEIGHT;
        [_myTableHeaderView setFrame:CM(myTableHeaderViewX, myTableHeaderViewY,myTableHeaderViewW , myTableHeaderViewH)];
        //设置fullScreenBtn的图标
        [_player.maskView.fullScreenBtn setImage:[UIImage imageNamed:@"最小化_icon"] forState:UIControlStateNormal];
    }
}
#pragma mark-----------------监听TableView的Row------------------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _pinglunModel.count;
}
#pragma mark-----------------监听TableView的Cell------------------
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //创建数据模型
    TXCommentFrameModel     * frameModel = _pinglunModel[indexPath.row];
    //创建cell
    TXDetailsTableVieewCell * cell       = [[TXDetailsTableVieewCell alloc]initWithTableView:tableView];
    
    //设置单元格的数据
    cell.frameModel                      = frameModel;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     TXCommentFrameModel * frameModel=_pinglunModel[indexPath.row];
    return frameModel.rowH;
}
#pragma mark---------------大播放按钮点击事件-------------------------
-(void)bigStartAction:(UIButton *)button
{
    _player.maskView.startBut.selected=!button.selected;
    button.selected = !button.selected;
   if (button.selected)
    {
        _player.isPauseByUser = NO;//播放状态标记
        _player.playState     = ZFPlayerStatePlaying;//播放中
        [_player.player play];//播放
        //大图标
        [button setImage:[UIImage imageNamed:@"big_暂停_icon"] forState:UIControlStateNormal];
        //小图标
        [_player.maskView.startBut setImage:[UIImage imageNamed:@"small_暂停_icon"] forState:UIControlStateNormal];
        //点击播放按钮后将player添加在self.view上
        [self.view addSubview:_player];
        [self.view addSubview:_exhibitionNavigationView];
    }
    else
    {
        _player.isPauseByUser = YES;//播放状态标记
        _player.playState     = ZFPlayerStatePause;//暂停中
         [_player.player pause];//暂停
        //播放中
        [button setImage:[UIImage imageNamed:@"big_播放_icon"] forState:UIControlStateNormal];
        [_player.maskView.startBut setImage:[UIImage imageNamed:@"small_播放_icon"] forState:UIControlStateNormal];
        //点击播放按钮后将videoExhibitionTableView添加在self.view上
        [_exhibitionTableView.tableHeaderView addSubview:_player];
        //将TableView置顶
        [_exhibitionTableView setContentOffset:CGPointMake(0,0) animated:YES];
    }

}
#pragma mark--------------小播放按钮点击事件----------------
-(void)smallStartAction:(NSNotification*)notification
{
    UIButton * button=notification.userInfo[@"button"];
    if (button.selected)
    {
        //点击播放按钮后将player添加在self.view上
        [self.view addSubview:_player];
        [self.view addSubview:_exhibitionNavigationView];
    }
}
#pragma mark---------------添加exhibitionDetailsView----------
-(void)addExhibitionDetailsView
{
    //设置Frame
    CGFloat exhibitionDetailsViewX=0;
    CGFloat exhibitionDetailsViewY=_playerH;
    CGFloat exhibitionDetailsViewW=self.view.frame.size.width;
    CGFloat exhibitionDetailsViewH=_frameModel.H;
    _exhibitionDetailsView.frame=CGRectMake(exhibitionDetailsViewX,exhibitionDetailsViewY ,exhibitionDetailsViewW,exhibitionDetailsViewH);
    _exhibitionDetailsView.frameModel=_frameModel;
    [self.exhibitionTableView.tableHeaderView addSubview:_exhibitionDetailsView];
}
#pragma mark---------------设置TableView的tableHeaderView-----------
-(void)setExhibitionTableViewWithHeaderView
{
    //设置位置
    CGFloat myTableHeaderViewX=0;
    CGFloat myTableHeaderViewY=0;
    CGFloat myTableHeaderViewW=self.view.frame.size.width;
    CGFloat myTableHeaderViewH=_playerH+_frameModel.H;
    _myTableHeaderView = [[UIView alloc]init];
    _myTableHeaderView.frame=CGRectMake(myTableHeaderViewX, myTableHeaderViewY, myTableHeaderViewW, myTableHeaderViewH);
    _myTableHeaderView.backgroundColor=Color(239, 239, 244, 1);
    _exhibitionTableView.tableHeaderView  =_myTableHeaderView;
}
#pragma mark--------------navigationView返回按钮--------------------
-(void)navigationViewBack:(UIButton*)button
{
    [self dismissViewControllerAnimated:NO completion:nil];
    if ([_model.type isEqualToString:@"video"])
    {
        _player.isPauseByUser = YES;//播放状态标记
        [_player.player pause];//暂停
        _player.playState     = ZFPlayerStateStopped;//暂停中
        [_pinglunModel removeAllObjects];//删除所有
    }
}

#pragma mark--------------viewDidLoad------------------------------
- (void)viewDidLoad
{
    [super viewDidLoad];
    /************************************************************************************************************
     **  注意：                                                                                                 **
     **  1.-(void)interfaceOrientation 该方法是强制将屏幕竖屏。(ARC情况下使用)。                                     **
     **  2.[UIApplication sharedApplication] 该方法是获取当前屏幕方向。                                            **
     **  3.-(void)willAnimateRotationToInterfaceOrientation: duration: 该方法是旋转方向 改变视图。                 **
     **  4.-(BOOL)shouldAutorotate 该方法用于判断用户是否可以旋转屏幕。                                              **
     **  5.-(UIInterfaceOrientationMask)supportedInterfaceOrientations 该方法 用于ViewController支持那些旋转方向。  **
     ************************************************************************************************************/
    //强制竖屏
    [self interfaceOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
    self.view.backgroundColor=[UIColor whiteColor];
}

#pragma mark--------------添加导航栏---------------------------------
-(void)setNavigationView
{
    //设置Frame
    CGFloat exhibitionNavigationViewX=0;
    CGFloat exhibitionNavigationViewY=0;
    CGFloat exhibitionNavigationViewW=self.view.frame.size.width;
    CGFloat exhibitionNavigationViewH=navigationViewH;
    _exhibitionNavigationView=[[TXExhibitionNavigationView alloc]initWithFrame:CM(exhibitionNavigationViewX, exhibitionNavigationViewY,exhibitionNavigationViewW,exhibitionNavigationViewH)];
    _exhibitionNavigationView.backgroundColor=[UIColor colorWithWhite:1 alpha:0];
    [_exhibitionNavigationView.backBut addTarget:self action:@selector(navigationViewBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_exhibitionNavigationView];
    
}

#pragma mark---------------添加VideoExhibitionTableView-------------
-(void)addExhibitionTableView
{
    //设置位置
    CGFloat viewW=self.view.frame.size.width;
    CGFloat viewH=self.view.frame.size.height;
    CGFloat exhibitionTableViewX=0;
    CGFloat exhibitionTableViewY=0;
    CGFloat exhibitionTableViewW=viewW;
    CGFloat exhibitionTableViewH=viewH;
    _exhibitionTableView=[[UITableView alloc]initWithFrame:CM(exhibitionTableViewX, exhibitionTableViewY, exhibitionTableViewW, exhibitionTableViewH) style:UITableViewStylePlain];
    _exhibitionTableView.separatorStyle = NO;//隐藏分割线
    _exhibitionTableView.delegate=self;
    _exhibitionTableView.dataSource=self;
    _exhibitionTableView.showsVerticalScrollIndicator=YES;
    _exhibitionTableView.showsHorizontalScrollIndicator=YES;
    [self.view addSubview:_exhibitionTableView];
    //设置exhibitionTableViewWithHeaderView
    [self setExhibitionTableViewWithHeaderView];
}
#pragma mark---------------创建MediaPlayer--------------------------
-(void)createMediaPlayer:(NSString*)strURL
{
    //添加TableView
    [self addExhibitionTableView];
    //设置导航条
    [self setNavigationView];
    
    //设置player的Frame
    CGFloat playerX=0;
    CGFloat playerY=0;
    CGFloat playerW=self.view.frame.size.width;
    CGFloat playerH=_playerH;
    _player=[[TXMediaPlayer alloc]initWithFrame:CGRectMake(playerX, playerY,playerW ,playerH)];
    //添加URL
    _player.videoURL=[NSURL URLWithString: strURL];
    //添加大播放按钮
    [_player.maskView.bigstartBut addTarget:self action:@selector(bigStartAction:) forControlEvents:UIControlEventTouchUpInside];
    //将player添加在tableHeaderView上
    [self.exhibitionTableView.tableHeaderView addSubview:_player];
    //调用添加详情View
    [self addExhibitionDetailsView];
    
   
}
#pragma mark----------------创建picView-----------------------
-(void)createPicView:(NSString *)strURL
{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //添加TableView
        [self addExhibitionTableView];
        //设置导航条
        [self setNavigationView];
        //设置picView的Frame
        CGFloat picViewX=0;
        CGFloat picViewY=0;
        CGFloat picViewW=self.view.frame.size.width;
        CGFloat picViewH=_playerH;
        _picView=[[TXPicView alloc]initWithFrame:CM(picViewX, picViewY, picViewW, picViewH)];
        
        
         //判断是否是pic 和 gif
        if ([_model.type isEqualToString:@"pic"])
        {
        [_picView.picImageView sd_setImageWithURL:[NSURL URLWithString:strURL]];
        }else if ([_model.type isEqualToString:@"gif"])
        {
            NSData * imageData=[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://img9.ph.126.net/ATRAnKXg_K2z_VS9ljqgVA==/1089871109841124969.gif"]];
            _picView.picImageView.image=[UIImage sd_animatedGIFWithData:imageData];
        }
        
        [self.exhibitionTableView.tableHeaderView addSubview:_picView];
        [self addExhibitionDetailsView];
    });
    
    
}

#pragma mark----------------请求video的数据--------------------
-(void)requestData:(NSString*)strURL
{
    NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager       * manager       = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURL                     * URL           = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.huojidao.com/PalyPage/%@",strURL]];
    
    NSURLRequest              * request       = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask      * dataTask      = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error)
                                                 {
                                                     if (error)
                                                     {
                                                         NSLog(@"Error: %@", error);
                                                     } else
                                                     {
                                                         //调用创建视频播放前器
                                                         [self createMediaPlayer:responseObject[@"data"][@"url"]];
                                                     }
                                                     
                                                 }];
    [dataTask resume];
    
}
#pragma mark----------------请求评论的数据--------------------
-(void)requestPingLunData:(NSString*)blogid
{
    
    NSMutableArray * muarray =[NSMutableArray array];
    NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager       * manager       = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL                     * URL           = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.huojidao.com/CommentPage/8811"]];
    
    NSURLRequest              * request       = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask      * dataTask      = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error)
                                                 {
                                                     if (error)
                                                     {
                                                         NSLog(@"Error: %@", error);
                                                     } else
                                                     {
                                                         
                                                         for (NSDictionary * dic in responseObject[@"data"])
                                                         {
                                                             TXCommentModel * model=[[TXCommentModel alloc]initWithDic:dic];
                                                             TXCommentFrameModel * frameModel=[[TXCommentFrameModel alloc]initWithModel:model];
                                                             [muarray addObject:frameModel];
                                                         }
                                                         _pinglunModel=muarray;
                                                         
                                                     }
                                                     
                                                 }];
    [dataTask resume];
    
}

#pragma mark--------------------核心---监听通知中心--------------------
-(void)gitModel:(NSNotification*)notification
{
    _model=notification.userInfo[@"model"];
    //创建详情View数据模型
    _frameModel=[[TXExhibitionDetailsViewFrameModel alloc]initWithModel:_model];
    _exhibitionDetailsView=[[TXExhibitionDetailsView alloc]init];
    
    //判断类型是否是Video
    if ([_model.type isEqualToString: @"video"])
    {
        [self requestData:_model.vid];
        [self requestPingLunData:_model.blogid];
    }
    //判断类型是否是pic 和 gif
    else if ([_model.type isEqualToString:@"pic"]||[_model.type isEqualToString:@"gif"])
    {
        [self createPicView:_model.img];
        [self requestPingLunData:_model.blogid];
    }
    
    
}
#pragma mark--------------------初始化变量----------------------
//父类的方法(初始化变量)
-(void)initVar
{
    navigationViewH = 64;
    _playerH        = 200;
}

#pragma mark--------------------初始化数据----------------------
/********************************************************
 **  创建通知中心接收消息                                 **
 **  1.@"video_Vid" 获取视频数据                        **
 **  2.@"small_startAction" 获取小按钮数据              **
 **                                                    **
 *******************************************************/
-(void)initData
{
    //创建通知中心
    _notifiction=[NSNotificationCenter defaultCenter];
    [_notifiction addObserver:self selector:@selector(gitModel:) name:@"gitModel" object:nil];
    [_notifiction addObserver:self selector:@selector(smallStartAction:) name:@"small_startAction" object:nil];
    
}
#pragma mark--------------强制转换屏幕方向------------------------
- (void)interfaceOrientation:(UIInterfaceOrientation)orientation
{
    // arc下
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)])
    {
        SEL selector             = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val                  = orientation;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}
#pragma mark--------------支持哪些转屏方向--------------
-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}
#pragma mark--------------是否支持屏幕旋转--------------
-(BOOL)shouldAutorotate
{
    //当只是vide的时候屏幕才能被旋转
    if ([_model.type isEqualToString: @"video"])
    {
        return YES;
    }
    return  NO;
}
-(void)dealloc
{
    NSLog(@"dealloc 被调用");
}

@end
