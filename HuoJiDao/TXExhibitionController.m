//
//  TXVideoExhibitionController.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/27.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXExhibitionController.h"


typedef NS_ENUM(NSInteger, Direction)
{
   Vertical_screen,//竖屏
   Cross_screen,//横屏
    
};
@interface TXExhibitionController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSNotificationCenter                   * _notifiction;//通知中心
    UIView                                 * _myTableHeaderView;//_myTableHeaderView
    TXSendABarrageView                     * _sendABarrageView;//发送View
    TXExhibitionDetailsView                * _exhibitionDetailsView;//添加在_myTableHeaderView上的详情View
    TXCommentHeadView                      * _commentHeadView;//CommentHeadView评论组头部View
    
    TXExhibitionDetailsViewFrameModel      * _frameModel;//详情View的FrameModel
    CGFloat                                  _navigationViewH;//导航栏的高
    CGFloat                                  _playerH;//视频播放器的高
    CGFloat                                  _sectionHeader;//组头部的高
    NSMutableArray                         * _pinglunModel;//评论数据
    Direction                              * direction;//横竖屏的枚举
    BOOL                                     _isDirection;//横竖屏
    
   
}
@end
@implementation TXExhibitionController

#pragma mark+++++++++++++++++初始化数据+++++++++++++++++
/********************************************************
 **  创建通知中心接收消息                                 **
 **  1.@"gitModel" 获取数据                             **
 **  2.@"small_startAction" 获取小按钮数据               **
 **                                                    **
 *******************************************************/
-(void)initData
{
    //创建通知中心
    _notifiction=[NSNotificationCenter defaultCenter];
    [_notifiction addObserver:self selector:@selector(gitModel:) name:@"gitModel" object:nil];
    [_notifiction addObserver:self selector:@selector(smallStartAction:) name:@"small_startAction" object:nil];
    // app进入前台
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterPlayGround) name:UIApplicationDidBecomeActiveNotification object:nil];
    
}
#pragma mark+++++++++++++++++初始化变量+++++++++++++++++
-(void)initVar
{
    _navigationViewH = 64;//导航栏的高
    _playerH         = 200;//播放器的高
    _sectionHeader   = 20;//组头部View的高
    _isDirection     = Vertical_screen;//竖屏
}

#pragma mark+++++++++++++++++通知中心+++++++++++++++++
-(void)gitModel:(NSNotification*)notification
{
    _model                 = notification.userInfo[@"model"];
    //创建详情View数据模型
    _frameModel            = [[TXExhibitionDetailsViewFrameModel alloc]initWithModel:_model];
    _exhibitionDetailsView = [[TXExhibitionDetailsView alloc]init];
    //判断类型是否是Video
    if ([_model.type isEqualToString: @"video"])
    {
        [self requestDataWithStrURL:_model.vid];
        [self requestPingLunDataWithBlogid:_model.blogid];
    }
    //判断类型是否是pic 和 gif
    else if ([_model.type isEqualToString:@"pic"]||[_model.type isEqualToString:@"gif"])
    {
        [self createPicViewWithStrURL:_model.img];
        [self requestPingLunDataWithBlogid:_model.blogid];
    }
    
    
}


