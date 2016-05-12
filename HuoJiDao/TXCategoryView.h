//
//  TXCategoryView.h
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/15.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXView.h"
@class TXCategoryView;
@protocol TXCategoryViewDelegate <NSObject>
#pragma mark---------------TXNaVigtionViewDelegate 监听所有按钮--------------
-(void)categoryView:(TXCategoryView*)categoryView AllBut:(UIButton *)but;
#pragma mark---------------TXNaVigtionViewDelegate 监听视频按钮--------------
-(void)categoryView:(TXCategoryView*)categoryView VideoBut:(UIButton *)but;
#pragma mark---------------TXNaVigtionViewDelegate 监听图片按钮-------------
-(void)categoryView:(TXCategoryView*)categoryView PictureBut:(UIButton *)but;
#pragma mark---------------TXNaVigtionViewDelegate 监听链接按钮--------------
-(void)categoryView:(TXCategoryView*)categoryView LinkBut:(UIButton *)but;
@end
@interface TXCategoryView : TXView
@property(nonatomic,strong)UIButton * allBut;//视频
@property(nonatomic,strong)UIButton * videoBut;//视频
@property(nonatomic,strong)UIButton * pictureBut;//图片
@property(nonatomic,strong)UIButton * linkBut;//链接
//设置代理属性
@property(nonatomic,strong)id<TXCategoryViewDelegate> delegate;

@end
