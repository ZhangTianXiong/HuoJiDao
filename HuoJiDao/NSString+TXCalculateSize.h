//
//  NSString+TXCalculateSize.h
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/22.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (TXCalculateSize)
/**************************************************
 **  计算文字的大小：                               **
 **   参数1：限定文字的大小：一般情况填写MAXFLOAT;     **
 **   参数2：限定文字字体的大小                       **
 **   注意：在计算文字大小的时候字体必须保持一致         **
 **                                               **
 ****************************************************/
-(CGSize)calculateTextSize:(CGSize)size andFoun:(UIFont*)font;
@end