#pragma mark=============设置导航栏========================
-(void)setNavigationView
{
    //设置Frame
    CGFloat exhibitionNavigationViewX         = 0;
    CGFloat exhibitionNavigationViewY         = 0;
    CGFloat exhibitionNavigationViewW         = self.view.frame.size.width;
    CGFloat exhibitionNavigationViewH         = _navigationViewH;
    _exhibitionNavigationView                 = [[TXExhibitionNavigationView alloc]initWithFrame:CM(exhibitionNavigationViewX, exhibitionNavigationViewY,exhibitionNavigationViewW,exhibitionNavigationViewH)];
    _exhibitionNavigationView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
    [_exhibitionNavigationView.backBut addTarget:self action:@selector(navigationViewBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_exhibitionNavigationView];
    _exhibitionNavigationView.but.alpha       = 0;
    [_exhibitionNavigationView.but addTarget:self action:@selector(startAction:) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark=============viewDidLoad===================
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor                 = [UIColor whiteColor];
    [self interfaceOrientation:[[UIApplication sharedApplication] statusBarOrientation]];//强制竖屏
    
}


#pragma mark=============添加ExhibitionTableView=============
-(void)addExhibitionTableView
{
    //设置位置
    CGFloat viewW                             = self.view.frame.size.width;
    CGFloat viewH                             = self.view.frame.size.height;
    CGFloat exhibitionTableViewX              = 0;
    CGFloat exhibitionTableViewY              = 0;
    CGFloat exhibitionTableViewW              = viewW;
    CGFloat exhibitionTableViewH              = viewH;
    _exhibitionTableView                      = [[UITableView alloc]initWithFrame:CM(exhibitionTableViewX, exhibitionTableViewY, exhibitionTableViewW, exhibitionTableViewH) style:UITableViewStyleGrouped];
    _exhibitionTableView.separatorStyle       = NO;//隐藏分割线
    _exhibitionTableView.delegate             = self;
    _exhibitionTableView.dataSource           = self;
    _exhibitionTableView.showsVerticalScrollIndicator   = YES;
    _exhibitionTableView.showsHorizontalScrollIndicator = YES;
    _exhibitionTableView.tag                            = 0;
    [self.view addSubview:_exhibitionTableView];
    //设置exhibitionTableViewWithHeaderView
    [self setExhibitionTableViewWithHeaderView];
}
#pragma mark=============设置TableView的tableHeaderView=======
-(void)setExhibitionTableViewWithHeaderView
{
    //设置位置
    CGFloat myTableHeaderViewX               = 0;
    CGFloat myTableHeaderViewY               = 0;
    CGFloat myTableHeaderViewW               = self.view.frame.size.width;
    CGFloat myTableHeaderViewH               = _playerH+_frameModel.H;
    _myTableHeaderView                       = [[UIView alloc]init];
    _myTableHeaderView.frame                 = CGRectMake(myTableHeaderViewX, myTableHeaderViewY, myTableHeaderViewW, myTableHeaderViewH);
    _myTableHeaderView.backgroundColor       = Color(239, 239, 244, 1);
    _exhibitionTableView.tableHeaderView     = _myTableHeaderView;
}
#pragma mark=============创建MediaPlayer=============
-(void)createMediaPlayer:(NSString*)strURL
{
    [self addExhibitionTableView];//添加TableView
    [self setNavigationView];//设置导航条
    //设置player的Frame
    CGFloat playerX                         = 0;
    CGFloat playerY                         = 0;
    CGFloat playerW                         = self.view.frame.size.width;
    CGFloat playerH                         = _playerH;
    _player                                 = [[TXMediaPlayer alloc]initWithFrame:CGRectMake(playerX, playerY,playerW ,playerH)];
    _player.videoURL                        = [NSURL URLWithString: strURL];//添加URL
    [_player.maskView.bigstartBut addTarget:self action:@selector(bigStartAction:) forControlEvents:UIControlEventTouchUpInside];//添加大播放按钮
    [self.exhibitionTableView.tableHeaderView addSubview:_player];//将player添加在tableHeaderView上
    [self addExhibitionDetailsView];//调用添加详情View
    [self setupDanmakuData];//弹幕数据源
    [self createSendABarrageView];//创建发送弹幕View
}
#pragma mark=============创建SendABarrageView=============
-(void)createSendABarrageView
{
    CGFloat viewW                   = self.view.frame.size.width;
    CGFloat sendABarrageViewX       = 0;
    CGFloat sendABarrageViewY       = _playerH;
    CGFloat sendABarrageViewW       = viewW;
    CGFloat sendABarrageViewH       = 40;
    _sendABarrageView               = [[TXSendABarrageView alloc]init];
     _sendABarrageView.frame        = CM(sendABarrageViewX, sendABarrageViewY, sendABarrageViewW, sendABarrageViewH);
    _sendABarrageView.textField.placeholder = @"一起填充弹幕吧(( ^_^ ))";
    [_sendABarrageView.sendBut addTarget:self action:@selector(sendBut:) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark=============创建picView=============
-(void)createPicViewWithStrURL:(NSString *)strURL
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
                   {
                       
                       [self addExhibitionTableView];//添加TableView
                       [self setNavigationView];//设置导航条
                       
                       //设置picView的Frame
                       CGFloat picViewX            = 0;
                       CGFloat picViewY            = 0;
                       CGFloat picViewW            = self.view.frame.size.width;
                       CGFloat picViewH            = _playerH;
                       _picView                    =[[TXPicView alloc]initWithFrame:CM(picViewX, picViewY, picViewW, picViewH)];
                       
                       //判断是否是pic和gif
                       if ([_model.type isEqualToString:@"pic"])
                       {
                           [_picView.picImageView sd_setImageWithURL:[NSURL URLWithString:strURL]];
                       }else if ([_model.type isEqualToString:@"gif"])
                       {
                           NSData * imageData=[NSData dataWithContentsOfURL:[NSURL URLWithString:_model.link]];
                           _picView.picImageView.image=[UIImage sd_animatedGIFWithData:imageData];
                       }
                       [self.exhibitionTableView.tableHeaderView addSubview:_picView];
                       [self addExhibitionDetailsView];
                   });
    
    
}
#pragma mark=============添加exhibitionDetailsView=========
-(void)addExhibitionDetailsView
{
    //设置Frame
    CGFloat exhibitionDetailsViewX             = 0;
    CGFloat exhibitionDetailsViewY             = _playerH;
    CGFloat exhibitionDetailsViewW             = self.view.frame.size.width;
    CGFloat exhibitionDetailsViewH             = _frameModel.H;
    _exhibitionDetailsView.frame               = CGRectMake(exhibitionDetailsViewX,exhibitionDetailsViewY ,exhibitionDetailsViewW,exhibitionDetailsViewH);
    _exhibitionDetailsView.frameModel          = _frameModel;
    [self.exhibitionTableView.tableHeaderView addSubview:_exhibitionDetailsView];
}

#pragma mark==================监听TableView的Row================
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _pinglunModel.count;
}
#pragma mark==================监听TableView的Cell===============
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
#pragma mark==================监听HeadersView的高===============
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     TXCommentFrameModel    * frameModel = _pinglunModel[indexPath.row];
    return frameModel.rowH;
}
#pragma mark==================监听HeaderInSectionView===============
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    _commentHeadView                    = [[TXCommentHeadView alloc]initWithFrame:CM(0, 0, 0, _sectionHeader)];
    _commentHeadView.num                = (int)_pinglunModel.count;
    return _commentHeadView;
}
#pragma mark==================监听HeaderInSectionView的高===============
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return _sectionHeader;
}
//播放
-(void)myPlay
{
    _player.isPauseByUser = NO;//播放状态标记
    _player.playState     = ZFPlayerStatePlaying;//播放中
    [_player.player play];//播放
}
//暂停
-(void)myPause
{
    _player.isPauseByUser = YES;//播放状态标记
    _player.playState     = ZFPlayerStatePause;//暂停中
    [_player.player pause];//暂停
}
//按钮暂停状态的图标
-(void)buttonIconPause
{
    [_player.maskView.bigstartBut setImage:[UIImage imageNamed:@"big_暂停_icon"] forState:UIControlStateNormal];
    [_player.maskView.startBut setImage:[UIImage imageNamed:@"small_暂停_icon"] forState:UIControlStateNormal];
}
//按钮播放状态的图标
-(void)buttonIconPlay
{
    [_player.maskView.bigstartBut setImage:[UIImage imageNamed:@"big_播放_icon"] forState:UIControlStateNormal];
    [_player.maskView.startBut setImage:[UIImage imageNamed:@"small_播放_icon"] forState:UIControlStateNormal];

}
#pragma mark---------------导航栏返回按钮--------------------
/*********************************注意返回时请清除缓存。*********************************/
-(void)navigationViewBack:(UIButton*)button
{
    if ([_model.type isEqualToString:@"video"])
    {
        _player.isPauseByUser = YES;//播放状态标记
        [_player.player pause];//暂停
        _player.playState     = ZFPlayerStatePause;//暂停中
        [_pinglunModel removeAllObjects];//删除所有
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark---------------导航栏播放按钮------------
-(void)startAction:(UIButton*)button
{
    
    //改变播放按钮状态
    _player.maskView.startBut.selected    = !button.selected;
    _player.maskView.bigstartBut.selected = !button.selected;
    if ( _player.maskView.bigstartBut.selected)
    {
        [_exhibitionTableView setContentOffset:CGPointMake(0,0) animated:YES];
        [self myPlay];
        [self buttonIconPause];
        //点击播放按钮后将player添加在self.view上
        [self.view addSubview:_player];
        [self.view addSubview:_exhibitionNavigationView];
        _exhibitionNavigationView.backgroundColor = Color(90,179, 240, 0);
        _exhibitionNavigationView.but.alpha       = 0;
        //发送弹幕View
        [self.view addSubview:_sendABarrageView];
    }
}

#pragma mark---------------大播放按钮点击事件-------------------------
-(void)bigStartAction:(UIButton *)button
{
    _player.maskView.startBut.selected = !button.selected;
    button.selected                    = !button.selected;
   if (button.selected)
    {
        [self myPlay];
        [self buttonIconPause];
        //点击播放按钮后将player添加在self.view上
        [self.view addSubview:_player];
        [self.view addSubview:_exhibitionNavigationView];
        [self.player.maskView.danmakuView start];
        
        //发送弹幕View
        [self.view addSubview:_sendABarrageView];
    }
    else
    {
        [self myPause];//暂停
        [self buttonIconPlay];//按钮播放状态的图标
        if (_isDirection==Vertical_screen)
        {
            //点击播放按钮后将videoExhibitionTableView添加在self.view上
            [_exhibitionTableView.tableHeaderView addSubview:_player];
            if (_exhibitionTableView.contentOffset.y>0)
            {
                  [_exhibitionTableView setContentOffset:CGPointMake(0,_playerH-_navigationViewH+40) animated:YES];
            }
           //发送弹幕View
            [self.exhibitionTableView.tableHeaderView addSubview:_sendABarrageView];
        }
        
        
    }
}
#pragma mark---------------小播放按钮点击事件----------------
-(void)smallStartAction:(NSNotification*)notification
{
    UIButton * button=notification.userInfo[@"button"];
   
    if (button.selected)
    {
        //点击播放按钮后将player添加在self.view上
        [self.view addSubview:_player];
        [self.view addSubview:_exhibitionNavigationView];
        
        //发送弹幕View
        [self.view addSubview:_sendABarrageView];
    }else
    {
    
        if (_isDirection==Vertical_screen)
        {
            //点击播放按钮后将videoExhibitionTableView添加在self.view上
            [_exhibitionTableView.tableHeaderView addSubview:_player];
        }
        if (_isDirection==Vertical_screen)
        {
            if (_exhibitionTableView.contentOffset.y>0)
            {
                [_exhibitionTableView setContentOffset:CGPointMake(0,_playerH-_navigationViewH+40) animated:YES];
            }
            //发送弹幕View
            [self.exhibitionTableView.tableHeaderView addSubview:_sendABarrageView];
        }

    }
}
#pragma mark---------------scrollView滑动事件 -------------------
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
        CGFloat  a=scrollView.contentOffset.y/(_playerH-_navigationViewH);
        if (_player.isPauseByUser==YES)
        {
            _exhibitionNavigationView.backgroundColor=Color(90,179, 240, a);
            _exhibitionNavigationView.but.alpha=a;
        }
}

#pragma mark+++++++++++++++++请求video的数据+++++++++++++++++
-(void)requestDataWithStrURL:(NSString*)strURL
{
    NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager       * manager       = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURL                     * URL           = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@/%@-%@",ShiPin_Vid_URL,strURL,APP_ID,APP_KEY]];
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
#pragma mark+++++++++++++++++请求评论的数据+++++++++++++++++
-(void)requestPingLunDataWithBlogid:(NSString*)blogid
{
    NSMutableArray * muarray =[NSMutableArray array];
    NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager       * manager       = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURL                     * URL           = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@/%@-%@",PingLun_blogID_URL,blogid,APP_ID,APP_KEY]];
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


/************************************************************************************************************
 **  注意：                                                                                                 **
 **  1.-(void)interfaceOrientation 该方法是强制将屏幕竖屏。(ARC情况下使用)。                                     **
 **  2.[UIApplication sharedApplication] 该方法是获取当前屏幕方向。                                            **
 **  3.-(void)willAnimateRotationToInterfaceOrientation: duration: 该方法是旋转方向 改变视图。                 **
 **  4.-(BOOL)shouldAutorotate 该方法用于判断用户是否可以旋转屏幕。                                              **
 **  5.-(UIInterfaceOrientationMask)supportedInterfaceOrientations 该方法 用于ViewController支持那些旋转方向。  **
 ************************************************************************************************************/
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
    //当只是vide的时候屏幕才有可能被旋转
    if ([_model.type isEqualToString: @"video"])
    {
        return YES;
    }
    return  NO;
}
#pragma mark--------------屏幕旋转--------------
-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation))
    {
        NSLog(@"现在是竖屏");
        _isDirection                          = Vertical_screen;//竖屏
        _exhibitionNavigationView.hidden      = NO;//显示导航栏
        _player.maskView.topImageView.hidden  = YES;//隐藏topImageView
        //设置exhibitionNavigationView的Frame
        CGFloat exhibitionNavigationViewX     = 0;
        CGFloat exhibitionNavigationViewY     = 0;
        CGFloat exhibitionNavigationViewW     = self.view.frame.size.width;
        CGFloat exhibitionNavigationViewH     = _navigationViewH;
        [_exhibitionNavigationView setFrame:CGRectMake(exhibitionNavigationViewX, exhibitionNavigationViewY, exhibitionNavigationViewW,exhibitionNavigationViewH )];
        //播放器的Frame
        CGFloat playerX                       = 0;
        CGFloat playerY                       = 0;
        CGFloat playerW                       = self.view.frame.size.width;
        CGFloat playerH                       = _playerH;
        [_player setFrame:CM(playerX, playerY,playerW , playerH)];
        //exhibitionTableView的Frame
        CGFloat exhibitionTableViewX          = 0;
        CGFloat exhibitionTableViewY          = 0;
        CGFloat exhibitionTableViewW          = self.view.frame.size.width;
        CGFloat exhibitionTableViewH          = self.view.frame.size.height;
        [_exhibitionTableView setFrame:CM(exhibitionTableViewX,exhibitionTableViewY,exhibitionTableViewW, exhibitionTableViewH)];
        [self.view addSubview:_exhibitionTableView];
        
        
        //发送弹幕View
        CGFloat sendABarrageViewX=0;
        CGFloat sendABarrageViewY=CGRectGetMaxY(_player.frame);
        CGFloat sendABarrageViewW=self.view.frame.size.width
        ;
        CGFloat sendABarrageViewH=40;
        _sendABarrageView.frame=CM(sendABarrageViewX, sendABarrageViewY, sendABarrageViewW, sendABarrageViewH);
        
        if (_player.isPauseByUser==YES)
        {
            [_exhibitionTableView.tableHeaderView addSubview:_player];
            [_exhibitionTableView.tableHeaderView addSubview:_sendABarrageView];
        }
        else if (_player.isPauseByUser==NO)
        {
            _exhibitionNavigationView.but.alpha       = 0;
            _exhibitionNavigationView.backgroundColor = Color(90,179, 240, 0);
            [self.view addSubview:_player];
            [self.view addSubview:_sendABarrageView];
        }
        //添加导航栏
        [self.view addSubview:_exhibitionNavigationView];
        //设置fullScreenBtn图标
        [_player.maskView.fullScreenBtn setImage:[UIImage imageNamed:@"最大化_icon"] forState:UIControlStateNormal];
        
        if (_player.isPauseByUser==YES)
        {
            //将TableView置顶
            [_exhibitionTableView setContentOffset:CGPointMake(0,_playerH-_navigationViewH+40) animated:YES];
        }
        
    }
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation))
    {
        NSLog(@"现在是横屏");
        _isDirection                         = Cross_screen;//竖屏
        _exhibitionNavigationView.hidden     = YES;//隐藏导航栏
        _player.maskView.topImageView.hidden = NO;//显示topImageView
        //设置player的Frame
        CGFloat playerX                      = 0;
        CGFloat playerY                      = 0;
        CGFloat playerW                      = VIEW_WIDTH;
        CGFloat playerH                      = VIEW_HEIGHT-40;
        [_player setFrame:CM(playerX, playerY,playerW , playerH)];
        [self.view addSubview:_player];
        
        //发送弹幕View
        CGFloat sendABarrageViewX=0;
        CGFloat sendABarrageViewY=CGRectGetMaxY(_player.frame);
        CGFloat sendABarrageViewW=VIEW_WIDTH;
        CGFloat sendABarrageViewH=40;
        _sendABarrageView.frame=CM(sendABarrageViewX, sendABarrageViewY, sendABarrageViewW, sendABarrageViewH);
        [self.view addSubview:_sendABarrageView];
        //移除exhibitionTableView
        [_exhibitionTableView removeFromSuperview];
        //设置fullScreenBtn的图标;
        [_player.maskView.fullScreenBtn setImage:[UIImage imageNamed:@"最小化_icon"] forState:UIControlStateNormal];
        
    }
}
#pragma mark---------------------弹幕数据源----------------
-(void)setupDanmakuData
{
 
    NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    AFURLSessionManager       * manager       = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL                     * URL           = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.quumii.com/app/api.php?method=getv&vid=%@",_model.vid]];
    
    NSURLRequest              * request       = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask      * dataTask      = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error)
                                                 {
                                                     if (error)
                                                     {
                                                         NSLog(@"Error: %@", error);
                                                     } else
                                                     {
                                                         
                                                         NSMutableArray     * danmakus = [NSMutableArray array];
                                                         for (NSDictionary  * dict in responseObject[@"danmu"])
                                                         {
                                                             CFDanmaku      * danmaku  = [[CFDanmaku alloc] init];
                                                             
                                                             NSMutableAttributedString *contentStr = [[NSMutableAttributedString alloc] initWithString:dict[@"txt"] attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15], NSForegroundColorAttributeName : [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1]}];
                                                             
                                                             NSString          * emotionName                 = [NSString stringWithFormat:@"smile_%zd", arc4random_uniform(90)];
                                                             UIImage           * emotion                     = [UIImage imageNamed:emotionName];
                                                             NSTextAttachment  * attachment                  = [[NSTextAttachment alloc] init];
                                                             attachment.image                                = emotion;
                                                             attachment.bounds                               = CGRectMake(0, -[UIFont systemFontOfSize:15].lineHeight*0.3, [UIFont systemFontOfSize:15].lineHeight*1.5, [UIFont systemFontOfSize:15].lineHeight*1.5);
                                                             NSAttributedString * emotionAttr                = [NSAttributedString attributedStringWithAttachment:attachment];
                                                             
                                                             [contentStr appendAttributedString:emotionAttr];
                                                             danmaku.contentStr                             = contentStr;
                                                             
                                                             NSString* attributesStr                        = dict[@"start"];
                                                             NSArray* attarsArray                           = [attributesStr componentsSeparatedByString:@","];
                                                             danmaku.timePoint                              = [[attarsArray firstObject] doubleValue];
                                                             danmaku.position                               = 0;
                                                             //        if (danmaku.position != 0) {
                                                             [danmakus addObject:danmaku];
                                                             //        }

           
                                                         }
                                                         
                                                         [self.player.maskView.danmakuView prepareDanmakus:danmakus];
                                                         
                                                         
                                                     }
                                                     
                                                 }];
    [dataTask resume];
}
#pragma mark-----------------发送弹幕-----------------
-(void)sendBut:(UIButton*)but
{
    int time            = (int)self.player.maskView.videoSlider.value*120.0+1;
    NSString *mString   = _sendABarrageView.textField.text;
    CFDanmaku* danmaku  = [[CFDanmaku alloc] init];
    danmaku.contentStr  = [[NSMutableAttributedString alloc] initWithString:mString attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15], NSForegroundColorAttributeName : [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1]}];
    danmaku.timePoint   = time;
    [self.player.maskView.danmakuView sendDanmakuSource:danmaku];
}
#pragma mark-----------------APP进入前台-----------------
-(void)appDidEnterPlayGround
{
    //将TableView置顶
    [_exhibitionTableView setContentOffset:CGPointMake(0,_playerH-_navigationViewH+40) animated:YES];
    [self.exhibitionTableView.tableHeaderView addSubview:self.player];
    [_exhibitionTableView.tableHeaderView addSubview:_sendABarrageView];
    
}
-(void)dealloc
{
    [_notifiction removeObserver:self name:@"gitModel" object:nil];
    
}

@end
