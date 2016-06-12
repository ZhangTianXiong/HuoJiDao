//
//  TXFeedbackViewController.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/6/12.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXFeedbackViewController.h"

@interface TXFeedbackViewController ()<UITextViewDelegate>
{
    UITextView    * _textView;
    UITextField   * _textField;
}
@end

@implementation TXFeedbackViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.titleLabel.text        = @"反馈";
    self.view.backgroundColor   = Color(242, 242, 242, 1);
    [self viewLayout];
}
-(void)viewLayout
{
    CGFloat margin                  = 10;
    CGFloat textViewX               = margin;
    CGFloat textViewY               = 64+20;
    CGFloat textViewW               = self.view.frame.size.width-margin*2;
    CGFloat textViewH               = self.view.frame.size.height/2.5;
    _textView                       = [[UITextView alloc]init];
    _textView.frame                 = CM(textViewX, textViewY, textViewW, textViewH);
    _textView.layer.cornerRadius    = 5;
    _textView.textColor             = [UIColor lightGrayColor];//设置提示内容颜色
    _textView.text                  = NSLocalizedString(@"请详细描述问题，填写至少大于15个字。", nil);//提示语
    _textView.delegate=self;
    
    
    CGFloat textFieldX              = margin;
    CGFloat textFieldY              = CGRectGetMaxY(_textView.frame)+margin*2;
    CGFloat textFieldW              = textViewW;
    CGFloat textFieldH              = 40;
    _textField                      = [[UITextField alloc]init];
//    [_textField setValue:[UIFont boldSystemFontOfSize:11] forKeyPath:@"_placeholderLabel.font"];
    _textField.placeholder          = @"联系方式:邮箱,QQ,手机号(选填)";
    _textField.layer.cornerRadius   = 4;
    _textField.backgroundColor      = [UIColor whiteColor];
    _textField.frame                = CM(textFieldX, textFieldY, textFieldW, textFieldH);
    
    
    
    
    CGFloat buttonX                 = margin;
    CGFloat buttonY                 = CGRectGetMaxY(_textField.frame)+margin*4;
    CGFloat buttonW                 = textViewW;
    CGFloat buttonH                 = 50;
    UIButton * button               = [UIButton buttonWithType:UIButtonTypeCustom];
    button.layer.cornerRadius       = 7;
    [button setTitle:@"提交" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    button.backgroundColor          = Navigation_Color;
    [button addTarget:self action:@selector(SubmitBUtton) forControlEvents:UIControlEventTouchUpInside];
    button.frame                    = CM(buttonX, buttonY, buttonW, buttonH);
    
    CGFloat labelX                  = margin+20;
    CGFloat labelY                  = CGRectGetMaxY(button.frame)+margin/2;
    CGFloat labelW                  = 250;
    CGFloat labelH                  = 20;
    UILabel * label                 = [[UILabel alloc]init];
    label.font                      = [UIFont systemFontOfSize:11];
    label.text                      = @"请勿提交不良信息，否则将导致你的账号被封禁。";
    label.textColor                 = [UIColor lightGrayColor];
    label.frame                     = CM(labelX, labelY, labelW, labelH);

    
    [self.view addSubview:_textView];
    [self.view addSubview:_textField];
    [self.view addSubview:button];
    [self.view addSubview:label];
    
}
-(void)SubmitBUtton
{
    NSLog(@"提交按钮被点击");
}

- (void)didReceiveMemoryWarning {
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
