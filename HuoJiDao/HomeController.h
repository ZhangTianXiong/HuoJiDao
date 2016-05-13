//
//  ViewController.h
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/13.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Home.h"

//
//定义枚举
typedef enum
{
    homeTableViewTag   =0,//首页tag
    newestTableViewTag =1//最新推荐tag
    
}ENUM_TableView_Tag_Type;
@interface HomeController :TXViewController
//首页View
@property(nonatomic,strong)UIView         * homeView;
//最新推荐View
@property(nonatomic,strong)UIView         * newestView;
//UIScrollView
@property(nonatomic,strong)UIScrollView   * scrollView;
//首页homeTableView
@property(nonatomic,strong)UITableView    * homeTableView;
//最新推荐newestTableView
@property(nonatomic,strong)UITableView    * newestTableView;
//枚举
@property(nonatomic,assign)ENUM_TableView_Tag_Type * TableVIewTagType;


@end

