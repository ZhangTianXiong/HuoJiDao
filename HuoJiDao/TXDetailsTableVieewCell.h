//
//  TXVideoDetailsTableVieewCell.h
//  HuoJiDao
//
//  Created by IOS开发 on 16/5/5.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "TXCommentFrameModel.h"
#import "TXChaneView.h"
@interface TXDetailsTableVieewCell : UITableViewCell
@property(nonatomic,strong)TXCommentFrameModel  * frameModel;
@property(nonatomic,strong)UIImageView          * userIcon;//用户头像
@property(nonatomic,strong)UILabel              * userName;//用户名称
@property(nonatomic,strong)UILabel              * dateline;//发表时间
@property(nonatomic,strong)UILabel              * message;//消息
//准备将他创建成公用的类
@property(nonatomic,strong)TXChaneView          * likeView;//点赞View
@property(nonatomic,strong)TXChaneView          * unlikeView;//点踩View


-(instancetype)initWithTableView:(UITableView *)tableView;
+(instancetype)detailsWithTableView:(UITableView *)tableView;


@end
