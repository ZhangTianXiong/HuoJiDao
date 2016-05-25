//
//  TXMenuVIew.h
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/14.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXView.h"
@interface TXMenuView :TXView
@property(nonatomic,assign)BOOL         isAnimation;
//UI布局
@property(nonatomic,strong)UIImageView * backgroundImageView;
@property(nonatomic,strong)UIImageView * userImageView;//用户头像
@property(nonatomic,strong)UIButton    * userNameBut;//用户昵称
@property(nonatomic,strong)UIButton    * personalizedSignatureBut;//个性签名
@property(nonatomic,strong)UIButton    * registerBut;//注册
@property(nonatomic,strong)UIButton    * signInBut;//登录
@property(nonatomic,strong)UITableView * tableView;//TableView

@property(nonatomic,strong)UIButton    * closeMenuBut;//关闭菜单
-(void)animation;
//手势

@end
