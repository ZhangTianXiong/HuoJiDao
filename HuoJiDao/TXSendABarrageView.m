//
//  TXSendABarrage.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/5/26.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXSendABarrageView.h"
@interface TXSendABarrageView ()<UITextFieldDelegate>
@end
@implementation TXSendABarrageView

-(instancetype)init
{
    if (self =[super init])
    {
        UITextField * textField = [[UITextField alloc]init];
        textField.delegate=self;
        _textField=textField;
        UIButton * sendBut=[UIButton buttonWithType:UIButtonTypeCustom];
        _sendBut=sendBut;
        
        [self addSubview:textField];
        [self addSubview:sendBut];
    }
    return self;
}

-(void)layoutSubviews
{
    [self setViewFrame];
    [self setViewData];
}
-(void)setViewFrame
{
    CGFloat viewW=self.frame.size.width;
    CGFloat viewH=self.frame.size.height;
    
    CGFloat margin=10;
    CGFloat sendButW=60;
    
    CGFloat textFieldX=margin;
    CGFloat textFieldH=viewH/1.5;
    CGFloat textFieldW=(viewW-margin*3-sendButW);
    CGFloat textFieldY=(viewH-textFieldH)/2;
    _textField.frame=CM(textFieldX, textFieldY, textFieldW, textFieldH);
    
    
    CGFloat sendButX=CGRectGetMaxX(_textField.frame)+margin;
    CGFloat sendButY=textFieldY;
    CGFloat sendButH=textFieldH;
    _sendBut.frame=CM(sendButX, sendButY, sendButW, sendButH);
   
}
-(void)setViewData
{
    _textField.backgroundColor=[UIColor grayColor];
    _textField.layer.cornerRadius=4;
    _sendBut.backgroundColor=[UIColor grayColor];
    _sendBut.layer.cornerRadius=4;
    [_sendBut setTitle:@"发送" forState:UIControlStateNormal];
    [_sendBut setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    return YES;
    
}
@end
