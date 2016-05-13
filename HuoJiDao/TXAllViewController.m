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
    TXRequestData             *  _data;
    
    TXListFrameModel          * _frameModel;
    
    TXExhibitionController    * _videoExhibition;
    NSNotificationCenter      * _notifiction;
    
    int pag;//页数
    int number;//条数
}

@end

@implementation TXAllViewController
-(void)initVar
{
    pag = 2;
    number = 20;
    
}
-(void)initData
{
    
     _data = [[TXRequestData alloc]init];
    [_data requestAllData];
}
-(void)addVideoTableView
{
    CGFloat allTableViewX  = 0;
    CGFloat allTableViewY  = 64;
    CGFloat allTableViewW  = self.view.frame.size.width;
    CGFloat allTableViewH  = self.view.frame.size.height-allTableViewY;
    
   
    _allTableView       = [[UITableView alloc]initWithFrame:CM(allTableViewX, allTableViewY, allTableViewW, allTableViewH) style:UITableViewStylePlain];
    
    _allTableView.tag   = 0;
    _allTableView.showsVerticalScrollIndicator   = NO;
    _allTableView.showsHorizontalScrollIndicator = NO;
    _allTableView.delegate                       = self;
    _allTableView.dataSource                     = self;
    
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
        _videoExhibition=[[TXExhibitionController alloc]init];
        [self presentViewController:_videoExhibition animated:NO completion:nil];
        _frameModel=_data.allFrameModel[indexPath.row];
        _notifiction=[NSNotificationCenter defaultCenter];
        [_notifiction postNotificationName:@"gitModel" object:self userInfo:@{
                                                                             @"model":_frameModel.model
                                                                             }];
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    _frameModel=_data.allFrameModel[indexPath.row];
    return _frameModel.rowH;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==0)
    {
        //创建模型
        _frameModel=_data.allFrameModel[indexPath.row];
        //创建cell
        TXAllTableViewCell * cell=[TXAllTableViewCell allWithTableView:tableView];
        //设置单元格数据
        cell.framemodel=_frameModel;
        //返回cell
        return cell;
        
    }
    return nil;
}
#pragma mark--------------加载更多------------------
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat scrollViewY=scrollView.contentOffset.y;
    CGFloat footerY=self.allTableView.tableFooterView.frame.origin.y;
    CGFloat y = footerY-scrollViewY-10;
    NSLog(@"%f",y);
    //判断加载  以及添加数据 刷新数据
    if (y<y+15)
    {
        if (!self.allTableView.tableFooterView.hidden)
        {
            //添加数据
            [_data addAllDataPag:pag Number:number];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
                           {
                               [_allTableView reloadData];
                               pag+=1;
                           });
            
        }
        
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
                   {
                   [self addVideoTableView];
                   });
    
    
}



@end
