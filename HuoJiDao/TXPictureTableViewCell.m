//
//  TXPictureTableViewCell.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/25.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXPictureTableViewCell.h"

@implementation TXPictureTableViewCell

-(void)drawRect:(CGRect)rect
{
    
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
       //创建子控件
        UILabel * titleLabel=[[UILabel alloc]init];
        titleLabel.font=[UIFont systemFontOfSize:14];
        titleLabel.numberOfLines=0;

        _titleLabel=titleLabel;
        
        UIImageView * pictureImageView=[[UIImageView alloc]init];
        pictureImageView.contentMode=UIViewContentModeScaleToFill;
        _pictureImageView=pictureImageView;
        
        TXFunctionBarView *  functionBarView=[[TXFunctionBarView alloc]init];
        _functionBarView=functionBarView;
        
        [self addSubview:titleLabel];
        [self addSubview:pictureImageView];
        [self addSubview:functionBarView];
    
    }
    return self;
}
-(void)setPicFrameModel:(TXPic_titleFrameModel *)picFrameModel{
    _picFrameModel=picFrameModel;
    
    //设置标题框架
    _titleLabel.frame=_picFrameModel.titleLabelFrame;
    
    //设置标题数据
    _titleLabel.text=_picFrameModel.pic_titleModel.explain;
    
    //设置图片结构
    _pictureImageView.frame=_picFrameModel.pictureImageFrame;
    //设置图片数据
    [_pictureImageView sd_setImageWithURL:[NSURL URLWithString:_picFrameModel.pic_titleModel.img] placeholderImage:nil];
    
    //设置功能条结构
    _functionBarView.frame=_picFrameModel.functionBarViewFrame;

    
    
}
-(instancetype)initWithTableView:(UITableView *)tableView
{
    static NSString * ID=@"picture_cell";
    TXPictureTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell)
    {
        cell=[[TXPictureTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
+(instancetype)pictureWithTableView:(UITableView * )tableView
{
    return [[self alloc]initWithTableView:tableView];
}
- (void)awakeFromNib {
    [super awakeFromNib];
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
