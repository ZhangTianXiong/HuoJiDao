//
//  TXScrollFigureView.h
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/20.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXView.h"

@interface TXScrollFigureView : TXView
//创建UIScrollView
@property(nonatomic,strong)UIScrollView   * scrollView;
//创建ImageView
@property(nonatomic,strong)UIImageView    * imageView;
//创建PageControl
@property(nonatomic,strong)UIPageControl  * pageControl;
//创建图片地址容器
@property(nonatomic,strong)NSArray * scrollFigureModel;
@end
