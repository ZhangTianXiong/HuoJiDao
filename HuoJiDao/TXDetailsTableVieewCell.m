//
//  TXVideoDetailsTableVieewCell.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/5/5.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXDetailsTableVieewCell.h"

@implementation TXDetailsTableVieewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

 
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        UIImageView * userIcon          =[[UIImageView alloc]init];//用户头像
        userIcon.layer.cornerRadius     = 50/2;
        userIcon.layer.masksToBounds    = YES;
        _userIcon                       = userIcon;
        UILabel     * userName          = [[UILabel alloc]init];//用户名称
        userName.font                   = [UIFont systemFontOfSize:12];
        userName.textColor              = Color(106, 125, 160, 1);
        _userName                       = userName;
        UILabel     * dateline          = [[UILabel alloc]init];//发表时间
        dateline.font                   = [UIFont systemFontOfSize:11];
        dateline.textColor              = [UIColor grayColor];
        _dateline                       = dateline;
        //准备将他创建成公用的类
        TXChaneView * likeView          = [[TXChaneView alloc]init];//点赞View
        _likeView                       = likeView;
        TXChaneView * unlikeView        = [[TXChaneView alloc]init];//点踩View
        _unlikeView                     = unlikeView;
        
        UILabel * message               = [[UILabel alloc]init];//消息
        message.numberOfLines           = 0;
        message.font                    = [UIFont systemFontOfSize:12];
        _message                        = message;
        
        [self.contentView addSubview:userIcon];
        [self.contentView addSubview:userName];
        [self.contentView addSubview:dateline];
        [self.contentView addSubview:likeView];
        [self.contentView addSubview:unlikeView];
        [self.contentView addSubview:message];
         
        
    }
    return self;
}
-(instancetype)initWithTableView:(UITableView *)tableView
{
    static NSString * ID=@"details_cell";
    TXDetailsTableVieewCell * cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell)
    {
        cell=[[TXDetailsTableVieewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;

}
+(instancetype)detailsWithTableView:(UITableView *)tableView
{
    return [[self alloc]initWithTableView:tableView];
}
-(void)setFrameModel:(TXCommentFrameModel *)frameModel
{
    _frameModel=frameModel;
    //设置Frame
    _userIcon.frame         = _frameModel.userIconFrame;
    _userName.frame         = _frameModel.userNameFrame;
    _dateline.frame         = _frameModel.datelineFrame;
    _likeView.frame         = _frameModel.likeViewFrame;
    _unlikeView.frame       = _frameModel.unlikeViewFrame;
    _message.frame          = _frameModel.messageFrame;
    //设置数据
    [_userIcon sd_setImageWithURL:[NSURL URLWithString:_frameModel.model.avatar] placeholderImage:[UIImage imageNamed:@"头像"]];
    _userName.text          = _frameModel.model.author;
    _dateline.text          = _frameModel.model.dateline;
    _message.text           = _frameModel.model.message;
    
}
@end
