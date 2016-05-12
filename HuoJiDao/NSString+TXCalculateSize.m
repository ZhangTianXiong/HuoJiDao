//
//  NSString+TXCalculateSize.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/22.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "NSString+TXCalculateSize.h"

@implementation NSString (TXCalculateSize)
#pragma mark----------计算文字大小-----------------------------
-(CGSize)calculateTextSize:(CGSize)size andFoun:(UIFont*)font{
    /******
     参数1:限定内容的宽和高
     参数2:对内容计算方式
     参数3.计算内容的字体格式
     参数4.上下文
     注意：返回值是Rect
     *****/
     NSDictionary * dic = @{NSFontAttributeName:font};
    
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
}
@end
