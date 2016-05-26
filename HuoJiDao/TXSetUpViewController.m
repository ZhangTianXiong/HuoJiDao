//
//  TXSetUpViewController.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/5/25.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXSetUpViewController.h"
#import "TXSetUpTableViewCell.h"
#import "HomeController.h"
@interface TXSetUpViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray         * _sectionsTitlec;
    NSArray         * _sectionsI;
    NSArray         * _sectionsII;
    NSArray         * _sectionsIII;
    HomeController  * _homeViewController;
    NSUserDefaults * _userDefaults;
}
@property(nonatomic,strong)UIButton * signOut;
@end

@implementation TXSetUpViewController
#pragma mark==================设置导航栏==================
-(void)setNavigationView
{
    CGFloat  registeredNavigationViewX        = 0;
    CGFloat  registeredNavigationViewY        = 0;
    CGFloat  registeredNavigationViewW        = self.view.frame.size.width;
    CGFloat  registeredNavigationViewH        = 64;
    _registeredNavigationView                 = [[TXRegisteredNavigationView alloc]init];
    _registeredNavigationView.frame           = CM(registeredNavigationViewX, registeredNavigationViewY, registeredNavigationViewW, registeredNavigationViewH);
    _registeredNavigationView.titleLabel.text = @"设置";
    [self.view addSubview:_registeredNavigationView];
}
#pragma mark==================初始化View==================
-(void)initView
{
    CGFloat tableViewX                          = 0;
    CGFloat tableViewY                          = _registeredNavigationView.frame.size.height;
    CGFloat tableViewW                          = self.view.frame.size.width;
    CGFloat tableViewH                          = self.view.frame.size.height-_registeredNavigationView.frame.size.height;
    _tableView                                  = [[UITableView alloc]initWithFrame:CM(tableViewX, tableViewY, tableViewW, tableViewH) style:UITableViewStyleGrouped];
    _tableView.delegate                         = self;
    _tableView.dataSource                       = self;
    _tableView.tableFooterView                  = [[UIView alloc]initWithFrame:CM(0, 0, 0, tableViewH/2.5)];
    [self.view addSubview:_tableView];
    
    
    CGFloat signOutX                            = 0;
    CGFloat signOutY                            = (_tableView.tableFooterView.frame.size.height-60);
    CGFloat signOutW                            = (_tableView.tableFooterView.frame.size.width);
    CGFloat signOutH                            = 40;
    _signOut                                    = [UIButton buttonWithType:UIButtonTypeCustom];
    _signOut.frame                              = CM(signOutX, signOutY, signOutW, signOutH);
    [self.tableView.tableFooterView addSubview:_signOut];
    _signOut.backgroundColor                    = [UIColor whiteColor];
    [_signOut setTitle:@"退出登录" forState:UIControlStateNormal];
    [_signOut setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_signOut setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [_signOut addTarget:self action:@selector(signOut:) forControlEvents:UIControlEventTouchUpInside];
   
}
#pragma mark++++++++++++++初始化数据++++++++++++++
-(void)initData
{
    _sectionsTitlec     = @[@"播放相关",@"其他设置",@"帮助支持"];
    _sectionsI          = @[@"允许移动网络下播放",@"显示弹幕"];
    _sectionsII         = @[@"清除缓存"];
    _sectionsIII        = @[@"关于我们"];
}
#pragma mark++++++++++++++初始化变量++++++++++++++
-(void)initVar
{
    _userDefaults=[NSUserDefaults standardUserDefaults];
  
}
- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    // Do any additional setup after loading the view.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _sectionsTitlec.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
    {
        return _sectionsI.count;
    }else if (section==1)
    {
        return _sectionsII.count;
    }else
    {
        return _sectionsIII.count;
    }
    
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return _sectionsTitlec[section];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    TXSetUpTableViewCell * cell=[[TXSetUpTableViewCell alloc]initWithTableView:tableView];
    
    if (indexPath.section==0)
    {
        cell.titleLabel.text=_sectionsI[indexPath.row];
        cell.mySwitch.tag=indexPath.row;
        [cell.mySwitch addTarget:self action:@selector(mySwitch:) forControlEvents:UIControlEventValueChanged];
        
        if (cell.mySwitch.tag==0) {
            cell.mySwitch.on=[[_userDefaults valueForKey:@"whetherToAllowMobileNetworkBroadcast"] intValue];//是否允许移动网络下播放
        }
        
        if (cell.mySwitch.tag==1)
        {
            cell.mySwitch.on=[[_userDefaults valueForKey:@"whetherToAllowDisplayBarrage"] intValue];//是否允许显示弹幕
        }
        
    }else if (indexPath.section==1)
    {
        cell.titleLabel.text=_sectionsII[indexPath.row];
        cell.mySwitch.hidden=YES;
    }else
    {
        cell.titleLabel.text=_sectionsIII[indexPath.row];
        cell.mySwitch.hidden=YES;
        
    }
    return cell;
}
#pragma mark-----------开关-----------
-(void)mySwitch:(UISwitch*)mySwitch
{
    switch (mySwitch.tag)
    {
        case 0:
        {
           
            if (mySwitch.isOn==NO)
            {
                NSLog(@"不允许网络下播放视频");
                [_userDefaults setValue:@"0" forKey:@"whetherToAllowMobileNetworkBroadcast"];
                mySwitch.on=NO;
            }else
            {
                NSLog(@"允许网络下播放视频");
                [_userDefaults setValue:@"1" forKey:@"whetherToAllowMobileNetworkBroadcast"];
                mySwitch.on=YES;
                
            }

            
        }
            break;
         case 1:
        {
            
            if (mySwitch.isOn==NO)
            {
                NSLog(@"不显示弹幕");
                [_userDefaults setValue:@"0" forKey:@"whetherToAllowDisplayBarrage"];
                mySwitch.on=NO;
            }else
            {
                NSLog(@"显示弹幕");
                [_userDefaults setValue:@"1" forKey:@"whetherToAllowDisplayBarrage"];
                mySwitch.on=YES;
                
            }
            
        }
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
#pragma mark-----------退出登录-----------
-(void)signOut:(UIButton*)but
{
    _homeViewController=[[HomeController alloc]init];
    [self presentViewController:_homeViewController animated:NO completion:^{
        NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
        [userDefaults removeObjectForKey:@"用户信息"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"个人中心" object:self];
    }];
}

@end
