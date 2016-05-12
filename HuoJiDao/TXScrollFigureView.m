//
//  TXScrollFigureView.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/20.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXScrollFigureView.h"
#import "UIImageView+WebCache.h"
#import "TXScrollFigureModel.h"
#import "TXScrollFigureViewController.h"
@interface TXScrollFigureView()
<
UIScrollViewDelegate
>
{
    NSTimer * timer;
}
@end
@implementation TXScrollFigureView
#pragma mark---------------重写initWithFrame方法------------------
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
        self.backgroundColor=[UIColor whiteColor];
        //创建子控件
        UIScrollView   * scrollView  = [[UIScrollView alloc]init];
        scrollView.tag               = 0;
        scrollView.delegate          = self;
        _scrollView                  = scrollView;
        
        UIImageView    * imageView   = [[UIImageView alloc]init];
        _imageView                   = imageView;
        
        UIPageControl  * pageControl = [[UIPageControl alloc]init];
        _pageControl                 = pageControl;

        [self addSubview:scrollView];
        [scrollView addSubview:_imageView];
        [self addSubview:pageControl];
    }
    return self;
    
}
#pragma mark--------------重写点击事件-------------------------------
-(void)ImageGesture:(UIGestureRecognizer *)gesture
{
    NSLog(@"第%ld张图片被点击啦",gesture.view.tag);
    TXScrollFigureViewController * scrollFigureViewController=[[TXScrollFigureViewController alloc]init];
    [self.getController presentViewController:scrollFigureViewController animated:NO completion:nil];
    
    TXScrollFigureModel * model=_scrollFigureModel[gesture.view.tag];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"getLink" object:self userInfo:
 
     @{@"link":model.link}
     
     ];
    
    
}
#pragma mark--------------重写setPictures用于创建轮播图 --------------
-(void)setScrollFigureModel:(NSArray *)scrollFigureModel
{
    
    //重新赋值
    _scrollFigureModel                                  = scrollFigureModel;
    
    CGFloat viewW                              = self.frame.size.width;
    CGFloat viewH                              = self.frame.size.height;
    
    //设置ScrollView
    CGFloat scrollX                            = 0;
    CGFloat scrollY                            = 0;
    CGFloat scrollW                            = viewW;
    CGFloat scrollH                            = viewH;
    
    _scrollView.frame                          = CM(scrollX,scrollY , scrollW, scrollH);
    //滑动的范围
    _scrollView.contentSize                    = CGSizeMake(viewW*_scrollFigureModel.count, 0);
    //显示可视位置
    _scrollView.contentOffset = CGPointMake(0, 0);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator   = NO;
    _scrollView.pagingEnabled                  = YES;//开启翻页模式。
    
    CGFloat imageViewW                         =scrollW;
    CGFloat imageViewH                         =scrollH;
    
    //创建图片以及创建手势
    for (int i=0; i<_scrollFigureModel.count; i++)
    {
        _imageView                             = [[UIImageView alloc]initWithFrame:CM(viewW*i, 0, imageViewW, imageViewH)];
        _imageView.contentMode                 = UIViewContentModeScaleToFill;
        
        TXScrollFigureModel * model=_scrollFigureModel[i];
        //利用SDWebImageView加载图片
        [_imageView sd_setImageWithURL:[NSURL URLWithString:model.url]];
        _imageView.tag=i;
        //开启交互
        _imageView.userInteractionEnabled      = YES;
        [_scrollView addSubview:_imageView];
        //创建手势
        UITapGestureRecognizer * gesture       = [[UITapGestureRecognizer alloc]init];
        [gesture addTarget:self action:@selector(ImageGesture:)];
        //将手势添加进imageView中
        [_imageView addGestureRecognizer:gesture];
    }
    
    //设置PageControl
    CGFloat pageControlX                       = 0;
    CGFloat pageControlY                       = imageViewH-30;
    CGFloat pageControlW                       = viewW;
    CGFloat pageControlH                       = 30;
    
    //设置pageControl的Frame
    _pageControl.frame                         = CM(pageControlX, pageControlY, pageControlW, pageControlH);
    
    //设置pageControl的总页数
    _pageControl.numberOfPages                 = _scrollFigureModel.count;
    //设置pageControl的初始颜色
    _pageControl.pageIndicatorTintColor        = [UIColor whiteColor];
    //设置显示某一页
    _pageControl.currentPage=0;
    _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    [self addTimer];
}
//下一张
-(void)nextImage
{
    int page = (int)self.pageControl.currentPage;
    if (page == _scrollFigureModel.count-1)
    {
        page = 0;
    }else
    {
        page++;
    }
     //滚动scrollview
    CGFloat x                     = page * self.scrollView.frame.size.width;
    self.scrollView.contentOffset = CGPointMake(x, 0);
}
// scrollview滚动的时候调用
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.tag==0) {
        // 计算页码
        // 页码 = (contentoffset.x + scrollView一半宽度)/scrollView宽度
        CGFloat scrollviewW =  scrollView.frame.size.width;
        CGFloat x = scrollView.contentOffset.x;
        int page = (x + scrollviewW / 2) /  scrollviewW;
        self.pageControl.currentPage = page;
    }
}
 // 开始拖拽的时候调用
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    if (scrollView.tag==0) {
        //关闭定时器(注意点; 定时器一旦被关闭,无法再开启)
        //[self.timer invalidate];
        [self removeTimer];
    }
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView.tag==0) {
        //开启定时器
        [self addTimer];
    }

}
// 开启定时器
-(void)addTimer
{
    timer = [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
}
//关闭定时器
-(void)removeTimer
{
    [timer invalidate];
}


@end
