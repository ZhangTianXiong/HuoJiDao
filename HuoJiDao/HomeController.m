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

//实验区

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
    
    TXNavigationView           * _navigtionView;//导航栏View
    TXCategoryView             * _categoryView;//分类View
    TXScrollFigureView         * _scrollFigureView;
    CGFloat                      _viewW;//View的宽
    CGFloat                      _viewH;//View的高
    CGFloat                      _HomeTableViewHeaderHeight;//Header的高
    CGFloat                      _categoryViewHeight;//分类的高
    CGFloat                      _scrollFigureViewHeight;
    CGFloat                      _categoryViewTop;//设置分类距离Scroll的间距
    NSArray                    * _tit;
    /*******************************
     *                             *
     *   TXRequestData 数据源      *
     *                            *
     *                            *
     *                            *
     ******************************/
    //添加数据源
    TXRequestData * _data;
    int pag;//页数
    int number;//条数
   
}

@end

@implementation HomeController

/*********************************************************************************
 **                                                                             **
 **  下面代码主要用于初始化数据，添加视图到顶层View上。                                 **
 **   1.初始化变量initVar                                                         **
 **   2.addMenu 添加菜单功能                                                      **
 **   3.addCategory 添加跳转控制器                                                **
 **   4.arrHomeMode 添加模型数据                                                  **
 **   5.注意：viewDidLoad 上面的方法是在该方法内被调用                                **
 **                                                                             **
 *******************************************************************************/
#pragma mark ----------- 初始化变量initVar----------
-(void)initData
{
    //初始化数据源
     _data  = [[TXRequestData alloc]init];
    [_data requestHomeModelData];
    [_data requestRecommendData];
    
}
-(void)initVar
{
    pag = 2;
    number = 20;
    
    _viewW                     = self.view.frame.size.width;
    _viewH                     = self.view.frame.size.height;
    _HomeTableViewHeaderHeight = 220;//设置HomeTableView的HeaderView的高
    _scrollFigureViewHeight    = 135;//设置轮播图_scrollFigureViewHeight的高度
    _categoryViewHeight        = 64;//设置分类View的高
    _categoryViewTop           = 145;//设置分类距离Scroll的间距
}
#pragma mark--------------在HomeController上面添加MenuView------------
-(void)addMenu
{
    // 初始化
    _menu  = [[TXMenuView alloc] init];
    [self.view addSubview:_menu];
    CGFloat menuW=self.view.frame.size.width/1.4;
    [_menu setWithViewWidth:menuW BackgroundImage:[UIImage imageNamed:@"星空"] SpringDamping:0 SpringVelocity:0 SpringFramesNum:0];
}
#pragma mark------------在HomeController上面添加CategoryController------------
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
#pragma mark--------------ViewDidLoad 上层View--------------
- (void)viewDidLoad
{
    [super viewDidLoad];
   
   
    
   
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



#pragma mark--------------添加addNewestTableView-----------
-(void)addNewestTableView
{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
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
        self.newestTableView.tableFooterView=[[[NSBundle mainBundle] loadNibNamed:@"videoJiaZai" owner:nil options:nil]lastObject];
        [self.newestView addSubview:_newestTableView];

    });
    
    
    
}
#pragma mark-------HomeTableView的HeaderView上-添加分类CategoryView-----------
-(void)addCategoryView
{
    _categoryView                                   = [[TXCategoryView alloc]initWithFrame:CM(0, _categoryViewTop, self.view.frame.size.width, _categoryViewHeight)];
    _categoryView.backgroundColor                   = [UIColor whiteColor];
    _categoryView.delegate                          = self;
    [self.homeTableView addSubview:_categoryView];
}
#pragma mark-------HomeTableView的HeaderView上-添加轮播图ScrollFigureView-------
-(void)addScrollFigureView
{
    
    
    CGFloat scrollFigureViewX   = 0;
    CGFloat scrollFigureViewY   = 0;
    CGFloat scrollFigureViewW   = _scrollView.frame.size.width;
    CGFloat scrollFigureViewH   = _scrollFigureViewHeight;
    _scrollFigureView           = [[TXScrollFigureView alloc]initWithFrame:CM(scrollFigureViewX, scrollFigureViewY, scrollFigureViewW, scrollFigureViewH)];
    //添加数据
    _scrollFigureView.scrollFigureModel  = _data.scrollFigureModel;//轮播图网址
    [self.homeTableView addSubview:_scrollFigureView];
   
    
    
}


