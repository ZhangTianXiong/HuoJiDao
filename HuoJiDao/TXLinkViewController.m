//
//  TXLinkViewController.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/23.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXLinkViewController.h"

@interface TXLinkViewController ()
<
UITableViewDelegate,UITableViewDataSource
>

{
    TXRequestData              *  _data;//数据源
    TXListFrameModel           * _frameModel;//数据模型
    TXExhibitionController     * _linkExhibition;//详情Controller
    NSNotificationCenter       * _notifiction;
    int                          _pag;
    int                          _number;
}
@end


@implementation TXLinkViewController
-(void)initVar
{
    _pag        = 2;
    _number     = 3;
    
}
-(void)initData
{
     _data  =[[TXRequestData alloc]init];
    [_data requestLinkData];
}
-(void)addVideoTableView
{
    CGFloat linkTableViewX       = 0;
    CGFloat linkTableViewY       = 64;
    CGFloat linkTableViewW       = self.view.frame.size.width;
    CGFloat linkTableViewH       = self.view.frame.size.height-linkTableViewY;
    
    _linkTableView               = [[UITableView alloc]initWithFrame:CM(linkTableViewX, linkTableViewY, linkTableViewW, linkTableViewH) style:UITableViewStylePlain];
    
    _linkTableView.tag                            = 0;
    _linkTableView.showsVerticalScrollIndicator   = NO;
    _linkTableView.showsHorizontalScrollIndicator = NO;
    _linkTableView.delegate                       = self;
    _linkTableView.dataSource                     = self;
    
    self.linkTableView.tableFooterView            = [[[NSBundle mainBundle] loadNibNamed:@"videoJiaZai" owner:nil options:nil]lastObject];
    
    [self.view addSubview:_linkTableView];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.linkFrameModel.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==0)
    {
        _linkExhibition=[[TXExhibitionController alloc]init];
        [self presentViewController:_linkExhibition animated:NO completion:nil];
        _linkExhibition=[[TXExhibitionController alloc]init];
        [self presentViewController:_linkExhibition animated:NO completion:nil];
        _frameModel=_data.linkFrameModel[indexPath.row];
        _notifiction=[NSNotificationCenter defaultCenter];
        [_notifiction postNotificationName:@"gitModel" object:self userInfo:@{
                                                                             @"model":_frameModel.model
                                                                            }];
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    _frameModel=_data.linkFrameModel[indexPath.row];
    return _frameModel.rowH;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==0)
    {
        //创建模型
        _frameModel               = _data.linkFrameModel[indexPath.row];
        
        //创建cell
       TXLinkTableVieCell  * cell = [TXLinkTableVieCell linkWithTableView:tableView];
        
        //设置单元格数据
        cell.framemodel           =_frameModel;
        //返回cell
        
        return cell;
        
    }
    return nil;
}
#pragma mark--------------加载更多------------------
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat scrollViewY   = scrollView.contentOffset.y;
    CGFloat footerY       = self.linkTableView.tableFooterView.frame.origin.y;
    CGFloat y             = footerY-scrollViewY-10;
    //判断加载  以及添加数据 刷新数据
    if (y<y+15)
    {
        if (!self.linkTableView.tableFooterView.hidden)
        {
            //添加数据
            [_data addLinkDataPag:_pag Number:_number];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
                           {
                               [_linkTableView reloadData];
                               _pag+=1;
                               
                           });
            
        }
        
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
                   {
                       [self addVideoTableView];
                       
                   });
    
}
-(void)dealloc
{
    NSLog(@"dealloc 被调用");
    [_notifiction removeObserver:self name:@"gitModel" object:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
