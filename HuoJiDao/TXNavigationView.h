//
//  TXHomeNaVigtionView.h
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/13.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXView.h"

@class TXNavigationView;
//协议
@protocol TXNaVigtionViewDelegate <NSObject>
//必需实现
@required
#pragma mark-----------TXNaVigtionViewDelegate 监听菜单按钮------------
-(void)navigationView:(TXNavigationView * )navigtionView MenuButton:(UIButton*)but;
#pragma mark-----------TXNaVigtionViewDelegate 监听搜索按钮------------
-(void)navigationView:(TXNavigationView * )navigtionView SearchButton:(UIButton *)but;
#pragma mark-----------TXNaVigtionViewDelegate 监听选项卡按钮----------
-(void)navigationView:(TXNavigationView * )navigtionView Tab:(UISegmentedControl*)tab;
@end
@interface TXNavigationView : TXView
@property(nonatomic,strong)id<TXNaVigtionViewDelegate> delegat;

//菜单(以及用户头像)
@property(nonatomic,strong)UIButton           * menuBut;
//选项卡
@property(nonatomic,strong)UISegmentedControl * tab;
//搜索
@property(nonatomic,strong)UIButton           * searchBut;
@end
