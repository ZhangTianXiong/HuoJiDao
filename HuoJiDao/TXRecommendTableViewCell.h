//
//  TXRecommendTableViewCell.h
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/22.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "TXRecommendChaneView.h"
#import "TXRecommendDisplaybarView.h"

#import "TXListFrameModel.h"
@interface TXRecommendTableViewCell : UITableViewCell
@property(nonatomic,strong)TXListFrameModel  * framemodel;
@property(nonatomic,strong)UIImageView            * picture;//图片
@property(nonatomic,strong)UILabel                * titleLabel;
@property(nonatomic,strong)TXRecommendChaneView            * chaneView;
@property(nonatomic,strong)UILabel                * datelineLabel;
@property(nonatomic,strong)TXRecommendDisplaybarView       * displaybarView;
-(instancetype)initWithTableView:(UITableView * )tableView;
+(instancetype)recommendWithTableView:(UITableView * )tableView;
@end
