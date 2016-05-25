//
//  TXPersonalCenterViewController.h
//  HuoJiDao
//
//  Created by IOS开发 on 16/5/21.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXViewController.h"
#import "TXSignInNavigationView.h"
@interface TXPersonalCenterViewController : TXViewController
@property(nonatomic,strong)TXSignInNavigationView * signInNavigationView;
@property(nonatomic,strong)UITableView            * tableView;
@end
