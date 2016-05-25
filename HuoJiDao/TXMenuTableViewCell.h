//
//  TXMenuTableViewCell.h
//  HuoJiDao
//
//  Created by IOS开发 on 16/5/19.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TXMenuTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView       * icon;
@property(nonatomic,strong)UILabel           * titleLabel;

-(instancetype)initWithTableView:(UITableView *)tableView;
+(instancetype)menuTableView:(UITableView *)tableView;


@end
