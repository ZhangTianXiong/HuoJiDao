//
//  TXUserCollectViewController.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/6/7.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXUserCollectViewController.h"
#import "WJSegmentMenuVc.h"
#import "TXUserAllViewController.h"
#import "TXUserVideoViewController.h"
#import "TXUserPictureViewController.h"
#import "TXUserLinkViewController.h"
@interface TXUserCollectViewController ()

@end

@implementation TXUserCollectViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.titleLabel.text        = @"收藏";
    self.view.backgroundColor   = [UIColor whiteColor];
    [self viewLayout];
    
}
-(void)viewLayout
{
    /* 创建WJSegmentMenuVc */
    CGFloat viewW                   = self.view.frame.size.width;
    CGFloat viewH                   = self.view.frame.size.height;
    
    CGFloat segmentMenuVcX          = 0;
    CGFloat segmentMenuVcY          = 64;
    CGFloat segmentMenuVcW          = viewW;
    CGFloat segmentMenuVcH          = 40;
    WJSegmentMenuVc *segmentMenuVc  = [[WJSegmentMenuVc alloc]initWithFrame:CGRectMake(segmentMenuVcX,segmentMenuVcY, segmentMenuVcW, segmentMenuVcH)];
    [self.view addSubview:segmentMenuVc];
    
    /* 自定义设置(可不设置为默认值) */
    segmentMenuVc.backgroundColor   = [UIColor colorWithRed:240/250.0 green:240/250.0 blue:240/250.0 alpha:1];
    segmentMenuVc.titleFont         = [UIFont systemFontOfSize:13];
    segmentMenuVc.unlSelectedColor  = [UIColor darkGrayColor];
    segmentMenuVc.selectedColor     = [UIColor darkGrayColor];
    segmentMenuVc.MenuVcSlideType   = 0;
    segmentMenuVc.SlideColor        = [UIColor greenColor];
    segmentMenuVc.advanceLoadNextVc = YES;
    
    NSArray * titleArr              = @[@"全部",@"视频",@"图片",@"文章"];
    
    TXUserAllViewController     * allViewController     = [[TXUserAllViewController alloc]init];
    TXUserVideoViewController   * vidoViewController    = [[TXUserVideoViewController alloc]init];
    TXUserPictureViewController * pictureViewController = [[TXUserPictureViewController alloc]init];
    TXUserLinkViewController    * linkViewController    = [[TXUserLinkViewController alloc]init];
    
    NSArray * controllerArr = @[allViewController,vidoViewController,pictureViewController,linkViewController];
    
    [segmentMenuVc addSubVc:controllerArr subTitles:titleArr];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
