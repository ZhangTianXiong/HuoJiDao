//
//  TXVideoExhibitionController.h
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/27.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXViewController.h"
#import "AFNetworking.h"//AFNetworking
#import "UIImage+GIF.h"//SDWebImage的GIF
#import "TXExhibitionNavigationView.h"//导航栏
#import "TXMediaPlayer.h"//视频播放
#import "TXPicView.h"//图片展示View
#import "TXExhibitionDetailsView.h"//展示条
#import "TXTheDottedLineView.h"//功能条
#import "TXDetailsTableVieewCell.h"//DetailsTableVieewCell详情cell
#import "TXCommentFrameModel.h"//Cell的数据模型
#import "TXCommentHeadView.h"//CommentHeadView评论组头部View
#import "TXListModel.h"
#import "TXSendABarrageView.h"//发送弹幕View
@interface TXExhibitionController : TXViewController
@property(nonatomic,strong)TXListModel                     * model;
@property(nonatomic,strong)TXExhibitionNavigationView      * exhibitionNavigationView;
@property(nonatomic,strong)UITableView                     * exhibitionTableView;
@property(nonatomic,strong)TXMediaPlayer                   * player;
@property(nonatomic,strong)TXPicView                       * picView;
@end
