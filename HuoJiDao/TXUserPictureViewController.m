//
//  TXUserPictureViewController.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/6/8.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXUserPictureViewController.h"
#import <AwAlertViewlib/AwAlertView.h>
@interface TXUserPictureViewController ()
<
UITableViewDelegate,UITableViewDataSource
>
{
    NSNotificationCenter        * _notifiction;//通知中心
    TXRequestData               * _data;
    TXPic_titleFrameModel       * _model;
    int                           _pag;//页数
    int                           _number;//条数
    
}

@end

@implementation TXUserPictureViewController
-(void)initData
{
    _notifiction=[NSNotificationCenter defaultCenter];
    [_notifiction addObserver:self selector:@selector(requestPicTitleData) name:@"RequestPicTitleData" object:nil];
    
    //创建数据源
    _data=[[TXRequestData alloc]init];
    //开始请求数据源
    [_data requestPicData];
}
-(void)initVar
{
    _pag       = 2;
    _number    = 20;
    
}
#pragma mark--------viewDidLoad--------------
- (void)viewDidLoad
{
    [self initData];
    [self initVar];
    [super viewDidLoad];
    self.view.backgroundColor   = [UIColor whiteColor];
    [self addPicTableView];
    [self addRefreshView];
    
    
}
#pragma mark==================添加刷新View========================
-(void)addRefreshView
{
    self.pictureTableView.tableHeaderView=[[UIView alloc]init];
    UIView * refreshView=[[[NSBundle mainBundle] loadNibNamed:@"ShuaXin" owner:nil options:nil]lastObject];
    refreshView.frame=CGRectMake(0, -40, self.view.frame.size.width,  40);
    [self.pictureTableView.tableHeaderView addSubview:refreshView];
}

#pragma mark------------添加图片TableView------------
-(void)addPicTableView
{
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat pictureTableViewX = 0;
    CGFloat pictureTableViewY = 0;
    CGFloat pictureTableViewW = self.view.frame.size.width;
    CGFloat pictureTableViewH = self.view.frame.size.height-104;
    _pictureTableView=[[UITableView alloc]initWithFrame:CM(pictureTableViewX, pictureTableViewY, pictureTableViewW, pictureTableViewH) style:UITableViewStylePlain];
    self.pictureTableView.tableFooterView            = [[[NSBundle mainBundle] loadNibNamed:@"videoJiaZai" owner:nil options:nil]lastObject];
    [self.view addSubview:_pictureTableView];
    
    
}
#pragma mark--------监听TableView的 行数--------------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _data.picFrameModel.count;
}
#pragma mark--------监听TableView的Cell--------------
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    _model=_data.picFrameModel[indexPath.row];
    //创建cell
    TXPictureTableViewCell * cell=[TXPictureTableViewCell pictureWithTableView:tableView];
    //设置单元格数据
    cell.picFrameModel=_model;
    //返回单元格
    return cell;
}
#pragma mark--------监听TableView的 行高--------------
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取数据
    _model=_data.picFrameModel[indexPath.row];
    return _model.rowH;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _model=_data.picFrameModel[indexPath.row];
    NSData * imagedata=[NSData dataWithContentsOfURL:[NSURL URLWithString:_model.pic_titleModel.img]];
    UIScrollView * imageScrollView=[[UIScrollView alloc]init];
    CGFloat imageScrollViewX=0;
    CGFloat imageScrollViewY=0;
    CGFloat imageScrollViewW=self.view.frame.size.width-30;
    CGFloat imageScrollViewH=self.view.frame.size.height-30;
    imageScrollView.frame=CM(imageScrollViewX, imageScrollViewY, imageScrollViewW, imageScrollViewH);
    UIImageView * imageView=[[UIImageView alloc]initWithImage:[UIImage imageWithData:imagedata]];
    imageView.frame=imageScrollView.frame;
    imageView.contentMode=UIViewContentModeScaleAspectFit;
    AwAlertView *alertView=[[AwAlertView alloc]initWithContentView:imageView];
    alertView.isUseHidden=YES;
    alertView.backgroundColor=[UIColor blackColor];
    [alertView show];
    
    
}
#pragma mark+++++++++++++++++++下拉刷新原理+++++++++++++++++++
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewX:%f  scrollViewY:%f",scrollView.contentOffset.x ,scrollView.contentOffset.y);
    if (scrollView.contentOffset.y <-60)
    {
        [UIView animateWithDuration:0.4 animations:^{
            self.pictureTableView.contentInset = UIEdgeInsetsMake(40.0f, 0.0f, 0.0f, 0.0f);
        } completion:^(BOOL finished){
            
            /**
             *  发起网络请求,请求刷新数据
             */
            
            [_data requestPicData];
            
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
            self.pictureTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        } completion:^(BOOL finished) {
            //添加数据
            [_data addPicDataWithPag:_pag Number:_number];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(DELAY_DATE * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
                           {
                               [_pictureTableView reloadData];
                               _pag+=1;
                               
                           });
        }];
        
    }
}



-(void)requestPicTitleData
{
    _pictureTableView.delegate                       = self;
    _pictureTableView.dataSource                     = self;
    _pictureTableView.showsHorizontalScrollIndicator = NO;
    _pictureTableView.showsVerticalScrollIndicator   = NO;
    _pictureTableView.separatorStyle                 = NO;//隐藏分割线
    
    //刷新
    [_pictureTableView reloadData];
    [UIView animateWithDuration:0.4 animations:^{
        self.pictureTableView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end

