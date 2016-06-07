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
    _notifiction      = [NSNotificationCenter defaultCenter];
    [_notifiction addObserver:self selector:@selector(requestLinkDataComplete) name:@"RequestLinkDataComplete" object:nil];
    
     _data            = [[TXRequestData alloc]init];
    [_data requestLinkData];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self addVideoTableView];
    [self addRefreshView];
    
}



#pragma mark==================添加刷新View========================
-(void)addRefreshView
{
    self.linkTableView.tableHeaderView=[[UIView alloc]init];
    UIView * refreshView=[[[NSBundle mainBundle] loadNibNamed:@"ShuaXin" owner:nil options:nil]lastObject];
    refreshView.frame=CGRectMake(0, -40, self.view.frame.size.width,  40);
    [self.linkTableView.tableHeaderView addSubview:refreshView];
}

-(void)addVideoTableView
{
    CGFloat linkTableViewX       = 0;
    CGFloat linkTableViewY       = 64;
    CGFloat linkTableViewW       = self.view.frame.size.width;
    CGFloat linkTableViewH       = self.view.frame.size.height-linkTableViewY;
    
    _linkTableView               = [[UITableView alloc]initWithFrame:CM(linkTableViewX, linkTableViewY, linkTableViewW, linkTableViewH) style:UITableViewStylePlain];
    
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
        _linkExhibition                         = [[TXExhibitionController alloc]init];
        _linkExhibition.modalTransitionStyle    =  UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:_linkExhibition animated:YES completion:nil];
        _linkExhibition                         = [[TXExhibitionController alloc]init];
        [self presentViewController:_linkExhibition animated:NO completion:nil];
        _frameModel                             = _data.linkFrameModel[indexPath.row];
        [_notifiction postNotificationName:@"gitModel" object:self userInfo:@{
                                                                             @"model":_frameModel.model
                                                                            }];
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    _frameModel             = _data.linkFrameModel[indexPath.row];
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
#pragma mark+++++++++++++++++++下拉刷新原理+++++++++++++++++++
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewX:%f  scrollViewY:%f",scrollView.contentOffset.x ,scrollView.contentOffset.y);
    if (scrollView.contentOffset.y <-60)
    {
        [UIView animateWithDuration:0.4 animations:^{
            self.linkTableView.contentInset = UIEdgeInsetsMake(40.0f, 0.0f, 0.0f, 0.0f);
        } completion:^(BOOL finished){
            
            /**
             *  发起网络请求,请求刷新数据
             */
            
            [_data requestLinkData];
            
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
            self.linkTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        } completion:^(BOOL finished) {
            //添加数据
            [_data addLinkDataWithPag:_pag Number:_number];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(DELAY_DATE * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
                           {
                               [_linkTableView reloadData];
                               _pag+=1;
                               
                           });
        }];
        
    }
}

#pragma mark+++++++++++++++++链接数据请求完毕+++++++++++++++++
-(void)requestLinkDataComplete
{
    _linkTableView.tag                            = 0;
    _linkTableView.showsVerticalScrollIndicator   = NO;
    _linkTableView.showsHorizontalScrollIndicator = NO;
    _linkTableView.delegate                       = self;
    _linkTableView.dataSource                     = self;
    //刷新
    [_linkTableView reloadData];
    [UIView animateWithDuration:0.4 animations:^{
        self.linkTableView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
    }];

    
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
