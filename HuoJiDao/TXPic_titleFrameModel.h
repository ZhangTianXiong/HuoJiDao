//
//  TXPic_titleFrameModel.h
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/25.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NSString+TXCalculateSize.h"
#import "TXPic_title.h"

@interface TXPic_titleFrameModel : NSObject



@property(nonatomic,strong)TXPic_title *    pic_titleModel;

@property(nonatomic,assign,readonly)CGRect  titleLabelFrame;
@property(nonatomic,assign,readonly)CGRect  pictureImageFrame;
@property(nonatomic,assign,readonly)CGRect  functionBarViewFrame;

@property(nonatomic,assign,readonly)CGFloat rowH;//计算行高

-(instancetype)initWithModel:(TXPic_title*)pic_titleModel;
+(instancetype)pic_titleWithModel:(TXPic_title*)pic_titleModel;

@end
