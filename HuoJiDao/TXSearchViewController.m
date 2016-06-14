//
//  TXSearchViewController.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/29.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXSearchViewController.h"
#import "TXExhibitionController.h"
#import "TXRequestData.h"
#import "TXSearchTableViewCell.h"
@interface TXSearchViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    TXRequestData             * _data;
    NSNotificationCenter      * _notifiction;//通知中心
    TXListFrameModel          * _frameModel;//数据模型
    TXExhibitionController    * _exhibition;//详情Controller
}
@end

@implementation TXSearchViewController
//重写导航栏
-(void)setNavigationView
{
    _searchNavigationView                 = [[TXSearchNavigationView alloc ]init];
    _searchNavigationView.frame           = NavigationView_Frame;
    _searchNavigationView.backgroundColor = Navigation_Color;
    [self.view addSubview:_searchNavigationView];
    [self setNavigationViewData];
}
-(void)setNavigationViewData
{
    //设置返回按钮
    [_searchNavigationView.backBut setImage:[UIImage imageNamed:@"Back"] forState:UIControlStateNormal];
    [_searchNavigationView.backBut addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    //设置icon
    _searchNavigationView.icon.image            = [UIImage imageNamed:@"012_03"];
    //设置textfield水印
    _searchNavigationView.textField.placeholder = @"请输入关键词或编号";
    //设置搜索按钮
    [_searchNavigationView.searchBut setTitle:@"搜索" forState:UIControlStateNormal];
    [_searchNavigationView.searchBut addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
    [_searchNavigationView.searchBut setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    //设置取消按钮
    [_searchNavigationView.cancelBut setTitle:@"取消" forState:UIControlStateNormal];
    [_searchNavigationView.cancelBut addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [_searchNavigationView.cancelBut setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    
}

-(void)initData
{
    _data        = [[TXRequestData alloc]init];
    _notifiction = [NSNotificationCenter defaultCenter];
    [_notifiction addObserver:self selector:@selector(requestSeachDataComplete) name:@"RequestSeachDataComplete" object:nil];
    

}
#pragma mark--------------返回按钮点击事件--------------
-(void)back:(UIButton*)but
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)cancel:(UIButton*)but
{
    but.hidden                              = YES;
    _searchNavigationView.searchBut.hidden  = NO;
    NSLog(@"取消");
    
}
-(void)search:(UIButton*)but
{
    
    but.hidden=YES;
    _searchNavigationView.cancelBut.hidden = NO;
    [_data requestSeachDataWithString: _searchNavigationView.textField.text];
     NSLog(@"搜索");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor   = [UIColor whiteColor];
    [self addVideoTableView];
}
-(void)addVideoTableView
{
    CGFloat allTableViewX  = 0;
    CGFloat allTableViewY  = 64;
    CGFloat allTableViewW  = self.view.frame.size.width;
    CGFloat allTableViewH  = self.view.frame.size.height-allTableViewY;
    _searchtableView       = [[UITableView alloc]initWithFrame:CM(allTableViewX, allTableViewY, allTableViewW, allTableViewH) style:UITableViewStylePlain];
    [self.view addSubview:_searchtableView];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.seachFrameModel.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==0)
    {
        _exhibition                         = [[TXExhibitionController alloc]init];
        _exhibition.modalTransitionStyle    =  UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:_exhibition animated:YES completion:nil];
        _frameModel                         = _data.seachFrameModel[indexPath.row];
        [_notifiction postNotificationName:@"gitModel" object:self userInfo:@{
                                                                              @"model":_frameModel.model
                                                                              }];
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    _frameModel        = _data.seachFrameModel[indexPath.row];
    return _frameModel.rowH;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==0)
    {
        //创建模型
        _frameModel                     = _data.seachFrameModel[indexPath.row];
        //创建cell
        TXSearchTableViewCell * cell    = [TXSearchTableViewCell allWithTableView:tableView];
        //设置单元格数据
        cell.framemodel                 = _frameModel;
        //返回cell
        return cell;
        
    }
    return nil;
}


-(void)requestSeachDataComplete
{
    _searchtableView.tag                            = 0;
    _searchtableView.showsVerticalScrollIndicator   = NO;
    _searchtableView.showsHorizontalScrollIndicator = NO;
    _searchtableView.delegate                       = self;
    _searchtableView.dataSource                     = self;
}
- (void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
