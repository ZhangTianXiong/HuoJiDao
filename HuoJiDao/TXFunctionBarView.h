//
//  TXFunctionBarView.h
//  创建View虚线
//
//  Created by IOS开发 on 16/4/26.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TXListModel.h"
#import "TXView.h"
#import "TXTheDottedLineView.h"
@interface TXFunctionBarView :TXView
@property(nonatomic,strong)TXListModel * model;//数据
@property(nonatomic,weak)TXTheDottedLineView * thumbs_upView;//点赞View
@property(nonatomic,weak)TXTheDottedLineView * treadView;//点踩View
@property(nonatomic,weak)TXTheDottedLineView * collectionView;//收藏View
@property(nonatomic,weak)TXTheDottedLineView * commendView;//评论
@property(nonatomic,weak)TXTheDottedLineView * shareView;//分享

@end
