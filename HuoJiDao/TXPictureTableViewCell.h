//
//  TXPictureTableViewCell.h
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/25.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "TXPic_titleFrameModel.h"
#import "TXFunctionBarView.h"
@interface TXPictureTableViewCell : UITableViewCell

@property(nonatomic,strong)TXPic_titleFrameModel * picFrameModel;

@property(nonatomic,strong)UILabel               * titleLabel;
@property(nonatomic,strong)UIImageView           * pictureImageView;
//功能条
@property(nonatomic,weak)TXFunctionBarView       *  functionBarView;

-(instancetype)initWithTableView:(UITableView *)tableView;
+(instancetype)pictureWithTableView:(UITableView * )tableView;
@end
