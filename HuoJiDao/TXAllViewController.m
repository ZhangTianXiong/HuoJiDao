//
//  TXAllViewController.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/23.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXAllViewController.h"

@interface TXAllViewController ()
<
UITableViewDelegate,UITableViewDataSource
>
{
    TXRequestData             *  _data;//数据源
    TXListFrameModel          * _frameModel;//数据模型
    TXExhibitionController    * _allExhibition;//详情Controller
    NSNotificationCenter      * _notifiction;//通知中心
    int                         _pag;//页数
    int                         _number;//条数
}

@end

@implementation TXAllViewController
-(void)initVar
{
    _pag    = 2;
    _number = 20;
    
}
-(void)initData
{
    _notifiction = [NSNotificationCenter defaultCenter];
    [_notifiction addObserver:self selector:@selector(requestAllDataComplete) name:@"RequestAllDataComplete" object:nil];
     _data       = [[TXRequestData alloc]init];
    [_data requestAllData];
}
-(void)addVideoTableView
{
    CGFloat allTableViewX  = 0;
    CGFloat allTableViewY  = 64;
    CGFloat allTableViewW  = self.view.frame.size.width;
    CGFloat allTableViewH  = self.view.frame.size.height-allTableViewY;
    _allTableView          = [[UITableView alloc]initWithFrame:CM(allTableViewX, allTableViewY, allTableViewW, allTableViewH) style:UITableViewStylePlain];
    self.allTableView.tableFooterView            = [[[NSBundle mainBundle] loadNibNamed:@"videoJiaZai" owner:nil options:nil]lastObject];
    [self.view addSubview:_allTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.allFrameModel.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==0)
    {
        _allExhibition = [[TXExhibitionController alloc]init];
        [self presentViewController:_allExhibition animated:NO completion:nil];
        _frameModel    = _data.allFrameModel[indexPath.row];
        [_notifiction postNotificationName:@"gitModel" object:self userInfo:@{
                                                                             @"model":_frameModel.model
                                                                             }];
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    _frameModel        = _data.allFrameModel[indexPath.row];
    return _frameModel.rowH;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==0)
    {
        //创建模型
        _frameModel               = _data.allFrameModel[indexPath.row];
        //创建cell
        TXAllTableViewCell * cell = [TXAllTableViewCell allWithTableView:tableView];
        //设置单元格数据
        cell.framemodel           = _frameModel;
        //返回cell
        return cell;
        
    }
    return nil;
}
#pragma mark--------------加载更多------------------
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat scrollViewY  = scrollView.contentOffset.y;
    CGFloat footerY      = self.allTableView.tableFooterView.frame.origin.y;
    CGFloat y            = footerY-scrollViewY-10;
    //判断加载  以及添加数据 刷新数据
    if (y<y+15)
    {
        if (!self.allTableView.tableFooterView.hidden)
        {
            //添加数据
            [_data addAllDataPag:_pag Number:_number];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(DELAY_DATE * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
                           {
                               [_allTableView reloadData];
                               _pag+=1;
                           });
            
        }
        
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addVideoTableView];
    self.view.backgroundColor = [UIColor whiteColor];
}
#pragma mark+++++++++++++++++全部数据请求完毕+++++++++++++++++
-(void)requestAllDataComplete
{
    _allTableView.tag                            = 0;
    _allTableView.showsVerticalScrollIndicator   = NO;
    _allTableView.showsHorizontalScrollIndicator = NO;
    _allTableView.delegate                       = self;
    _allTableView.dataSource                     = self;
    
    
    
}
-(void)dealloc
{
    NSLog(@"dealloc 被调用");
    [_notifiction removeObserver:self name:@"gitModel" object:nil];
    
}


@end
