//
//  TXHomeTableViewCell.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/16.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXHomeTableViewCell.h"
@interface TXHomeTableViewCell()
{
   
}
@end
@implementation TXHomeTableViewCell


#pragma mark================创建子cell子控件================
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        //创建子控件
        //icon头像
        UIImageView  * icon                      = [[UIImageView alloc]init];//头像
        _icon                                    = icon;
        
        //titleLabel参数
        UIFont       * titleLabelFont            = [UIFont systemFontOfSize:13];
        UIColor      * titleLabelTextColor       = [UIColor blackColor];
        // titleLabel标题
        UILabel      * titleLabel                = [[UILabel alloc]init];
        titleLabel.font                          = titleLabelFont;
        titleLabel.textColor                     = titleLabelTextColor;
        _titleLabel                              = titleLabel;
        
        //subtitleLabel参数
        UIFont       * subtitleLabelFont         = [UIFont systemFontOfSize:12];
        UIColor      * subtitleLabelColor        = [UIColor grayColor];
        // subtitleLabel副标题
        UILabel      * subtitleLabel             = [[UILabel alloc]init];
        subtitleLabel.font                       = subtitleLabelFont;
        subtitleLabel.textColor                  = subtitleLabelColor;
        _subtitleLabel                           = subtitleLabel;
        
        //datelineLabel参数
        UIFont * datelineLabelFont               = [UIFont systemFontOfSize:10];
        UIColor * datelineLabelColor             = [UIColor grayColor];
        
        
        // datelineLabel;发布时间
        UILabel      * datelineLabel             = [[UILabel alloc]init];
        datelineLabel.font                       = datelineLabelFont;
        datelineLabel.textColor                  = datelineLabelColor;
        datelineLabel.textAlignment              = NSTextAlignmentRight;
        _datelineLabel                           = datelineLabel;
        
        [self.contentView addSubview:icon];
        [self.contentView addSubview:titleLabel];
        [self.contentView addSubview:subtitleLabel];
        [self.contentView addSubview:datelineLabel];
        
    
    }
    return self;
}


#pragma mark================设置View的Frame================
-(void)setViewFrae
{ 
    //icon
    CGFloat iconW_H              = 40;
    CGFloat margins              = 10;
    CGFloat iconY                = 12;
    CGFloat iconX                = margins;
    _icon.layer.masksToBounds    = YES; //是否显示圆角以外的部分
    _icon.layer.cornerRadius     = iconW_H/2;
    _icon.frame                  = CM(iconX, iconY, iconW_H, iconW_H);
    
    //主标题
    CGFloat titleLabelX          = CGRectGetMaxX(_icon.frame)+margins;
    CGFloat titleLabelY          = iconY;
    CGFloat titleLabelW          = VIEW_WIDTH-150;
    CGFloat titleLabelH          = 20;
    _titleLabel.frame            = CM(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    
    //副标题
    CGFloat subtitleLabelX       = CGRectGetMinX(_titleLabel.frame);
    CGFloat subtitleLabelY       = CGRectGetMaxY(_titleLabel.frame)+2;
    CGFloat subtitleLabelW       = VIEW_WIDTH-130;
    CGFloat subtitleLabelH       = 20;
    _subtitleLabel.frame         = CM(subtitleLabelX, subtitleLabelY, subtitleLabelW, subtitleLabelH);
    
    //发布时间
    CGFloat datelineLabelW       = 80;
    CGFloat datelineLabelX       = CGRectGetMaxX(_subtitleLabel.frame)-margins*2;
    
    CGFloat datelineLabelH       = 20;
    CGFloat datelineLabelY       = CGRectGetMinY(_titleLabel.frame)+5;
    _datelineLabel.frame         = CM(datelineLabelX, datelineLabelY, datelineLabelW, datelineLabelH);
    
    
}
#pragma mark+++++++++++++++++设置cell数据+++++++++++++++++
-(void)setModel:(TXListModel *)model
{
    _model = model;
    
    //设置View的Frame
    [self setViewFrae];
    
    //icon头像
    [_icon sd_setImageWithURL:[NSURL URLWithString:_model.img] placeholderImage:nil];
    //主标题
    _titleLabel.text    = model.subject;
    
    
    //副标题
    _subtitleLabel.text = _model.description_api;
    //发布时间
    _datelineLabel.text = _model.dateline;
    
    
    
    
}

#pragma mark -----------封装实例化cell的对象方法-------------
-(instancetype)initWithTableView:(UITableView *)tableView
{
    static  NSString    * ID   = @"home_cell";
    TXHomeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell)
    {
        cell                   = [[TXHomeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
#pragma mark -----------封装实例化cell的类方法--------------
+(instancetype)homeWithTableView:(UITableView *)tableView
{
    return [[self alloc]initWithTableView:tableView];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
   
}
- (void)awakeFromNib
{
    [super awakeFromNib];
}

@end
