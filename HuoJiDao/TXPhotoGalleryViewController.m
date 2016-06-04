//
//  TXPhotoGalleryViewController.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/5/30.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXPhotoGalleryViewController.h"
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "TXPersonalCenterViewController.h"
@interface TXPhotoGalleryViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UIToolbar            * toolBar;
@property(nonatomic,strong)UIBarButtonItem      * itemLeft;
@property(nonatomic,strong)UIBarButtonItem      * itemRight;
@property(nonatomic, strong)NSMutableArray      * images;//存储相册图片
@property(nonatomic, strong)UICollectionView    * collectView;
@property(nonatomic, strong)NSMutableArray      * selectedImageIndex;//存储选择的图片索引
@end

@implementation TXPhotoGalleryViewController
-(void)setNavigationView
{
    CGFloat  registeredNavigationViewX        = 0;
    CGFloat  registeredNavigationViewY        = 0;
    CGFloat  registeredNavigationViewW        = self.view.frame.size.width;
    CGFloat  registeredNavigationViewH        = 64;
    _registeredNavigationView                 = [[TXRegisteredNavigationView alloc]init];
    _registeredNavigationView.frame           = CM(registeredNavigationViewX, registeredNavigationViewY, registeredNavigationViewW, registeredNavigationViewH);
    _registeredNavigationView.titleLabel.text = @"相册胶卷";
    [self.view addSubview:_registeredNavigationView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addToolBar];
    [self reloadImagesFromLibrary];
    

}
-(void)initVar
{
    _selectedImageIndex     = [NSMutableArray array];
}
-(void)addToolBar
{
    CGFloat viewW           = self.view.frame.size.width;
    CGFloat viewH           = self.view.frame.size.height;
    CGFloat toolBarW        = viewW;
    CGFloat toolBarH        = 44;
    CGFloat toolBarX        = 0;
    CGFloat toolBarY        = viewH-toolBarH;
    _toolBar                = [[UIToolbar alloc]initWithFrame:CM(toolBarX, toolBarY, toolBarW, toolBarH)];
    _itemLeft               = [[UIBarButtonItem alloc]initWithTitle:@"预览" style:UIBarButtonItemStyleDone target:self action:@selector(itemLeft:)];
    UIBarButtonItem * mid   = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];//弹簧
    _itemRight              = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(itemRight:)];
    _toolBar.items          = @[_itemLeft,mid,_itemRight];
    [self.view addSubview:_toolBar];
    
    
}
-(void)layoutView
{
    CGFloat collectionX                 = 0;
    CGFloat collectionY                 = _registeredNavigationView.frame.size.height;
    CGFloat collectionW                 = self.view.frame.size.width;
    CGFloat collectionH                 = self.view.frame.size.height-collectionY-44;
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    _collectView                        = [[UICollectionView alloc]initWithFrame:CM(collectionX, collectionY, collectionW, collectionH) collectionViewLayout:layout];
    [_collectView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    _collectView.dataSource             = self;
    _collectView.delegate               = self;
    _collectView.backgroundColor        = [UIColor whiteColor];
    [self.view addSubview:_collectView];
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_images count];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell         = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    UIView * viewR                      = [cell viewWithTag:100];
    [viewR removeFromSuperview];
    
    UIImageView * imageVeiw             = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 87.5, 87.5)];
    
    imageVeiw.contentMode               = UIViewContentModeScaleToFill;//平铺
    imageVeiw.clipsToBounds             = YES;//去除交叉部分
    
    UIView * view                       = [[UIView alloc]initWithFrame:imageVeiw.frame];
    view.tag=100;
    [view addSubview:imageVeiw];
    imageVeiw.image                     = _images[indexPath.row];
    imageVeiw.userInteractionEnabled    = YES;
    //图片右上角选择按钮
    UIButton *checkButton               = [[UIButton alloc]initWithFrame:CGRectMake(62.5, 5, 20, 20)];
    if ([_selectedImageIndex containsObject:@(indexPath.row)]){
        [checkButton setImage:[UIImage imageNamed:@"iconfont-ck-true"] forState:UIControlStateNormal];
    }
    else{
        [checkButton setImage:[UIImage imageNamed:@"iconfont-xuanze"] forState:UIControlStateNormal];
    }
    [imageVeiw addSubview:checkButton];
    checkButton.tag = indexPath.row;
    [checkButton addTarget:self action:@selector(selectImage:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview: view];
    return cell;

                             
}
//图片选择,取消选择
- (void)selectImage : (UIButton *)button
{
    //取消选中
    if ([_selectedImageIndex containsObject:@(button.tag)])
    {
        [_selectedImageIndex removeObject:@(button.tag)];
        [button setImage:[UIImage imageNamed:@"iconfont-xuanze"] forState:UIControlStateNormal];
    }
    //选中
    else
    {
        if([_selectedImageIndex count] == 1)
        {
            return;//最多选择9张
        }
        [_selectedImageIndex addObject:@(button.tag)];
        _itemLeft.tag       = button.tag;
        _itemRight.tag      = button.tag;
        [button setImage:[UIImage imageNamed:@"iconfont-ck-true"] forState:UIControlStateNormal];
    }
    NSLog(@"当前选中的图片数量: %ld", [_selectedImageIndex count]);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(87.5, 87.5);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5.0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 0, 5);
}
-(void)reloadImagesFromLibrary
{
    self.images=[NSMutableArray array];
    
//    PHFetchResult * smartAlbums=[PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
//    PHFetchResult * topLevelUserCollections=[PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
    
    
    //获取所有资源的集合
    PHFetchOptions * options               = [[PHFetchOptions alloc]init];
    options.sortDescriptors                = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    PHFetchResult * assetsFetchResults     = [PHAsset fetchAssetsWithOptions:options];//抓取符合条件的，存到assetsFetchResults中类似数组
    //在资源的集合中获取其中的图片
    PHCachingImageManager * imageManager   = [[PHCachingImageManager alloc]init];
    PHImageRequestOptions * requestOptions = [[PHImageRequestOptions alloc]init];
    
    requestOptions.synchronous=YES;
    
    for (int i=0; i<assetsFetchResults.count; i++)
    {
        PHAsset * asset=assetsFetchResults[i];
        
        CGSize somsSize=CGSizeMake(120, 120);
        [imageManager requestImageForAsset:asset targetSize:somsSize contentMode:PHImageContentModeAspectFill options:requestOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            
            [_images addObject:result];
            
            //当相册所有图片加载完毕，开始布局界面
            if ([_images count] == [assetsFetchResults count]) {
                [self layoutView];
            }
        }];
    }
}
-(void)itemLeft:(UIBarButtonItem*)barButton
{
    
    
    NSLog(@"%li",(long)barButton.tag);
}
-(void)itemRight:(UIBarButtonItem*)barButton
{
    TXPersonalCenterViewController * personalCenterViewControlle=[[TXPersonalCenterViewController alloc]init];
    [self presentViewController:personalCenterViewControlle animated:YES completion:^{
        
        NSData * imageData    = UIImageJPEGRepresentation(_images[barButton.tag],1);
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        [user setObject:imageData forKey:@"icon"];
    }];
    NSLog(@"%li",(long)barButton.tag);
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
