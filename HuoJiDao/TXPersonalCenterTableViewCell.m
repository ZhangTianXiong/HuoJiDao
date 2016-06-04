//
//  TXPersonalCenterTableViewCell.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/5/21.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXPersonalCenterTableViewCell.h"

@implementation TXPersonalCenterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        UILabel     * titleLabel       = [[UILabel alloc]init];
        _titleLabel                    = titleLabel;
        UIImageView * userHeadPortrait = [[UIImageView alloc]init];
        _userHeadPortrait              = userHeadPortrait;
        
        [self.contentView addSubview:titleLabel];
        [self.contentView addSubview:userHeadPortrait];
    }
    return self;
}
-(void)drawRect:(CGRect)rect
{
    [self setViewFrame];
    [self setviewData];
    
}
-(void)setViewFrame
{
    CGFloat  viewW                          = self.frame.size.width;
    CGFloat  viewH                          = self.frame.size.height;
    CGFloat  margin                         = 15;
    CGFloat  titleLabelX                    = margin;
    CGFloat  titleLabelH                    = 20;
    CGFloat  titleLabelW                    = 60;
    CGFloat  titleLabelY                    = (viewH-titleLabelH)/2;
    _titleLabel.frame                       = CM(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    
    CGFloat userHeadPortraitW_H             = 60;
    CGFloat userHeadPortraitX               = viewW-userHeadPortraitW_H-20;
    CGFloat userHeadPortraitY               = (viewH-userHeadPortraitW_H)/2;
    _userHeadPortrait.frame                 = CM(userHeadPortraitX, userHeadPortraitY, userHeadPortraitW_H, userHeadPortraitW_H);
    _userHeadPortrait.layer.cornerRadius    = userHeadPortraitW_H/2;
    
    
}
-(void)setviewData
{
    _titleLabel.font                        = [UIFont systemFontOfSize:15];
    _titleLabel.textColor                   = [UIColor blackColor];
    _titleLabel.textAlignment               = NSTextAlignmentCenter;
    _userHeadPortrait.layer.masksToBounds   = YES;//是否显示圆角以外的部分
    _userHeadPortrait.layer.borderWidth     = 2;//边框宽度
    _userHeadPortrait.layer.borderColor     = USERPROFILE_Color;//边框颜色
}
-(instancetype)initWithTableView:(UITableView *)tableView
{
    //创建单元格
    static NSString * ID=@"PersonalCenter_cell";
    TXPersonalCenterTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell)
    {
        cell=[[TXPersonalCenterTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID ];
    }
    return cell;
}
+(instancetype)personalCenterWithTableView:(UITableView *)tableVeiw
{
    return [[self alloc]initWithTableView:tableVeiw];
}

@end
