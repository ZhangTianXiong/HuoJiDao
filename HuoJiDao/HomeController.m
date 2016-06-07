//
//  ViewController.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/13.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "HomeController.h"
#import "TXNavigationView.h"
//菜单
#import "TXMenuVIew.h"
//分类View
#import "TXCategoryView.h"
//分类Controller
#import "TXCategory.h"
//添加轮播图View
#import "TXScrollFigureView.h"
//添加TXHomeHeaderInSectionView
#import "TXHomeHeaderInSectionView.h"
#import "TXPersonalCenterModel.h"
@interface HomeController ()
<
TXNaVigtionViewDelegate,TXCategoryViewDelegate,UITableViewDelegate,UITableViewDataSource
>
{
    
    TXMenuView                 * _menu;//菜单
    TXAllViewController        * _allViewController;//全部Controller
    TXVidoViewController       * _vidoViewController;//视频Controller
    TXPictureViewController    * _pictureViewController;//图片Controller
    TXLinkViewController       * _linkViewController;//链接(文章)Controller
    TXExhibitionController     * _exhibitionController;//详情Controller
    NSNotificationCenter       * _notifiction;//通知中心
    TXNavigationView           * _navigtionView;//导航栏View
    UIView                     * _homeTableViewHeaderview;//首页TableViewHeaderview
    TXCategoryView             * _categoryView;//分类View
    TXScrollFigureView         * _scrollFigureView;//轮播图View
    CGFloat                      _viewW;//View的宽
    CGFloat                      _viewH;//View的高
    CGFloat                      _HomeTableViewHeaderHeight;//Header的高
    CGFloat                      _categoryViewHeight;//分类的高
    CGFloat                      _scrollFigureViewHeight;
    CGFloat                      _categoryViewTop;//设置分类距离Scroll的间距
    NSArray                    * _tit;//分类名称
    TXRequestData              * _data; //添加数据源
    int                          _pag;//页数
    int                          _number;//条数
   
}

@end

@implementation HomeController

/*********************************************************************************
 **                                                                             **
 **  下面代码主要用于初始化数据，添加视图到顶层View上。                                 **
 **   1.初始化变量initVar                                                         **
 **   2.addMenu 添加菜单功能                                                      **
 **   3.addCategory 添加跳转控制器                                                **
 *********************************************************************************/
#pragma mark+++++++++++++++++初始化变量initData+++++++++++++++++
-(void)initData
{
    _notifiction=[NSNotificationCenter defaultCenter];
    [_notifiction addObserver:self selector:@selector(requestHomeModelData) name:@"RequestHomeModelData" object:nil];
    [_notifiction addObserver:self selector:@selector(personalCenter) name:@"个人中心" object:nil
     ];
    
    //初始化数据源
     _data  = [[TXRequestData alloc]init];
    [_data requestHomeModelData];
    [_data requestRecommendData];
    
    
}
#pragma mark+++++++++++++++++初始化变量initVar+++++++++++++++++
-(void)initVar
{
    _pag    = 2;
    _number = 20;
    _viewW                     = self.view.frame.size.width;
    _viewH                     = self.view.frame.size.height;
    _HomeTableViewHeaderHeight = 220;//设置HomeTableView的HeaderView的高
    _scrollFigureViewHeight    = 135;//设置轮播图_scrollFigureViewHeight的高度
    _categoryViewHeight        = 64;//设置分类View的高
    _categoryViewTop           = 145;//设置分类距离Scroll的间距
}
#pragma mark==================设置NavigationView==================
-(void)setNavigationView
{
    [self addNavigtionView];//添加NavigtionView
    [self addBottomView];//添加底层View
    [self addHomeTableView];//添加HomeTableView
    [self setHomeTableViewWithHeaderView];//设置HomeTableView的HeaderView
    [self addScrollFigureView];//添加图片轮播图
    [self addCategoryView];//添加CategoryView
    [self addRefreshView];//添加刷新机制
    [self addNewestTableView];//添加NewestTableView
    [self addMenu];//添加菜单
    [self addCategory];//增加分类
}
#pragma mark==================添加NavigtionView==================
-(void)addNavigtionView
{
    
    
    _navigtionView                              = [[TXNavigationView alloc]initWithFrame:NavigationView_Frame];
    [self.view addSubview:_navigtionView];
   NSUserDefaults        *  userInformation     = [NSUserDefaults standardUserDefaults];
   NSData                *  userInformationData = [userInformation valueForKey:@"用户信息"];
   TXPersonalCenterModel *  personalCenterModel = [NSKeyedUnarchiver unarchiveObjectWithData:userInformationData];
    if (personalCenterModel)
    {
        [_navigtionView.userHeadPortrait sd_setImageWithURL:[NSURL URLWithString:personalCenterModel.avatar]];
    }else if (!personalCenterModel)
    {
        _navigtionView.userHeadPortrait.image=[UIImage imageNamed:@"头像"];
    }

    
    _navigtionView.delegat                     = self;
}

