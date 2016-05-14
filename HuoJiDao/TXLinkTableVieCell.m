//
//  TXLinkTableVieCell.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/28.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXLinkTableVieCell.h"

@implementation TXLinkTableVieCell
#pragma mark--------重写initWithStyle:reuseIdentifier:方法 创建子控件----------
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        //图片
        UIImageView  * picture      = [[UIImageView alloc]init];
        _picture                    = picture;
        
        //标题
        UILabel * titleLabel        = [[UILabel alloc]init];
        titleLabel.numberOfLines    = 0;
        _titleLabel                 = titleLabel;
        _titleLabel.font            = [UIFont systemFontOfSize:13];
        
        //频道
        TXChaneView * chaneView     = [[TXChaneView alloc]init];
        _chaneView                  = chaneView;
        
        //发布时间
        UILabel * datelineLabel     = [[UILabel alloc]init];
        datelineLabel.font          = [UIFont systemFontOfSize:11];
        datelineLabel.textColor     = [UIColor grayColor];
        datelineLabel.textAlignment = NSTextAlignmentRight;
        _datelineLabel=datelineLabel;
        
        //显示条
        TXDisplaybarView * displaybarView = [[TXDisplaybarView alloc]init];
        _displaybarView                   = displaybarView;
        
        
        [self addSubview:picture];
        [self addSubview:titleLabel];
        [self addSubview:chaneView];
        [self addSubview:datelineLabel];
        [self addSubview:displaybarView];
    }
    return self;
}
#pragma mark---------------重写setFramemodel方法设置视图数据-----------
-(void)setFramemodel:(TXListFrameModel *)framemodel
{
    _framemodel                   = framemodel;
    //设置位置以及数据
    //设置图片
    _picture.frame                = _framemodel.pictureFrame;
    _picture.layer.masksToBounds = YES; //是否显示圆角以外的部分
    _picture.layer.cornerRadius   = 5;
    [_picture sd_setImageWithURL:[NSURL URLWithString:_framemodel.model.img] placeholderImage:[UIImage imageNamed:@"网络异常显示图"]];
    
    
    //设置标题
    _titleLabel.frame            = _framemodel.titleFrame;
    _titleLabel.text             = _framemodel.model.subject;
    
    
    //设置频道
    //注意：顺序解决位置问题
    _chaneView.frame             = _framemodel.chaneViewFrame;
    _chaneView.frameModel        = _framemodel;
    
    
    //设置发布时间
    _datelineLabel.frame         = _framemodel.datelineLabelFrame;
    _datelineLabel.text          = _framemodel.model.dateline;
    
    
    //设置显示条
    _displaybarView.frame        = _framemodel.displaybarViewFrame;
    _displaybarView.frameModel   = _framemodel;
    
}
#pragma mark---------------封装创建cell的对象方法-----------
-(instancetype)initWithTableView:(UITableView *)tableView
{
    static  NSString * ID = @"void_cell";
    TXLinkTableVieCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell)
    {
        cell = [[TXLinkTableVieCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
#pragma mark---------------封装创建cell的类方法-----------
+(instancetype)linkWithTableView:(UITableView *)tableView
{
    return [[self alloc]initWithTableView:tableView];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
