//
//  TXSetUpTableViewCell.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/5/25.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXSetUpTableViewCell.h"

@implementation TXSetUpTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        UILabel  * titleLabel=[[UILabel alloc]init];
        _titleLabel=titleLabel;
        UISwitch * mySwitch=[[UISwitch alloc]init];
        _mySwitch=mySwitch;
        
        [self.contentView addSubview:titleLabel];
        [self.contentView addSubview:mySwitch];
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
    CGFloat viewW=self.frame.size.width;
    CGFloat viewH=self.frame.size.height;
    
    CGFloat margin=10;
    CGFloat titleLabelW=150;
    CGFloat titleLabelX=margin;
    CGFloat titleLabelH=20;
    CGFloat titleLabelY=(viewH-titleLabelH)/2;
    _titleLabel.frame=CM(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    
    
    CGFloat mySwitchW=50;
    CGFloat mySwitchH=viewH;
    CGFloat mySwitchX=viewW-mySwitchW-margin;
    CGFloat mySwitchY=(viewH-_mySwitch.frame.size.height)/2;
    _mySwitch.frame=CM(mySwitchX, mySwitchY, mySwitchW, mySwitchH);
}
-(void)setViewData
{
    _titleLabel.font                        = [UIFont systemFontOfSize:15];
    _titleLabel.textColor                   = [UIColor blackColor];
}
-(instancetype)initWithTableView:(UITableView *)tableView
{
    static NSString * ID=@"setUp_cell";
    TXSetUpTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell)
    {
        cell=[[TXSetUpTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
+(instancetype)setUpWithTableView:(UITableView *)tableVeiw
{
    return [[self alloc]initWithTableView:tableVeiw];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
