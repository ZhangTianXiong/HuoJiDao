//
//  TXSetUpTableViewCell.h
//  HuoJiDao
//
//  Created by IOS开发 on 16/5/25.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TXSetUpTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel  * titleLabel;
@property(nonatomic,strong)UISwitch * mySwitch;

-(instancetype)initWithTableView:(UITableView *)tableView;
+(instancetype)setUpWithTableView:(UITableView *)tableVeiw;

@end