#pragma mark==================添加底层View============
-(void)addBottomView
{
    //创建ScrollerView
    _scrollView                                = [[UIScrollView alloc]init];
    _scrollView.tag                            = 0;
    CGFloat scrollerX                          = 0;
    //距离顶部64com
    CGFloat scrollerY                          = CGRectGetMaxY(_navigtionView.frame);
    CGFloat scrollerW                          = _viewW;
    CGFloat scrollerH                          = _viewH-scrollerY;
    _scrollView.frame                          = CM(scrollerX,scrollerY , scrollerW, scrollerH);
    //隐藏水平滚动条
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator   = NO;
    _scrollView.pagingEnabled=YES;//开启分页模式
    _scrollView.delegate=self;
    //滑动的范围
    _scrollView.contentSize                    = CGSizeMake(self.view.frame.size.width*2, 0);
    [self.view addSubview:_scrollView];
    //首页View
    _homeView=[[UIView alloc]init];
    CGFloat homeViewX                          = scrollerX;
    CGFloat homeViewY                          = 0;
    CGFloat homeViewW                          = scrollerW;
    CGFloat homeViewH                          = scrollerH;
    _homeView.frame                            = CM(homeViewX, homeViewY, homeViewW, homeViewH);
    [self.scrollView addSubview:_homeView];
    
    //最新推荐View
    _newestView=[[UIView alloc]init];
    CGFloat newestViewX                        = CGRectGetMaxX(_homeView.frame);
    CGFloat newestViewY                        = 0;
    CGFloat newestViewW                        = scrollerW*2;
    CGFloat newestViewH                        = scrollerH;
    _newestView.frame                          = CM(newestViewX, newestViewY, newestViewW, newestViewH);
    [self.scrollView addSubview:_newestView];
    _scrollView.contentSize                    = CGSizeMake(_viewW*2, newestViewH);//滑动的范围
    
    
}
/*************************************************************************
 **                                                                     **
 **    下面的代码主要用于创建UI控件 将控件添加在View下层。                      **
 **     1.addHomeTableView 添加首页的TableView                            **
 **     2.addNewestTableView 添加最新推荐TableView                         **
 **     3.addBottomView 添加底层View 控件                                 **
 **     4.addCategoryView 添加分类view                                    **
 **     5.注意：addNavigtionView 上面的方法都在这里调用                       **
 **                                                                      **
 **                                                                      **
 *************************************************************************/
