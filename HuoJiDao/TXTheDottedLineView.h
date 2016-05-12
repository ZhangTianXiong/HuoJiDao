//
//  TXView.h
//  创建View虚线
//
//  Created by IOS开发 on 16/4/26.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TXView.h"
@class TXTheDottedLineView;

@protocol  TXTheDottedLineViewDelegate<NSObject>

-(void)theDottedLineView:(TXTheDottedLineView*)theDottedLineView Button:(UIButton*)but;


@end
@interface TXTheDottedLineView :TXView

@property(nonatomic,weak)UIImageView           * icon;//创建频道图标
@property(nonatomic,weak)UILabel               * label;//创建频道名称
@property(nonatomic,weak)UIButton              * but;//创建频道点击事件
@property(nonatomic,weak)CAShapeLayer          * borderLayer ;//创建自定义的层
@property(nonatomic,strong)id<TXTheDottedLineViewDelegate>  delegate;
@property(nonatomic,assign)BOOL state;
@end
