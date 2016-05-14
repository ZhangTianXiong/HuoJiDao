//
//  TXVidoViewController.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/23.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXVidoViewController.h"

@interface TXVidoViewController ()
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

@implementation TXVidoViewController
-(void)initVar
{
    _pag       = 2;
    _number    = 20;
    
}
-(void)initData
{
     _data  = [[TXRequestData alloc]init];
    [_data requestVideoData];
    
}
-(void)addVideoTableView
{
    CGFloat videoTableViewX       = 0;
    CGFloat videoTableViewY       = 64;
    CGFloat videoTableViewW       = self.view.frame.size.width;
    CGFloat videoTableViewH       = self.view.frame.size.height-videoTableViewY;
    _videoTableView               = [[UITableView alloc]initWithFrame:CM(videoTableViewX, videoTableViewY, videoTableViewW, videoTableViewH) style:UITableViewStylePlain];
    _videoTableView.tag                            = 0;
    _videoTableView.showsVerticalScrollIndicator   = NO;
    _videoTableView.showsHorizontalScrollIndicator = NO;
    _videoTableView.delegate                       = self;
    _videoTableView.dataSource                     = self;
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
        _videoExhibition=[[TXExhibitionController alloc]init];
        [self presentViewController:_videoExhibition animated:NO completion:nil];
        _frameModel=_data.videoFrameModel[indexPath.row];
        _notifiction=[NSNotificationCenter defaultCenter];
        [_notifiction postNotificationName:@"gitModel" object:self userInfo:@{
                                                                              @"model":_frameModel.model
                                                                              }];
        
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    _frameModel=_data.videoFrameModel[indexPath.row];
    return _frameModel.rowH;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==0)
    {
        //创建模型
        _frameModel=_data.videoFrameModel[indexPath.row];
        
        //创建cell
        TXVideoTableVieCell * cell = [TXVideoTableVieCell videoWithTableView:tableView];
        
        //设置单元格数据
        cell.framemodel            = _frameModel;
        //返回cell
        
        return cell;
        
    }
    return nil;
}
#pragma mark--------------加载更多------------------
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat scrollViewY = scrollView.contentOffset.y;
    CGFloat footerY     = self.videoTableView.tableFooterView.frame.origin.y;
    CGFloat y           = footerY-scrollViewY-10;
   
    //判断加载  以及添加数据 刷新数据
    if (y<y+15)
    {
        if (!self.videoTableView.tableFooterView.hidden)
        {
            //添加数据
            [_data addVideoDataPag:_pag Number:_number];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(DELAY_DATE* NSEC_PER_SEC)), dispatch_get_main_queue(), ^
                           {
                               [_videoTableView reloadData];
                               _pag+=1;
                               
                           });
            
        }
        
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(DELAY_DATE * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
                   {
          [self addVideoTableView];
                       
                   });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


-(void)dealloc
{
    NSLog(@"dealloc 被调用");
    [_notifiction removeObserver:self name:@"gitModel" object:nil];
    
}

@end