#pragma mark==================添加addHomeTableView===============
-(void)addHomeTableView
{
    //初始化TableView
    CGFloat homeTableViewX    = 0;
    CGFloat homeTableViewY    = 0;
    CGFloat homeTableViewW    = self.homeView.frame.size.width;
    CGFloat homeTableViewH    = self.homeView.frame.size.height;
    _homeTableView=[[UITableView alloc]initWithFrame:CM(homeTableViewX, homeTableViewY, homeTableViewW, homeTableViewH) style:UITableViewStyleGrouped];
       [self.homeView addSubview:_homeTableView];
}
#pragma mark==================设置HomeTableView的HeaderView=======
-(void)setHomeTableViewWithHeaderView
{
    _homeTableViewHeaderview        = [[UIView alloc]initWithFrame:CM(0, 0, 0, _HomeTableViewHeaderHeight)];
    _homeTableViewHeaderview.backgroundColor            = Color(239, 239, 244, 1);
    _homeTableView.tableHeaderView  = _homeTableViewHeaderview;
    
}
#pragma mark==================HomeTableView的HeaderView上-添加轮播图ScrollFigureView====
-(void)addScrollFigureView
{
    CGFloat scrollFigureViewX   = 0;
    CGFloat scrollFigureViewY   = 0;
    CGFloat scrollFigureViewW   = _scrollView.frame.size.width;
    CGFloat scrollFigureViewH   = _scrollFigureViewHeight;
    _scrollFigureView           = [[TXScrollFigureView alloc]initWithFrame:CM(scrollFigureViewX, scrollFigureViewY, scrollFigureViewW, scrollFigureViewH)];
    [self.homeTableView addSubview:_scrollFigureView];
    
}
#pragma mark==================HomeTableView的HeaderView上添加分类CategoryView======
-(void)addCategoryView
{
    _categoryView                                   = [[TXCategoryView alloc]initWithFrame:CM(0, _categoryViewTop, self.view.frame.size.width, _categoryViewHeight)];
    _categoryView.backgroundColor                   = [UIColor whiteColor];
    _categoryView.delegate                          = self;
    [self.homeTableView addSubview:_categoryView];
}
#pragma mark==================添加刷新View========================
-(void)addRefreshView
{
    UIView * refreshView=[[[NSBundle mainBundle] loadNibNamed:@"ShuaXin" owner:nil options:nil]lastObject];
    refreshView.frame=CGRectMake(0, -40, self.view.frame.size.width,  40);
    [self.homeTableView.tableHeaderView addSubview:refreshView];
}
#pragma mark==================添加addNewestTableView===============
-(void)addNewestTableView
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.85 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //初始化addNewestTableView
        CGFloat newestTableViewX                   = 0;
        CGFloat newestTableViewY                   = _homeView.frame.origin.x;
        CGFloat newestTableViewW                   = self.homeView.frame.size.width;
        CGFloat newestTableViewH                   = self.newestView.frame.size.height;
        _newestTableView=[[UITableView alloc]initWithFrame:CM(newestTableViewX,newestTableViewY,newestTableViewW,newestTableViewH) style:UITableViewStylePlain];
        _newestTableView.tag=1;
        _newestTableView.showsHorizontalScrollIndicator = NO;
        _newestTableView.showsVerticalScrollIndicator   = NO;
        _newestTableView.delegate                       = self;
        _newestTableView.dataSource                     = self;
        self.newestTableView.tableHeaderView=[[UIView alloc]init];
        UIView * refreshView=[[[NSBundle mainBundle] loadNibNamed:@"ShuaXin" owner:nil options:nil]lastObject];
        refreshView.frame=CGRectMake(0, -40, self.view.frame.size.width,  40);
        [self.newestTableView.tableHeaderView addSubview:refreshView];
        self.newestTableView.tableFooterView=[[[NSBundle mainBundle] loadNibNamed:@"videoJiaZai" owner:nil options:nil]lastObject];
        [self.newestView addSubview:_newestTableView];
        
    });
    
}
#pragma mark==================添加MenuView==================
-(void)addMenu
{
    // 初始化
    _menu  = [[TXMenuView alloc]init];
    CGFloat menuW=self.view.frame.size.width;
    CGFloat menuX=-menuW;
    CGFloat menuY=0;
    CGFloat menuH=self.view.frame.size.height;
    _menu.frame=CGRectMake(menuX, menuY, menuW, menuH);
    [self.view addSubview:_menu];
}

#pragma mark==================ViewDidLoad==================
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
}
#pragma mark==================添加CategoryController==================
-(void)addCategory
{
    _allViewController       = [[TXAllViewController alloc]init];
    _vidoViewController      = [[TXVidoViewController alloc]init];
    _pictureViewController   = [[TXPictureViewController alloc]init];
    _linkViewController      = [[TXLinkViewController alloc]init];
    _allViewController.modalTransitionStyle     =  UIModalTransitionStyleCrossDissolve;
    _vidoViewController.modalTransitionStyle    =  UIModalTransitionStyleCrossDissolve;
    _pictureViewController.modalTransitionStyle =  UIModalTransitionStyleCrossDissolve;
    _linkViewController.modalTransitionStyle    =  UIModalTransitionStyleCrossDissolve;
    _tit=@[@"全部",@"视频",@"图片",@"文章"];
}
/****************************************************************************
 **                                                                        **
 **   下面的代码主要用于实现交互功能                                            **
 **    1.TXNavigtionViewDelegate 自定义导航栏协议                             **
 **    2.TXNaVigtionViewDelegate 自定义分类协议                              **
 **    3.UITableViewDataSource  原生TableView协议                           **
 ***************************************************************************/

#pragma mark-----------TXNaVigtionViewDelegate 监听菜单按钮---------
-(void)navigationView:(TXNavigationView *)navigtionView HandLetap:(UITapGestureRecognizer *)handLetap
{
    //开始动画
    [_menu animation];
}
#pragma mark-----------TXNaVigtionViewDelegate 监听选项卡按钮-------
-(void)navigationView:(TXNavigationView *)navigtionView Tab:(UISegmentedControl *)tab
{
    if (tab.selectedSegmentIndex==0)
    {
        //解决滑动出错的问题
         _scrollView.contentOffset = CGPointMake(self.homeView.frame.origin.x,self.homeView.frame.origin.y );
    }
    else if(tab.selectedSegmentIndex==1)
    {
       _scrollView.contentOffset=CGPointMake(self.newestView.frame.origin.x,self.newestView.frame.origin.y );
    }
}

