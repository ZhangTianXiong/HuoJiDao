//
//  TXPictureController.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/23.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXPictureViewController.h"

@interface TXPictureViewController ()
<
UITableViewDelegate,UITableViewDataSource
>
{
    TXRequestData * data;
    TXPic_titleFrameModel * model;
    
}

@end

@implementation TXPictureViewController
-(void)initData
{
    //创建数据源
    data=[[TXRequestData alloc]init];
    //开始请求数据源
    [data requestPicTitleData];
}
#pragma mark------------添加图片TableView------------
-(void)addPicTableView
{
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat pictureTableViewX = 0;
    CGFloat pictureTableViewY = 64;
    CGFloat pictureTableViewW = self.view.frame.size.width;
    CGFloat pictureTableViewH = self.view.frame.size.height-64;
    
    
    _pictureTableView=[[UITableView alloc]initWithFrame:CM(pictureTableViewX, pictureTableViewY, pictureTableViewW, pictureTableViewH) style:UITableViewStylePlain];
    
    _pictureTableView.delegate   = self;
    _pictureTableView.dataSource = self;
    _pictureTableView.showsHorizontalScrollIndicator = NO;
    _pictureTableView.showsVerticalScrollIndicator   = NO;
    _pictureTableView.separatorStyle = NO;//隐藏分割线
    [self.view addSubview:_pictureTableView];


}
#pragma mark--------监听TableView的 行数--------------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return data.picFrameModel.count;
}
#pragma mark--------监听TableView的Cell--------------
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    model=data.picFrameModel[indexPath.row];
    //创建cell
    TXPictureTableViewCell * cell=[TXPictureTableViewCell pictureWithTableView:tableView];
    
    
    //设置单元格数据
    cell.picFrameModel=model;
    //返回单元格
    return cell;
}
#pragma mark--------监听TableView的 行高--------------
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取数据
    model=data.picFrameModel[indexPath.row];
    return model.rowH;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"图片分类的cell被点击啦");
}

#pragma mark--------viewDidLoad--------------
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    //延迟加载TableView
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)( 0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
                   {
                      [self addPicTableView];
                   });
    
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
