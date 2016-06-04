//
//  TXSearchViewController.h
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/29.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXViewController.h"
#import "TXSearchNavigationView.h"
@interface TXSearchViewController : TXViewController
@property(nonatomic,strong)TXSearchNavigationView   * searchNavigationView;
@property(nonatomic,strong)UITableView              * searchtableView;

@end
