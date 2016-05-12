//
//  TXRequestData.h
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/22.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
//首页页面模型
#import "TXHomeModelo.h"

//pic图片页面模型
#import "TXPic_title.h"
//pic图片页面计算行高以及自适应模型
#import "TXPic_titleFrameModel.h"

//网络模型
#import "TXListModel.h"
#import "TXListFrameModel.h"


@interface TXRequestData : NSObject

//网络请求首页数据
@property(nonatomic,strong)NSMutableArray * scrollFigureModel;
@property(nonatomic,strong)NSMutableArray * homeModel;
-(void)requestHomeModelData;

//网络请求
@property(nonatomic,strong)NSMutableArray * picFrameModel;
@property(nonatomic,strong)NSArray * array;

//网络请求 推荐页面数据
@property(nonatomic,strong)NSMutableArray * recommendFrameModel;
-(void)requestRecommendData;
-(void)addrecommendDataWithPag:(int)pag Number:(int)number;

//网络请求 全部页面数据
@property(nonatomic,strong)NSMutableArray * allFrameModel;
-(void)requestAllData;
-(void)addAllDataPag:(int)pag Number:(int)number;


//网络请求 视频页面数据
@property(nonatomic,strong)NSMutableArray * videoFrameModel;
-(void)requestVideoData;
-(void)addVideoDataPag:(int)pag Number:(int)number;


//网络请求 链接页面数据
@property(nonatomic,strong)NSMutableArray * linkFrameModel;
-(void)requestLinkData;
-(void)addLinkDataPag:(int)pag Number:(int)number;

//网络请求
-(void)requestPicTitleData;

@end
