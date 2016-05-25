//
//  TXPersonalCenterTableViewCell.h
//  HuoJiDao
//
//  Created by IOS开发 on 16/5/21.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface TXPersonalCenterTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel     * titleLabel;
@property(nonatomic,strong)UIImageView * userHeadPortrait;
-(instancetype)initWithTableView:(UITableView *)tableView;
+(instancetype)personalCenterWithTableView:(UITableView *)tableVeiw;
@end
