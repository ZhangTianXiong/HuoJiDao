//
//  TXPersonalCenterViewController.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/5/21.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXPersonalCenterViewController.h"
#import "TXPersonalCenterTableViewCell.h"
@interface TXPersonalCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray * _titleArray;
}
@end

@implementation TXPersonalCenterViewController
#pragma mark==================设置导航栏==================
-(void)setNavigationView
{
    CGFloat  signInNavigationViewX            = 0;
    CGFloat  signInNavigationViewY            = 0;
    CGFloat  signInNavigationViewW            = self.view.frame.size.width;
    CGFloat  signInNavigationViewH            = 64;
    _signInNavigationView                     = [[TXSignInNavigationView alloc]init];
    _signInNavigationView.frame               = CM(signInNavigationViewX, signInNavigationViewY, signInNavigationViewW, signInNavigationViewH);
    _signInNavigationView.titleLabel.text     = @"修改资料";
    [_signInNavigationView.rightBut setTitle:@"保存" forState:UIControlStateNormal];
    //导航栏返回按钮
    [_signInNavigationView.backBut addTarget:self action:@selector(signInNavigationViewBackBut:) forControlEvents:UIControlEventTouchUpInside];
    [_signInNavigationView.rightBut addTarget:self action:@selector(signInNavigationViewpreservationBut:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_signInNavigationView];
}
-(void)initData
{
    _titleArray                              = @[@"头像",@"性别",@"手机号"];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    // Do any additional setup after loading the view.
}
-(void)initView
{
    CGFloat viewW          = self.view.frame.size.width;
    CGFloat viewH          = self.view.frame.size.height;
    CGFloat tableViewX     = 0;
    CGFloat tableViewY     = CGRectGetMaxY(_signInNavigationView.frame);
    CGFloat tableViewW     = viewW;
    CGFloat tableViewH     = viewH-tableViewY;
    _tableView             = [[UITableView alloc]initWithFrame:CM(tableViewX, tableViewY, tableViewW,tableViewH )style:UITableViewStyleGrouped];
    
    _tableView.dataSource  = self;
    _tableView.delegate    = self;
    [self.view addSubview:_tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
    {
        return _titleArray.count;
    }
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0 && indexPath.row==0)
    {
        TXPersonalCenterTableViewCell * cell=[[TXPersonalCenterTableViewCell alloc]initWithTableView:tableView];
        cell.titleLabel.text=_titleArray[indexPath.row];
        cell.userHeadPortrait.image=[UIImage imageNamed:@"头像"];
        return cell;
    }else
    {
        static NSString * ID=@"Cell";
        
        UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:ID ];
        if (!cell)
        {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        
          cell.textLabel.text=_titleArray[indexPath.row];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}
#pragma mark----------------导航栏返回按钮----------------
-(void)signInNavigationViewBackBut:(UIButton * )but
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark----------------保存资料按钮----------------
-(void)signInNavigationViewpreservationBut:(UIButton *)but
{
    NSLog(@"保存按钮");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
