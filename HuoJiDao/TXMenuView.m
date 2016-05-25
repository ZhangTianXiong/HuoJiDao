//
//  TXMenuVIew.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/14.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXMenuVIew.h"
#import "UIImageView+WebCache.h"
#import "TXSignInViewController.h"
#import "TXRegisteredViewController.h"
#import "TXMenuTableViewCell.h"
#import "TXPersonalCenterModel.h"
#import "TXPersonalCenterViewController.h"
@interface TXMenuView ()<UITableViewDelegate,UITableViewDataSource>
{
    UITapGestureRecognizer * _tapGesture;
    
    NSUserDefaults         * _userInformation;
    NSData                 * _userInformationData;
    TXPersonalCenterModel  * _model;
    
    NSArray                * _arrayI;
    NSArray                * _arrayII;
    CGFloat                  _second;
}
@end
@implementation TXMenuView
#pragma mark -------初始化---------------------
-(instancetype)init
{
    if (self=[super init])
    {
        self.backgroundColor                     = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0];
        
        UIButton    * closeMenuBut               = [[UIButton alloc]init];
        _closeMenuBut=closeMenuBut;
        
        UIImageView * backgroundImageView        = [[UIImageView alloc]init];
        _backgroundImageView=backgroundImageView;
        
        //用户头像
        UIImageView * userImageView              = [[UIImageView alloc]init];
        _userImageView=userImageView;
        //用户昵称
        UIButton    * userNameBut                = [UIButton buttonWithType:UIButtonTypeCustom];
        _userNameBut=userNameBut;
        
        
        //个性签名
        UIButton    * personalizedSignatureBut   = [UIButton buttonWithType:UIButtonTypeCustom];
        _personalizedSignatureBut                = personalizedSignatureBut;
        
        UIButton    * registerBut=[UIButton buttonWithType:UIButtonTypeCustom];
        _registerBut                             = registerBut;
        
        //UITableView
        UITableView * tableView                  = [[UITableView alloc]initWithFrame:CM(0, 0, 0, 0) style:UITableViewStyleGrouped];
        tableView.tableHeaderView                = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 60)];
        _tableView                               = tableView;
        
        //登录
        UIButton    * signInBut                  = [UIButton buttonWithType:UIButtonTypeCustom];
        _signInBut                               = signInBut;
        
        
        [self addSubview:closeMenuBut];//关闭菜单按钮
        [self addSubview:backgroundImageView];//添加背景图
        
        [backgroundImageView addSubview:userImageView];//用户头像
        [backgroundImageView addSubview:userNameBut];//用户昵称
        [backgroundImageView addSubview:personalizedSignatureBut];//个性签名
        [backgroundImageView addSubview:registerBut];//注册
        _tapGesture                             = [[UITapGestureRecognizer alloc]init];
        [self addSubview:tableView];//TableView
        [tableView.tableHeaderView addSubview:_signInBut];//登录
        [self initVar];
    }
    return self;
}
-(void)initVar
{
    _arrayI                              = @[@"我的收藏",@"我的发布",@"我的订阅"];
    _arrayII                             = @[@"意见反馈",@"设置"];
    _second                              = 0.4;
    _isAnimation                         = NO;//动画状态
    //注意：对象只创建一次 避免重复创建节省内存、
    _userInformation                     = [NSUserDefaults standardUserDefaults];
    _userInformationData                 = [_userInformation valueForKey:@"用户信息"];
    _model                               = [NSKeyedUnarchiver unarchiveObjectWithData:_userInformationData];
}
-(void)layoutSubviews
{
    [self setViewFrame];
    [self setViewtData];
}
#pragma mark============初始化View 位置==============
-(void)setViewFrame
{
    CGFloat viewW                                   = self.frame.size.width;
    CGFloat viewH                                   = self.frame.size.height;
    _closeMenuBut.frame                             = [UIScreen  mainScreen].bounds;

    CGFloat margin                                  = 30;//边距
    //背景图
    CGFloat backgroundImageViewX                    = 0;
    CGFloat backgroundImageViewY                    = 0;
    CGFloat backgroundImageViewW                    = viewW/1.4;
    CGFloat backgroundImageViewH                    = viewH/3.5;
    _backgroundImageView.frame                      = CM(backgroundImageViewX, backgroundImageViewY, backgroundImageViewW, backgroundImageViewH);
    
   
    //头像
    CGFloat userImageX                              = margin;
    CGFloat userImageY                              = backgroundImageViewH/4;
    CGFloat userImageW                              = backgroundImageViewH/3;
    //圆角的半径
    _userImageView.layer.cornerRadius               = userImageW/2;
    CGFloat userImageH                              = userImageW;
    _userImageView.frame                            = CM(userImageX, userImageY, userImageW, userImageH);
    //用户名称
    CGFloat userNameButX                            = margin-5;
    CGFloat userNameButY                            = CGRectGetMaxY(_userImageView.frame)+10;
    CGFloat userNameButW                            = 80;
    CGFloat userNameButH                            = 20;
    _userNameBut.frame                              = CM(userNameButX, userNameButY, userNameButW, userNameButH);
    
    //个性签名
    CGFloat personalizedSignatureButX               = 15;
    CGFloat personalizedSignatureButY               = CGRectGetMaxY(_userNameBut.frame)+10;
    CGFloat personalizedSignatureButW               = 160;
    CGFloat personalizedSignatureButH               = 20;
    _personalizedSignatureBut.frame                 = CM(personalizedSignatureButX, personalizedSignatureButY, personalizedSignatureButW, personalizedSignatureButH);
    //注册
    CGFloat registerButX                            = CGRectGetMaxX(_personalizedSignatureBut.frame)+5;
    CGFloat registerButH                            = 30;
    CGFloat registerButY                            = CGRectGetMaxY(_personalizedSignatureBut.frame)-registerButH;
    CGFloat registerButW                            = 80;
    _registerBut.frame                              = CM(registerButX, registerButY, registerButW, registerButH);
    
    //tableView
    CGFloat tableViewX                              = 0;
    CGFloat tableViewY                              = CGRectGetMaxY(_backgroundImageView.frame);
    CGFloat tableViewW                              = backgroundImageViewW ;
    CGFloat tableViewH                              = viewH-CGRectGetMaxY(_backgroundImageView.frame);
    _tableView.frame                                = CM(tableViewX, tableViewY, tableViewW, tableViewH);
    
    //登录
    CGFloat signInButX                              = 40;
    CGFloat signInButY                              = 10;
    CGFloat signInButW                              = backgroundImageViewW-signInButX*2;
    CGFloat signInButH                              = 40;
    _signInBut.frame                                = CM(signInButX, signInButY, signInButW, signInButH);
    
    
    
}
#pragma mark +++++++++++++初始化View数据+++++++++++++
-(void)setViewtData
{
    
    if (_model)
    {
        //设置头像数据
        [_userImageView sd_setImageWithURL:[NSURL URLWithString:_model.avatar] placeholderImage:[UIImage imageNamed:@"头像"]];
        [_userNameBut setTitle:_model.nickname forState:UIControlStateNormal];
        [_personalizedSignatureBut setTitle:[NSString stringWithFormat:@"个性签名:%@",_model.note] forState:UIControlStateNormal];
    }
    if  (!_model)
    {
        //设置头像数据
        _userImageView.image = [UIImage imageNamed:@"头像"];
        [_userNameBut setTitle:@"未登录" forState:UIControlStateNormal];
        [_personalizedSignatureBut setTitle:@"个性签名:欢迎来到火鸡岛"forState:UIControlStateNormal];
    }

    
    [_closeMenuBut addTarget:self action:@selector(closeMenuBut:) forControlEvents:UIControlEventTouchUpInside];//关闭菜单
    //背景图
    _backgroundImageView.image                     = [UIImage imageNamed:@"星空"];
    _backgroundImageView.userInteractionEnabled    = YES;
    _userImageView.layer.masksToBounds             = YES;//是否显示圆角以外的部分
    _userImageView.layer.borderWidth               = 2;//边框宽度
    _userImageView.layer.borderColor               = USERPROFILE_Color;//边框颜色
    _userImageView.userInteractionEnabled          = YES;//支持用户交互
    [_tapGesture addTarget:self action:@selector(handLetap:)];//头像手势
    [_userImageView addGestureRecognizer:_tapGesture];//将手势添加在头像上
    
    //用户名称
    [_userNameBut setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_userNameBut setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    [_userNameBut addTarget:self action:@selector(MenuButton:) forControlEvents:UIControlEventTouchUpInside];
    //个性签名Button
    _personalizedSignatureBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;//button字体左边对其
    _personalizedSignatureBut.titleLabel.font=[UIFont systemFontOfSize:13];
  
    //注册
    _registerBut.layer.borderColor   = [UIColor whiteColor].CGColor;
    _registerBut.layer.borderWidth   = 1;
    _registerBut.layer.cornerRadius  = 4;
    [_registerBut setTitle:@"快速注册" forState:UIControlStateNormal];
    [_registerBut setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [_registerBut addTarget:self action:@selector(registerBut:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //tableView
    _tableView.delegate             = self;
    _tableView.dataSource           = self;
    _tableView.scrollEnabled        = YES; //设置tableview 不能滚动
    
    _signInBut.backgroundColor      = Color(235, 130, 133, 1);
    _signInBut.layer.cornerRadius   = 20;
    [_signInBut setTitle:@"登录" forState:UIControlStateNormal];
    [_signInBut setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [_signInBut addTarget:self action:@selector(signInBut:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
    {
        return _arrayI.count;
    }else{
        return _arrayII.count;
    }
    return 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    TXMenuTableViewCell * cell=[[TXMenuTableViewCell alloc]initWithTableView:tableView];
    if (indexPath.section==0)
    {
        cell.icon.image=[UIImage imageNamed:_arrayI[indexPath.row]];
        cell.titleLabel.text=_arrayI[indexPath.row];
    }
    
    if (indexPath.section==1)
    {
        cell.icon.image=[UIImage imageNamed:_arrayII[indexPath.row]];
        cell.titleLabel.text=_arrayII[indexPath.row];
    }
    //背景透明
    _tableView.alpha=1;
    cell.backgroundColor=[UIColor clearColor];
   //返回单元格
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"菜单 Cell被点击啦");
}
#pragma mark -------头像点击事件---------
-(void)handLetap:(UITapGestureRecognizer*)sender
{
    TXPersonalCenterViewController * personalCenterViewController = [[TXPersonalCenterViewController alloc]init];
    [self.getController presentViewController:personalCenterViewController animated:YES completion:nil];
    NSLog(@"用户头像");
}
#pragma mark -------用户昵称按钮点击事件--------
-(void)MenuButton:(UIButton *)sender
{
    
    NSLog(@"用户昵称按钮");
}
#pragma mark -------注册按钮点击事件--------
-(void)registerBut:(UIButton * )but
{
    TXRegisteredViewController  * registeredViewController = [[TXRegisteredViewController alloc]init];
    [self.getController presentViewController:registeredViewController animated:NO completion:nil];
    NSLog(@"注册按钮");
}
#pragma mark -------登录按钮点击事件--------
-(void)signInBut:(UIButton*)but
{
    TXSignInViewController     * signInViewController      = [[TXSignInViewController alloc]init];
    [self.getController presentViewController:signInViewController animated:NO completion:nil];
    NSLog(@"登录");
}
//动画
-(void)animation
{
    CGFloat viewW            = self.frame.size.width;
    CGFloat viewX            = -viewW;
    CGFloat viewY            = 0;
    CGFloat viewH            = self.frame.size.height;
    if (self.isAnimation==NO)
    {
        [UIView animateWithDuration:_second animations:^{
            self.frame=CGRectMake(0, viewY, viewW,viewH);
            self.isAnimation = YES;
        }];
    }else if (self.isAnimation==YES)
    {
        
        [UIView animateWithDuration:_second animations:^{
            self.frame       = CGRectMake(viewX, viewY, viewW, viewH);
            self.isAnimation = NO;
        }];
        
        
    }
}
-(void)closeMenuBut:(UIButton*)but
{
    CGFloat viewW           = self.frame.size.width;
    CGFloat viewX           = -viewW;
    CGFloat viewY           = 0;
    CGFloat viewH           = self.frame.size.height;
    [UIView animateWithDuration:_second animations:^
     {
         self.frame         = CM(viewX, viewY, viewW, viewH);
         self.isAnimation   = NO;
     }];
    
}

@end
