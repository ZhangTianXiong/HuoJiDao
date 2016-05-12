//
//  TXHomeTableViewCell.h
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/16.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "TXListModel.h"
@interface TXHomeTableViewCell : UITableViewCell

@property(nonatomic,strong)TXListModel          * model;//模型
@property(nonatomic,strong)UIImageView          * icon;//头像
@property(nonatomic,strong)UILabel              * titleLabel;//标题
@property(nonatomic,strong)UILabel              * subtitleLabel;//副标题
@property(nonatomic,strong)UILabel              * datelineLabel;//发布时间
//创建cell的方法
-(instancetype)initWithTableView:(UITableView * )tableView;
+(instancetype)homeWithTableView:(UITableView * )tableView;


@end
