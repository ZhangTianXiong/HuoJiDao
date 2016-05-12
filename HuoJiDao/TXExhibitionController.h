//
//  TXVideoExhibitionController.h
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/27.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXViewController.h"
#import "TXExhibitionNavigationView.h"
#import "TXMediaPlayer.h"
#import "TXListModel.h"

@interface TXExhibitionController : TXViewController

@property(nonatomic,strong)TXListModel                     * model;
@property(nonatomic,strong)TXExhibitionNavigationView      * exhibitionNavigationView;
@property(nonatomic,strong)UITableView                     * exhibitionTableView;
@property(nonatomic,strong)TXMediaPlayer                   * player;

@end
