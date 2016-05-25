//
//  TXSignInViewController.h
//  HuoJiDao
//
//  Created by IOS开发 on 16/5/17.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXViewController.h"
#import "TXSignInNavigationView.h"
#import "TXSignInbackgroundView.h"
#import "TXRegisteredViewController.h"
@interface TXSignInViewController : TXViewController
@property(nonatomic,strong)TXSignInNavigationView * signInNavigationView;
@property(nonatomic,strong)TXSignInbackgroundView * signInbackgroundView;
@end
