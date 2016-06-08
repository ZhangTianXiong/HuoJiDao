//
//  TXUserVideoViewController.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/6/8.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXUserVideoViewController.h"

@interface TXUserVideoViewController ()
<
UITableViewDelegate,UITableViewDataSource
>
{
    TXRequestData               *  _data;
    TXListFrameModel            * _frameModel;
    TXExhibitionController      * _videoExhibition;
    NSNotificationCenter        * _notifiction;
    int                           _pag;//页数
    int                           _number;//条数
}

@end

@implementation TXUserVideoViewController
-(void)initVar
{
    _pag       = 2;
    _number    = 20;
    
}
-(void)initData
{
    _notifiction = [NSNotificationCenter defaultCenter];
    [_notifiction addObserver:self selector:@selector(requestVideoDataComplete) name:@"RequestVideoDataComplete" object:nil];
    _data       = [[TXRequestData alloc]init];
    [_data requestVideoData];
    
}
- (void)viewDidLoad
{
    [self initData];
    [self initVar];
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self addVideoTableView];
    [self addRefreshView];
    
    
}


#pragma mark==================添加刷新View========================
-(void)addRefreshView
{
    self.videoTableView.tableHeaderView=[[UIView alloc]init];
    UIView * refreshView=[[[NSBundle mainBundle] loadNibNamed:@"ShuaXin" owner:nil options:nil]lastObject];
    refreshView.frame=CGRectMake(0, -40, self.view.frame.size.width,  40);
    [self.videoTableView.tableHeaderView addSubview:refreshView];
}

-(void)addVideoTableView
{
    CGFloat videoTableViewX       = 0;
    CGFloat videoTableViewY       = 0;
    CGFloat videoTableViewW       = self.view.frame.size.width;
    CGFloat videoTableViewH       = self.view.frame.size.height-104;
    _videoTableView               = [[UITableView alloc]initWithFrame:CM(videoTableViewX, videoTableViewY, videoTableViewW, videoTableViewH) style:UITableViewStylePlain];
    self.videoTableView.tableFooterView            = [[[NSBundle mainBundle] loadNibNamed:@"videoJiaZai" owner:nil options:nil]lastObject];
    [self.view addSubview:_videoTableView];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.videoFrameModel.count;
}

/***********************************************
 **   注意：                                   **
 **   创建通知中心，发布消息。                    **
 **   将_frameModel作为消息发布出去              **
 **********************************************/
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==0)
    {
        _videoExhibition    = [[TXExhibitionController alloc]init];
        _videoExhibition.modalTransitionStyle =  UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:_videoExhibition animated:YES completion:nil];
        _frameModel         = _data.videoFrameModel[indexPath.row];
        [_notifiction postNotificationName:@"gitModel" object:self userInfo:@{
                                                                              @"model":_frameModel.model
                                                                              }];
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    _frameModel            = _data.videoFrameModel[indexPath.row];
    return _frameModel.rowH;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==0)
    {
        //创建模型
        _frameModel                = _data.videoFrameModel[indexPath.row];
        //创建cell
        TXVideoTableVieCell * cell = [TXVideoTableVieCell videoWithTableView:tableView];
        //设置单元格数据
        cell.framemodel            = _frameModel;
        //返回cell
        
        return cell;
        
    }
    return nil;
}


#pragma mark+++++++++++++++++++下拉刷新原理+++++++++++++++++++
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewX:%f  scrollViewY:%f",scrollView.contentOffset.x ,scrollView.contentOffset.y);
    if (scrollView.contentOffset.y <-60)
    {
        [UIView animateWithDuration:0.4 animations:^{
            self.videoTableView.contentInset = UIEdgeInsetsMake(40.0f, 0.0f, 0.0f, 0.0f);
        } completion:^(BOOL finished){
            
            /**
             *  发起网络请求,请求刷新数据
             */
            
            [_data requestVideoData];
            
        }];
        
    }
}
#pragma mark+++++++++++++++++++上拉加载原理+++++++++++++++++++
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
    NSLog(@"%f",scrollView.contentOffset.y);
    NSLog(@"%f",scrollView.frame.size.height);
    NSLog(@"%f",scrollView.contentSize.height);
    /**
     *  关键-->
     *  scrollView一开始并不存在偏移量,但是会设定contentSize的大小,所以contentSize.height永远都会比contentOffset.y高一个手机屏幕的
     *  高度;上拉加载的效果就是每次滑动到底部时,再往上拉的时候请求更多,那个时候产生的偏移量,就能让contentOffset.y + 手机屏幕尺寸高大于这
     *  个滚动视图的contentSize.height
     */
    if (scrollView.contentOffset.y + scrollView.frame.size.height >= scrollView.contentSize.height) {
        NSLog(@"%d %s",__LINE__,__FUNCTION__);
        [UIView commitAnimations];
        
        [UIView animateWithDuration:1.0 animations:^{
            //  frame发生的偏移量,距离底部往上提高60(可自行设定)
            self.videoTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        } completion:^(BOOL finished) {
            //添加数据
            [_data addVideoDataWithPag:_pag Number:_number];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(DELAY_DATE * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
                           {
                               [_videoTableView reloadData];
                               _pag+=1;
                               
                           });
        }];
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
#pragma mark+++++++++++++++++视频数据请求完毕+++++++++++++++++
-(void)requestVideoDataComplete
{
    _videoTableView.tag                            = 0;
    _videoTableView.showsVerticalScrollIndicator   = NO;
    _videoTableView.showsHorizontalScrollIndicator = NO;
    _videoTableView.delegate                       = self;
    _videoTableView.dataSource                     = self;
    
    //刷新
    [_videoTableView reloadData];
    [UIView animateWithDuration:0.4 animations:^{
        self.videoTableView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
    }];
    
}
-(void)dealloc
{
    NSLog(@"dealloc 被调用");
    [_notifiction removeObserver:self name:@"gitModel" object:nil];
    
}

@end