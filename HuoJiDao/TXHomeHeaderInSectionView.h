//
//  TXHomeHeaderInSectionView.h
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/21.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXView.h"
#import "TXHomeModelo.h"

@interface TXHomeHeaderInSectionView : TXView
@property(nonatomic,strong) TXHomeModelo        * model;//首页模型
@property(nonatomic,weak)   UIImageView         * icon;//SectionView图标
@property(nonatomic,weak)   UILabel             * themeLabel;//SectionView主题
@property(nonatomic,weak)   UIButton            * but;//SectionView更多按钮

@end
