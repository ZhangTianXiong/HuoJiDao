//
//  TXMenuVIew.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/14.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXMenuVIew.h"
@interface TXMenuView ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray * array;
}
@end
@implementation TXMenuView
#pragma mark -------获取父类Controller---------
-(UIViewController*)getController
{
    id controller      = [self nextResponder];
    while (![controller isKindOfClass:[UIViewController class]]&&controller!=nil) {
        controller     = [controller nextResponder];
    }
    UIViewController * mainController = (UIViewController*)controller;
    return mainController;
}
#pragma mark -------初始化---------------------
-(instancetype)init
{
    if (self=[super init])
    {
        [self initView];
        
        array     =@[@"历史记录",@"离线缓存",@"关注和粉丝",@"我的收藏",@"反馈",@"设置"];
    }
    return self;
}
#pragma mark -------开始动画以及关闭动画
-(void)startAnimation
{
    if (self.ll_isOpen)
    {
        [self ll_closeSlideMenu];
    } else {
        [self ll_openSlideMenu];
    }
}
#pragma mark --------设置View宽度 背景图 以及动画效果
-(void)setWithViewWidth:(CGFloat)width
        BackgroundImage:(UIImage*)Image
          SpringDamping:(CGFloat)springDamping
         SpringVelocity:(CGFloat)springVelocity
        SpringFramesNum:(CGFloat )springFramesNum
{
     //设置菜单宽度
    self.ll_menuWidth = width;
   //设置菜单背景色
    [self setLl_menuBackgroundImage:Image];
     //设置弹力和速度，  默认的是20,15,60
  
    //三目运算
    !springDamping  ? (self.ll_springDamping=20)   : (self.ll_springDamping=errSecParam);
    !springVelocity ? (self.ll_springVelocity=15)  : (self.ll_springVelocity=springVelocity);
    !springFramesNum? (self.ll_springFramesNum=60) : (self.ll_springFramesNum);
}
#pragma mark ------初始化View布局
-(void)initView
{
    _imageView       = [[UIImageView alloc]init];
    _userImageView   = [[UIImageView alloc]init];
    _userNameBut     = [UIButton buttonWithType:UIButtonTypeCustom];
    _tableView       = [[UITableView alloc]init];
    [self addSubview:_imageView];
    [self.imageView addSubview:_userImageView];
    [self.imageView addSubview:_userNameBut];
    [self addSubview:_tableView];
    [self setViewFrame];

    
}
#pragma mark -------头像点击事件
-(void)handLetap:(UITapGestureRecognizer*)sender
{
    NSLog(@"Menu 头像");
}
#pragma mark -------BUtton 点击事件
-(void)MenuButton:(UIButton *)sender
{
    NSLog(@"Menu 登录 登出");
}
#pragma mark ------初始化View数据
-(void)setViewtData
{
    
    //背景图
    _imageView.image                     = [UIImage imageNamed:@"星空"];
    _imageView.userInteractionEnabled    = YES;
    _userImageView.image                 = [UIImage imageNamed:@"头像"];
    //设置头像数据
    _userImageView.image                 = [UIImage imageNamed:@"头像"];
    //是否显示圆角以外的部分
    _userImageView.layer.masksToBounds   = YES;
    //边框宽度
    _userImageView.layer.borderWidth     = 2;
    //边框颜色
    _userImageView.layer.borderColor     = USERPROFILE_Color;
    //支持用户交互
    _userImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer * tapGesture=[[UITapGestureRecognizer alloc]init];
    [tapGesture addTarget:self action:@selector(handLetap:)];
    [_userImageView addGestureRecognizer:tapGesture];
    
    //用户名称
    [_userNameBut setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_userNameBut setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [_userNameBut setTitle:@"请登录" forState:UIControlStateNormal];
    [_userNameBut addTarget:self action:@selector(MenuButton:) forControlEvents:UIControlEventTouchUpInside];
    
    //tableView
    _tableView.delegate=self;
    _tableView.dataSource=self;
    
}
#pragma mark -----初始化View 位置
-(void)setViewFrame
{
    
    CGFloat viewW                     = self.frame.size.width;
    CGFloat viewH                     = self.frame.size.height;
    CGFloat margin                    = 10;//边距
    //背景图
    CGFloat imageX                    = 0;
    CGFloat imageY                    = 0;
    CGFloat imageW                    = viewW;
    CGFloat imageH                    = viewH/3.5;
    _imageView.frame                  = CM(imageX, imageY, imageW, imageH);
    //头像
    CGFloat userImageX                = 30;
    CGFloat userImageY                = imageH/6;
    CGFloat userImageW                = imageH/3;
    //圆角的半径
    _userImageView.layer.cornerRadius = userImageW/2;
    CGFloat userImageH                = userImageW;
    _userImageView.frame              = CM(userImageX, userImageY, userImageW, userImageH);
    
    
    //用户名称
    CGFloat userNameButX              = CGRectGetMaxX(_userImageView.frame)+margin;
    CGFloat userNameButY              = CGRectGetMaxY(_userImageView.frame)/2;
    CGFloat userNameButW              = 80;
    CGFloat userNameButH              = 20;
    _userNameBut.frame                = CM(userNameButX, userNameButY, userNameButW, userNameButH);
    //tableView
    CGFloat tableViewX                = 0;
    CGFloat tableViewY                = CGRectGetMaxY(_imageView.frame);
    CGFloat tableViewW                = viewW;
    CGFloat tableViewH                = viewH-CGRectGetMaxY(_imageView.frame);
    _tableView.frame                  = CM(tableViewX, tableViewY, tableViewW, tableViewH);
   [self setViewtData];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return array.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取数据模型
    
    
    //创建单元格
    static NSString * ID=@"cell";
    
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    //设置单元格数据
    cell.textLabel.text=array[indexPath.row];
    //背景透明
    _tableView.alpha=0.5;
    cell.backgroundColor=[UIColor clearColor];
   //返回单元格
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Menu cell");
}
@end
