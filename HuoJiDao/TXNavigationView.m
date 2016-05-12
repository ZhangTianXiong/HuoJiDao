//
//  TXHomeNaVigtionView.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/13.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXNavigationView.h"
typedef NS_ENUM(NSInteger,Button_tag)
{
    menuButton,//返回
    searchButton,//搜索
};
@interface TXNavigationView()
@end
@implementation TXNavigationView



#pragma mark 监听 菜单按钮以及搜索按钮
-(void)TXHomeNaVigtionViewButton:(UIButton*)sender
{
    switch (sender.tag)
    {
        case menuButton:
        {
            //代理
            if ([_delegat respondsToSelector:@selector(navigationView:MenuButton:)])
            {
                [_delegat navigationView:self MenuButton:_menuBut];
            }
        }
            break;
        case searchButton:
        {
            //代理
            if ([_delegat respondsToSelector:@selector(navigationView:SearchButton:)])
            {
                [_delegat navigationView:self SearchButton:_searchBut];
            }
        }
        default:
            break;
    }
}

#pragma mark 监听选项卡
-(void)TXHomeNaVigtionViewTab:(UISegmentedControl*)sender
{
    if ([_delegat respondsToSelector:@selector(navigationView:Tab:)])
    {
        [_delegat navigationView:self Tab:_tab];
    }
}
#pragma mark---- 初始化View

//设置数据
-(void)setViewData
{
    //设置菜单数据
    _menuBut.tag                  = 0;
    UIImage * menuImageI          = [UIImage imageNamed:@"头像"];
    [_menuBut setImage:menuImageI forState:UIControlStateNormal];
    [_menuBut addTarget:self action:@selector(TXHomeNaVigtionViewButton:) forControlEvents:UIControlEventTouchUpInside];
    
    //是否显示圆角以外的部分
    _menuBut.layer.masksToBounds  = YES;
    //边框宽度
    _menuBut.layer.borderWidth    = 1;
    //边框颜色
    _menuBut.layer.borderColor    = USERPROFILE_Color;

    //选项卡
    _tab.selectedSegmentIndex     = 0;
    //设置选项卡颜色
    [_tab setTintColor:[UIColor whiteColor]];
    //设置点击事件
    [_tab addTarget:self action:@selector(TXHomeNaVigtionViewTab:) forControlEvents:UIControlEventValueChanged];
    
    //搜索
    _searchBut.tag                = 1;
    UIImage * searchImageI        = [UIImage imageNamed:@"搜索"];
    [_searchBut setImage:searchImageI forState:UIControlStateNormal];
    [_searchBut addTarget:self action:@selector(TXHomeNaVigtionViewButton:) forControlEvents:UIControlEventTouchUpInside];
    
}
#pragma mark ---设置界面Frame
-(void)setViewFrame
{
    //设置Frame
    CGFloat viewW       = self.frame.size.width;
    CGFloat viewH       = self.frame.size.height+20;
   //菜单BUtton
    CGFloat margins     = 10;
    CGFloat menuButW_H  = 40;
    CGFloat menuButX    = margins;
    CGFloat menuButY    = (viewH-menuButW_H)/2;
    _menuBut.frame      = CM(menuButX, menuButY, menuButW_H, menuButW_H);
    _menuBut.layer.cornerRadius = menuButW_H/2;
    //选项卡
    CGFloat tabW        = 120;
    CGFloat tabX        = viewW/2-tabW/2;
    CGFloat tabH        = 25;
    CGFloat tabY        = (viewH-tabH)/2;
    
    _tab.frame          = CM(tabX, tabY, tabW, tabH);
   //搜索
    CGFloat searchButW_H= 30;
    CGFloat searchButX  = viewW-searchButW_H-10;
    CGFloat searchButY  = (viewH-searchButW_H)/2;
    
    
    _searchBut.frame    = CM(searchButX, searchButY, searchButW_H, searchButW_H);
    //设置数据
   [self setViewData];
}
-(void)initView
{
    //创建控件
    _menuBut           = [UIButton buttonWithType:UIButtonTypeCustom];
    NSArray     * arr = @[@"首页",@"推荐"];
    _tab               = [[UISegmentedControl alloc]initWithItems:arr];
    _searchBut         = [UIButton buttonWithType:UIButtonTypeCustom];
    //添加子控件到View
    [self addSubview:_menuBut];
    [self addSubview:_tab];
    [self addSubview:_searchBut];
}

//重写父类的方法
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
        
        /*************************************************
         **                                             **
         ** 注意程序加载的次序。可以准确的说可划分为三个层次    **
         **  1.初始化视图---initView                     **
         **  2.设置视图位置---setViewFrame                **
         **  3.设置视图数据---setViewData                 **
         **************************************************/
        self.backgroundColor=Navigation_Color;
        [self initView];
        [self setViewFrame];
        [self setViewData];
        
    }
    return self;
}
@end
