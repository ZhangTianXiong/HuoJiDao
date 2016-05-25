//
//  TXMenuTableViewCell.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/5/19.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXMenuTableViewCell.h"

@implementation TXMenuTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        UIImageView * icon       = [[UIImageView alloc]init];
        _icon                    = icon;
        UILabel     * titleLabel = [[UILabel alloc]init];
        _titleLabel              = titleLabel;
        [self.contentView addSubview:icon];
        [self.contentView addSubview:titleLabel];
    }
    
    
    return self;
}
-(void)drawRect:(CGRect)rect
{
    [self setViewFrame];
    [self setViewData];
}
-(void)setViewFrame
{

    CGFloat  veiwH        = self.frame.size.height;
    CGFloat iconX         = 15;
    CGFloat iconW_H       = 20;
    CGFloat iconY         = (veiwH-iconW_H)/2;
    _icon.frame           = CM(iconX, iconY, iconW_H, iconW_H);
    
    CGFloat titleLabelX   = CGRectGetMaxX(_icon.frame)+10;
    CGFloat titleLabelY   = iconY;
    CGFloat titleLabelW   = 150;
    CGFloat titleLabelH   = iconW_H;
    _titleLabel.frame     = CM(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    
}
-(void)setViewData
{
    //注意UILabel 实力化后一定要设置这几项
    _titleLabel.font                = [UIFont systemFontOfSize:13];
    _titleLabel.textColor           = [UIColor blackColor];
}
-(instancetype)initWithTableView:(UITableView *)tableView
{
    static NSString * ID=@"menu_cell";
     TXMenuTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[TXMenuTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;

}
+(instancetype)menuTableView:(UITableView *)tableView
{
    return [[self alloc]initWithTableView:tableView];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
@end