#pragma mark-----------设置HomeTableView的HeaderView--------
-(void)setHomeTableViewWithHeaderView
{

    UIView            * view        = [[UIView alloc]initWithFrame:CM(0, 0, 0, _HomeTableViewHeaderHeight)];
    view.backgroundColor            = Color(239, 239, 244, 1);
    _homeTableView.tableHeaderView  = view;

}
#pragma mark------------添加addHomeTableView----------
-(void)addHomeTableView
{
    //初始化TableView
    CGFloat homeTableViewX    =0;
    CGFloat homeTableViewY    =0;
    CGFloat homeTableViewW    = self.homeView.frame.size.width;
    CGFloat homeTableViewH    = self.homeView.frame.size.height;
    
     _homeTableView=[[UITableView alloc]initWithFrame:CM(homeTableViewX, homeTableViewY, homeTableViewW, homeTableViewH) style:UITableViewStyleGrouped];
    _homeTableView.tag        = 0;
    _homeTableView.showsHorizontalScrollIndicator = NO;
    _homeTableView.showsVerticalScrollIndicator   = NO;
        
    _homeTableView.delegate   = self;
    _homeTableView.dataSource = self;
    [self.homeView addSubview:_homeTableView];
        
   
    
}


#pragma mark--------------添加底层View---------
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
#pragma mark-------------添加navigtionView--------------
-(void)addNavigtionView
{
    _navigtionView                             = [[TXNavigationView alloc]initWithFrame:NavigationView_Frame];
    [self.view addSubview:_navigtionView];
    _navigtionView.delegat                     = self;
}
#pragma mark-------------设置NavigationView--------------
-(void)setNavigationView
{
    //添加NavigtionView
    [self addNavigtionView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
    {
        //添加底层View
        [self addBottomView];
        //添加HomeTableView
        [self addHomeTableView];
        //设置HomeTableView的HeaderView
        [self setHomeTableViewWithHeaderView];
        [self addScrollFigureView];
        //添加CategoryView
        [self addCategoryView];
        //添加NewestTableView
        [self addNewestTableView];
        
        //添加菜单
        [self addMenu];
        //增加分类
        [self addCategory];

    });
    
    
}

/****************************************************************************
 **                                                                        **
 **   下面的代码主要用于实现交互功能                                            **
 **    1.TXNavigtionViewDelegate 自定义导航栏协议                             **
 **    2.TXNaVigtionViewDelegate 自定义分类协议                              **
 **    3.UITableViewDataSource  原生TableView协议                           **
 ***************************************************************************/

