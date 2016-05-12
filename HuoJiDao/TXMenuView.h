//
//  TXMenuVIew.h
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/14.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXView.h"
#import "LLSlideMenu.h"
@interface TXMenuView :LLSlideMenu
//获取父类Controller
@property(nonatomic,strong)UIViewController * getController;
//设置属性
-(void)setWithViewWidth:(CGFloat)width// 设置菜单宽度
         BackgroundImage:(UIImage*)image// 设置菜单背图片
           SpringDamping:(CGFloat)springDamping// 阻力
          SpringVelocity:(CGFloat)springVelocity// 速度
SpringFramesNum:(CGFloat )springFramesNum;// 关键帧数量
//开始动画
-(void)startAnimation;
//UI布局
-(void)initView;
@property(nonatomic,strong)UIImageView * imageView;
@property(nonatomic,strong)UIImageView * userImageView;
@property(nonatomic,strong)UIButton    * userNameBut;
@property(nonatomic,strong)UITableView * tableView;
//手势

@end