#pragma mark-----------TXNaVigtionViewDelegate 监听搜索按钮-----------
-(void)navigationView:(TXNavigationView * )navigtionView SearchButton:(UIButton *)but
{
    TXSearchViewController * searchViewController=[[TXSearchViewController alloc]init];
    [self presentViewController:searchViewController animated:YES completion:nil];
}
#pragma mark-----------TXCategoryViewDelegate 监听全部按钮按钮-----------
- (void)categoryView:(TXCategoryView    * )categoryView AllBut:(UIButton *)but
{
    [self presentViewController:_allViewController animated:YES completion:nil];
   _allViewController.titleLabel.text=_tit[but.tag];
}
#pragma mark-----------TXCategoryViewDelegate 监听监听视频按钮-----------
- (void)categoryView:(TXCategoryView    * )categoryView VideoBut:(UIButton *)but
{
    [self presentViewController:_vidoViewController animated:YES completion:nil];
   _vidoViewController.titleLabel.text=_tit[but.tag];
}
#pragma mark-----------TXCategoryViewDelegate 监听图片按钮-----------
- (void)categoryView:(TXCategoryView    * )categoryView PictureBut:(UIButton *)but
{
    [self presentViewController:_pictureViewController animated:YES completion:nil];
    _pictureViewController.titleLabel.text=_tit[but.tag];
}
#pragma mark-----------TXCategoryViewDelegate 监听链接按钮-----------
- (void)categoryView:(TXCategoryView    * )categoryView LinkBut:(UIButton *)but
{
    [self presentViewController:_linkViewController animated:YES completion:nil];
    _linkViewController.titleLabel.text=_tit[but.tag];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
/*************************************
 *                                   *
 *   根据tag判断是哪个TableView        *
 *    homeTableViewTag 时首页         *
 *    newestTableViewTag 是最新推荐    *
 *************************************/
#pragma mark-----------UITableViewDataSource监听HeaderView----------
-(UIView*)tableView:(UITableView * )tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (tableView.tag==homeTableViewTag)
    {
        //创建组模型
        TXHomeModelo * model = _data.homeModel[section];
        //创建HeaderInSectionView
        TXHomeHeaderInSectionView * view = [[TXHomeHeaderInSectionView alloc]initWithFrame:CM(0, 0, _viewW, 70)];
        //处理数据
        view.model = model;
        view.backgroundColor = [UIColor whiteColor];
        return view;
    }
    return nil;
}
#pragma mark-----------UITableViewDataSource监听Headers的高-----------
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    //判断是哪个TableView
    if (tableView.tag==homeTableViewTag)
    {
        return 50;
    }
    return 0;
}

#pragma mark-----------UITableViewDataSource监听Section---------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    if (tableView.tag==homeTableViewTag)
    {
        return _data.homeModel.count;
    }
    return 1;
}
#pragma mark-----------UITableViewDataSource监听Row-----------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag==homeTableViewTag)
    {
        TXHomeModelo         * homeModel      = _data.homeModel[section];
        return homeModel.content.count;
    }
    if (tableView.tag==newestTableViewTag)
    {
        //利用请求数据类来解决数据供给
        return _data.recommendFrameModel.count;
    }
    return 0;
}
#pragma mark-----------UITableViewDataSource监听Row的高度----------
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==homeTableViewTag)
    {
        return 60;//首页的行高
    }
    if (tableView.tag==newestTableViewTag)
    {
        //初始化数据源
        TXListFrameModel        * frameModel   =  _data.recommendFrameModel[indexPath.row];
        return frameModel.rowH;
    }
    return 0;
}
#pragma mark-----------UITableViewDataSource 监听Cell-------------
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (tableView.tag==homeTableViewTag)
    {
        //创建模型
        TXHomeModelo          * homeModel      = _data.homeModel[indexPath.section];
        TXListModel           * listModel      = homeModel.content[indexPath.row];
        //创建cell
        TXHomeTableViewCell   * cell           = [TXHomeTableViewCell homeWithTableView:tableView];
        //设置单元格数据
        cell.model                             = listModel;
        //返回单元格
        return cell;
    }
    if (tableView.tag==newestTableViewTag)
    {
        //创建数据源
        TXListFrameModel              * frameModel    = _data.recommendFrameModel[indexPath.row];
        //创建cell
        TXRecommendTableViewCell      * cell          = [TXRecommendTableViewCell recommendWithTableView:tableView];
        //处理数据
        cell.framemodel                               = frameModel;
        return cell;
        
    }

    return nil;
}