#pragma mark-----------TXNaVigtionViewDelegate 监听菜单按钮---------
-(void)navigationView:(TXNavigationView *)navigtionView MenuButton:(UIButton *)but
{
    [_menu startAnimation];
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
#pragma mark------------UIScrollViewDelegate 监听滑动-----------
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
#pragma mark---------TXNaVigtionViewDelegate 监听搜索按钮-----------
-(void)navigationView:(TXNavigationView * )navigtionView SearchButton:(UIButton *)but
{
    TXSearchViewController * searchViewController=[[TXSearchViewController alloc]init];
    [self presentViewController:searchViewController animated:NO completion:nil];
    NSLog(@"搜索");
}
#pragma mark---------TXCategoryViewDelegate 监听全部按钮按钮-----------
- (void)categoryView:(TXCategoryView    * )categoryView AllBut:(UIButton *)but
{
    
    [self presentViewController:_allViewController animated:YES completion:nil];
   _allViewController.titleLabel.text=_tit[but.tag];
}
#pragma mark--------TXCategoryViewDelegate 监听监听视频按钮-----------
- (void)categoryView:(TXCategoryView    * )categoryView VideoBut:(UIButton *)but
{
    [self presentViewController:_vidoViewController animated:YES completion:nil];
   _vidoViewController.titleLabel.text=_tit[but.tag];
}
#pragma mark--------TXCategoryViewDelegate 监听图片按钮------------
- (void)categoryView:(TXCategoryView    * )categoryView PictureBut:(UIButton *)but
{
    [self presentViewController:_pictureViewController animated:YES completion:nil];
    _pictureViewController.titleLabel.text=_tit[but.tag];
}
#pragma mark--------TXCategoryViewDelegate 监听链接按钮-------------
- (void)categoryView:(TXCategoryView    * )categoryView LinkBut:(UIButton *)but
{
    [self presentViewController:_linkViewController animated:YES completion:nil];
    _linkViewController.titleLabel.text=_tit[but.tag];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
#pragma mark---------UITableViewDataSource 监听HeaderView----------
-(UIView*)tableView:(UITableView     * )tableView viewForHeaderInSection:(NSInteger)section
{
    /*************************************
     *                                   *
     *   根据tag判断是哪个TableView        *
     *    homeTableViewTag 时首页         *
     *    newestTableViewTag 是最新推荐    *
     *    这里：创建SectionHeader          *
     *************************************/
    if (tableView.tag==homeTableViewTag)
    {
        //创建组模型
        TXHomeModelo * model=_data.homeModel[section];
        //创建HeaderInSectionView
        TXHomeHeaderInSectionView * view=[[TXHomeHeaderInSectionView alloc]initWithFrame:CM(0, 0, _viewW, 70)];
        //处理数据
        view.model=model;
        
        view.backgroundColor=[UIColor whiteColor];
        //添加到homeView
        [self.homeView addSubview:view];
        return view;
    }
    
    
    return nil;
}
#pragma mark---------UITableViewDataSource 监听Headers的高----------
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    /*************************************
     *                                   *
     *   根据tag判断是哪个TableView        *
     *    homeTableViewTag 时首页         *
     *    newestTableViewTag 是最新推荐    *
     *                                   *
     *************************************/
    //判断是哪个TableView
    if (tableView.tag==homeTableViewTag)
    {
        return 50;
    }
    return 0;
}

#pragma mark--------UITableViewDataSource 监听Section---------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    /*************************************
     *                                   *
     *   根据tag判断是哪个TableView        *
     *    homeTableViewTag 时首页         *
     *    newestTableViewTag 是最新推荐    *
     *                                   *
     *************************************/
    if (tableView.tag==homeTableViewTag)
    {
        
        return _data.homeModel.count;
    }
    return 1;
}
#pragma mark----------UITableViewDataSource 监听Row------------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    /*************************************
     *                                   *
     *   根据tag判断是哪个TableView        *
     *    homeTableViewTag 时首页         *
     *    newestTableViewTag 是最新推荐    *
     *                                   *
     *************************************/
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
#pragma mark----------UITableViewDataSource 监听的Section名称--------
-(NSString * )tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    /*************************************
     *                                   *
     *   根据tag判断是哪个TableView        *
     *    homeTableViewTag 时首页         *
     *    newestTableViewTag 是最新推荐    *
     *                                   *
     *************************************/
    if (tableView.tag==newestTableViewTag)
    {
        return nil;
    }
    return nil;
}
#pragma mark---------UITableViewDataSource 监听的Row的高度----------
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*************************************
     *                                   *
     *   根据tag判断是哪个TableView        *
     *    homeTableViewTag 时首页         *
     *    newestTableViewTag 是最新推荐    *
     *                                   *
     *************************************/
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
    
    /******************************************
     **  tableView.tag=0 代表 首页            **
     **  tableView.tag=1 代表 最新            **
     **                                      **
     ******************************************/
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
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat scrollViewY         = scrollView.contentOffset.y;
    CGFloat footerY             = self.newestTableView.tableFooterView.frame.origin.y;
    CGFloat y                   = footerY-scrollViewY-10;
    //判断加载  以及添加数据 刷新数据
    if (y<y+15)
    {
        if (!self.newestTableView.tableFooterView.hidden)
        {
            //添加数据
            [_data addAllDataPag:pag Number:number];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
                           {
                            [_newestTableView reloadData];
                            pag+=1;

                           });
            
        }
        
    }
}


@end
