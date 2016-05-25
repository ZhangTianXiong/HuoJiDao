//
//  TXHomeNaVigtionView.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/13.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXNavigationView.h"
#import "UIImageView+WebCache.h"
#import "TXPersonalCenterModel.h"
typedef NS_ENUM(NSInteger,Button_tag)
{
    menuButton,//返回
    searchButton,//搜索
};
@interface TXNavigationView()
{
    NSUserDefaults        * _userInformation;
    NSData                * _userInformationData;
    TXPersonalCenterModel * _model;
}
@end
@implementation TXNavigationView



#pragma mark---------------监听菜单按钮以及搜索按钮---------------
-(void)TXHomeNaVigtionViewButton:(UIButton*)sender
{
    switch (sender.tag)
    {
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
-(void)handLetap:(UITapGestureRecognizer*)gestureRecognizer
{
    if ([_delegat respondsToSelector:@selector(navigationView:HandLetap:)]) {
        [_delegat navigationView:self HandLetap:gestureRecognizer];
    }
}
#pragma mark---------------监听选项卡---------------
-(void)TXHomeNaVigtionViewTab:(UISegmentedControl*)sender
{
    if ([_delegat respondsToSelector:@selector(navigationView:Tab:)])
    {
        [_delegat navigationView:self Tab:_tab];
    }
}
#pragma mark==============初始化View==============

//设置数据
-(void)setViewData
{
    //设置菜单数据
    [_tapGesture addTarget:self action:@selector(handLetap:)];//头像手势
    [_userHeadPortrait addGestureRecognizer:_tapGesture];//将手势添加在头像上
    _userHeadPortrait.userInteractionEnabled = YES;//支持用户交互
    _userHeadPortrait.tag                  = 0;
    //是否显示圆角以外的部分
    _userHeadPortrait.layer.masksToBounds  = YES;
    //边框宽度
    _userHeadPortrait.layer.borderWidth    = 1;
    //边框颜色
    _userHeadPortrait.layer.borderColor    = USERPROFILE_Color;

    //选项卡
    _tab.selectedSegmentIndex              = 0;
    //设置选项卡颜色
    [_tab setTintColor:[UIColor whiteColor]];
    //设置点击事件
    [_tab addTarget:self action:@selector(TXHomeNaVigtionViewTab:) forControlEvents:UIControlEventValueChanged];
    
    //搜索
    _searchBut.tag                         = 1;
    UIImage * searchImageI                 = [UIImage imageNamed:@"搜索"];
    [_searchBut setImage:searchImageI forState:UIControlStateNormal];
    [_searchBut addTarget:self action:@selector(TXHomeNaVigtionViewButton:) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark==============设置界面Frame==============
-(void)setViewFrame
{
    //设置Frame
    CGFloat viewW                = self.frame.size.width;
    CGFloat viewH                = self.frame.size.height+20;
   //菜单BUtton
    CGFloat margins              = 10;
    CGFloat userHeadPortraitW_H  = 40;
    CGFloat userHeadPortraitX    = margins;
    CGFloat userHeadPortraitY    = (viewH-userHeadPortraitW_H)/2;
    _userHeadPortrait.frame      = CM(userHeadPortraitX, userHeadPortraitY, userHeadPortraitW_H, userHeadPortraitW_H);
    _userHeadPortrait.layer.cornerRadius = userHeadPortraitW_H/2;
    //选项卡
    CGFloat tabW                 = 120;
    CGFloat tabX                 = viewW/2-tabW/2;
    CGFloat tabH                 = 25;
    CGFloat tabY                 = (viewH-tabH)/2;
    
    _tab.frame                   = CM(tabX, tabY, tabW, tabH);
   //搜索
    CGFloat searchButW_H         = 30;
    CGFloat searchButX           = viewW-searchButW_H-10;
    CGFloat searchButY           = (viewH-searchButW_H)/2;
    
    
    _searchBut.frame             = CM(searchButX, searchButY, searchButW_H, searchButW_H);
    //设置数据
}
-(void)initView
{
    //创建控件
    _userHeadPortrait            = [[UIImageView alloc]init];
    NSArray     * arr            = @[@"首页",@"推荐"];
    _tab                         = [[UISegmentedControl alloc]initWithItems:arr];
    _searchBut                   = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _tapGesture                  = [[UITapGestureRecognizer alloc]init];
    //添加子控件到View
    [self addSubview:_userHeadPortrait];
    [self addSubview:_tab];
    [self addSubview:_searchBut];
}
-(void)drawRect:(CGRect)rect
{
    [self setViewFrame];
    [self setViewData];
}
-(void)initVar
{
    
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
         **  4.initVar初始化变量                         **
         **************************************************/
        self.backgroundColor=Navigation_Color;
        [self initView];

    }
    return self;
}

@end
