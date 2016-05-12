//
//  TXLinkTableVieCell.h
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/28.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

#import "TXListFrameModel.h"
//展示条
#import "TXChaneView.h"
#import "TXDisplaybarView.h"
@interface TXLinkTableVieCell : UITableViewCell


@property(nonatomic,strong)TXListFrameModel * framemodel;

@property(nonatomic,strong)UIImageView            * picture;//图片
@property(nonatomic,strong)UILabel                * titleLabel;
@property(nonatomic,strong)TXChaneView       * chaneView;
@property(nonatomic,strong)UILabel                * datelineLabel;
@property(nonatomic,strong)TXDisplaybarView  * displaybarView;

-(instancetype)initWithTableView:(UITableView *)tableView;
+(instancetype)linkWithTableView:(UITableView *)tableView;
@end