#pragma mark-----------TableView点击事件-----------
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==homeTableViewTag)
    {
        //创建模型
        TXHomeModelo          * homeModel      = _data.homeModel[indexPath.section];
        TXListModel           * listModel      = homeModel.content[indexPath.row];
        
        _exhibitionController                       =[[TXExhibitionController alloc]init];
        _exhibitionController.modalTransitionStyle  =  UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:_exhibitionController animated:YES completion:nil];
        [_notifiction postNotificationName:@"gitModel" object:self userInfo:@{
                                                                              @"model":listModel
                                                                              }];
        
    }
    if (tableView.tag==newestTableViewTag)
    {
        //初始化数据源
        //创建数据源
        TXListFrameModel              * frameModel      = _data.recommendFrameModel[indexPath.row];
        _exhibitionController=[[TXExhibitionController alloc]init];
        _exhibitionController.modalTransitionStyle      =  UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:_exhibitionController animated:YES completion:nil];
        [_notifiction postNotificationName:@"gitModel" object:self userInfo:@{
                                                                              @"model":frameModel.model
                                                                              }];
    }

}
#pragma mark-----------UIScrollViewDelegate监听滑动-----------
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGPoint point = scrollView.contentOffset;
    //设置选项卡的状态
    if (scrollView.tag==0)
    {
        if (point.x<10)
        {
            _navigtionView.tab.selectedSegmentIndex=0;
        }else if(point.x==_newestView.frame.origin.x)
        {
            _navigtionView.tab.selectedSegmentIndex=1;
        }
        
    }
    
}
#pragma mark+++++++++++++++++++下拉刷新原理+++++++++++++++++++
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewX:%f  scrollViewY:%f",scrollView.contentOffset.x ,scrollView.contentOffset.y);
    if (scrollView.contentOffset.y <-60)
    {
        [UIView animateWithDuration:0.4 animations:^{
         self.homeTableView.contentInset = UIEdgeInsetsMake(40.0f, 0.0f, 0.0f, 0.0f);
         self.newestTableView.contentInset = UIEdgeInsetsMake(40.0f, 0.0f, 0.0f, 0.0f);
        } completion:^(BOOL finished){
            
            /**
             *  发起网络请求,请求刷新数据
             */
            [_data requestHomeModelData];
            [_data requestRecommendData];
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
            self.newestTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        } completion:^(BOOL finished) {
            //添加数据
            [_data addrecommendDataWithPag:_pag Number:_number];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(DELAY_DATE * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
                           {
                               [_newestTableView reloadData];
                               _pag+=1;
                               
                           });
        }];
        
    }
}
#pragma mark+++++++++++++++++监听首页数据请求完毕+++++++++++++++++
-(void)requestHomeModelData
{
    //心得
    /**********************************************************************************
     **  1.不要轻易创建对象。                                                            *
     **  2.在创建对象时要分开数据以及框架                                                 *
     **  3.再刷新页面时原理是重新调用的是重新设置数据的方法，一定要注意不要刷新数据是创建对象。     *
     **********************************************************************************/
    _homeTableView.tag        = 0;
    _homeTableView.showsHorizontalScrollIndicator = NO;
    _homeTableView.showsVerticalScrollIndicator   = NO;
    _homeTableView.delegate   = self;
    _homeTableView.dataSource = self;
    [_homeTableView reloadData];
    [_newestTableView reloadData];
    //添加数据
    _scrollFigureView.scrollFigureModel  = _data.scrollFigureModel;//轮播图网址
    [UIView animateWithDuration:0.4 animations:^{
         self.homeTableView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
        self.newestTableView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
        
    }];
}
#pragma mark-------------------个人中心实验区----------------
//内存问题还没有解决
-(void)personalCenter
{
    
    
    NSUserDefaults          * userInformation       = [NSUserDefaults standardUserDefaults];
    NSData                  * userInformationData   = [userInformation valueForKey:@"用户信息"];
    TXPersonalCenterModel   * personalCenterModel   = [NSKeyedUnarchiver unarchiveObjectWithData:userInformationData];
    
       if (personalCenterModel)
    {
        [_navigtionView.userHeadPortrait sd_setImageWithURL:[NSURL URLWithString:personalCenterModel.avatar]];
    }else if (!personalCenterModel)
    {
        _navigtionView.userHeadPortrait.image       = [UIImage imageNamed:@"头像"];
    }
    
    [self addMenu];
}
-(void)dealloc
{
    
}
@end
