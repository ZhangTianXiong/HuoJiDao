//
//  TXRequestData.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/22.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "TXRequestData.h"
//轮播图模型
#import "TXScrollFigureModel.h"
@interface TXRequestData ()<NSURLSessionTaskDelegate>
{
    NSNotificationCenter * _requestNotifiction;
}
@end
@implementation TXRequestData
-(instancetype)init
{
    if (self=[super init])
    {
        //初始化通知中心
        _requestNotifiction=[NSNotificationCenter defaultCenter];
    }
    return self;
}
#pragma mark------------------请求首页数据------------------
-(void)requestHomeModelData
{
    if ([self respondsToSelector:@selector(requestHomeModelData)])
    {
        //轮播图数据模型
        NSMutableArray * arrScrollFigureModel=[NSMutableArray array];
        NSMutableArray * arrHomeModel=[NSMutableArray array];
        
        NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager       * manager       = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        NSURL                     * URL           = [NSURL URLWithString:ShouYe_URL];
        NSURLRequest              * request       = [NSURLRequest requestWithURL:URL];
        NSURLSessionDataTask      * dataTask      = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
            if (error)
            {
                NSLog(@"Error: %@", error);
            } else
            {
                NSLog(@"%@",response);
                //轮播图数据模型
                for (NSDictionary * dic in responseObject[@"data"][@"rollpics"])
                {
                    TXScrollFigureModel * scrollFigureModel=[[TXScrollFigureModel alloc]initWithDic:dic];
                    [arrScrollFigureModel addObject:scrollFigureModel];
                }
                //首页数据
                for (NSDictionary * dic in responseObject[@"data"][@"list"])
                {
                    TXHomeModelo      * homeModel  = [[TXHomeModelo alloc]initWithDic:dic];
                    [arrHomeModel addObject:homeModel];
                }
                _scrollFigureModel=arrScrollFigureModel;//轮播图数据模型
                _homeModel=arrHomeModel;
                [_requestNotifiction postNotificationName:@"RequestHomeModelData" object:self];
            }
            
        }];
        [dataTask resume];
    }
}
#pragma mark------------------请求推荐页面数据------------------
-(void)requestRecommendData
{
    if ([self respondsToSelector:@selector(requestRecommendData)])
    {
        NSMutableArray            * muarray      = [NSMutableArray array];
        
        NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager       * manager       = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        NSURL                     * URL           = [NSURL URLWithString:[NSString stringWithFormat:@"%@/1_20/%@-%@",TuiJian_URL,APP_ID,APP_KEY]];
        NSURLRequest              * request       = [NSURLRequest requestWithURL:URL];
        NSURLSessionDataTask      * dataTask      = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
            if (error)
            {
                NSLog(@"Error: %@", error);
            } else
            {
                NSLog(@"%@",response);  
                for (NSDictionary * dic in responseObject[@"data"][@"content"])
                {
                    TXListModel      * listModel  = [[TXListModel alloc]initWithDic:dic];
                    TXListFrameModel * frameModel = [TXListFrameModel recommendWithModel:listModel];
                    [muarray addObject:frameModel];
                }
               _recommendFrameModel               = muarray;
            }
            
        }];
        [dataTask resume];
    }

}
#pragma mark------------------添加推荐页面数据------------------
-(void)addrecommendDataWithPag:(int)pag Number:(int)number
{
    if ([self respondsToSelector:@selector(addrecommendDataWithPag:Number:)])
    {
        NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager       * manager       = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        NSString                  * strURl        =[NSString stringWithFormat:@"%@/%i_%i/%@-%@",TuiJian_URL,pag,number,APP_ID,APP_KEY];
        NSURL                     * URL           = [NSURL URLWithString:strURl];
        NSURLRequest              * request       = [NSURLRequest requestWithURL:URL];
        NSURLSessionDataTask      *dataTask       = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
            if (error)
            {
                NSLog(@"Error: %@", error);
            } else
            {
                NSLog(@"%@",response);
                for (NSDictionary * dic in responseObject[@"data"][@"content"])
                {
                    TXListModel         * listModel   = [[TXListModel alloc]initWithDic:dic];
                    TXListFrameModel    * frameModel  = [TXListFrameModel recommendWithModel:listModel];
                    [_recommendFrameModel addObject:frameModel];
                }
            }
            
        }];
        [dataTask resume];
    }
}

#pragma mark------------------请求全部页面数据------------------
-(void)requestAllData
{
    if ([self respondsToSelector:@selector(requestAllData)])
    {
        NSMutableArray            * muarray       =[NSMutableArray array];
        NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager       * manager       = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        NSString                  *strURL         = [NSString stringWithFormat:@"%@_1_20/%@-%@",QuanBu_URL,APP_ID,APP_KEY];
        NSURL                     * URL           = [NSURL URLWithString:strURL];
        NSURLRequest              * request       = [NSURLRequest requestWithURL:URL];
        NSURLSessionDataTask      *dataTask       = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error)
        {
            if (error)
            {
                NSLog(@"Error: %@", error);
            } else
            {
                NSLog(@"%@",response);
                for (NSDictionary * dic in responseObject[@"data"][@"content"])
                {
                    TXListModel      * listModel  = [[TXListModel alloc]initWithDic:dic];
                    TXListFrameModel * frameModel = [TXListFrameModel recommendWithModel:listModel];
                    [muarray addObject:frameModel];
                }
                 _allFrameModel                    = muarray;
                [_requestNotifiction postNotificationName:@"RequestAllDataComplete" object:self];
            }
            
        }];
        [dataTask resume];
    }

}
#pragma mark------------------添加全部页面数据------------------
-(void)addAllDataWithPag:(int)pag Number:(int)number
{
    if ([self respondsToSelector:@selector(addAllDataWithPag:Number:)])
    {
        NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager       * manager       = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        NSString                  *strURL         = [NSString stringWithFormat:@"%@_%i_%i/%@-%@",QuanBu_URL,pag,number,APP_ID,APP_KEY];
        NSURL                     * URL           = [NSURL URLWithString:strURL];
        NSURLRequest              * request       = [NSURLRequest requestWithURL:URL];
        NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error)
        {
            if (error)
            {
                NSLog(@"Error: %@", error);
            } else
            {
                NSLog(@"%@",response);
                for (NSDictionary * dic in responseObject[@"data"][@"content"])
                {
                    TXListModel      * listModel   = [[TXListModel alloc]initWithDic:dic];
                    TXListFrameModel * frameModel  = [TXListFrameModel recommendWithModel:listModel];
                    [_allFrameModel addObject:frameModel];
                }
            }
        }];
        [dataTask resume];
    }

}

#pragma mark------------------请求视频页面数据------------------
-(void)requestVideoData
{
    if ([self respondsToSelector:@selector(requestVideoData)])
    {
        NSMutableArray            * muarray        = [NSMutableArray array];
        NSURLSessionConfiguration * configuration  = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager       * manager        = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        NSString                  *strURL         = [NSString stringWithFormat:@"%@_1_20/%@-%@",ShiPin_URL,APP_ID,APP_KEY];
        NSURL                     * URL            = [NSURL URLWithString:strURL];
        NSURLRequest              * request        = [NSURLRequest requestWithURL:URL];
        NSURLSessionDataTask      * dataTask       = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error)
        {
            if (error)
            {
                NSLog(@"Error: %@", error);
            } else
            {
                NSLog(@"%@",response);
                for (NSDictionary * dic in responseObject[@"data"][@"content"])
                {
                    TXListModel      * listModel    = [[TXListModel alloc]initWithDic:dic];
                    TXListFrameModel * frameModel   = [TXListFrameModel recommendWithModel:listModel];
                    [muarray addObject:frameModel];
                }
                 _videoFrameModel                   = muarray;
                [_requestNotifiction postNotificationName:@"RequestVideoDataComplete" object:self];
            }
            
        }];
        [dataTask resume];
    }
}
#pragma mark---------------------添加视频页面数据-----------------
-(void)addVideoDataWithPag:(int)pag Number:(int)number
{
    if ([self respondsToSelector:@selector(addVideoDataWithPag:Number:)])
    {
        NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager       * manager       = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        NSString                  *strURL         = [NSString stringWithFormat:@"%@_%i_%i/%@-%@",ShiPin_URL,pag,number,APP_ID,APP_KEY];
        NSURL                     * URL           = [NSURL URLWithString:strURL];
        NSURLRequest              * request       = [NSURLRequest requestWithURL:URL];
        NSURLSessionDataTask      * dataTask      = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error)
        {
            if (error)
            {
                NSLog(@"Error: %@", error);
            }
            else
             {
                NSLog(@"%@",response);
                for (NSDictionary * dic in responseObject[@"data"][@"content"])
                 {
                     TXListModel      * listModel   = [[TXListModel alloc]initWithDic:dic];
                     TXListFrameModel * frameModel  = [TXListFrameModel recommendWithModel:listModel];
                     [_videoFrameModel addObject:frameModel];
                 }
             }
        }];
        [dataTask resume];
    }
}
#pragma mark------------------请求图片数据------------------
-(void)requestPicData
{
    if ([self respondsToSelector:@selector(requestPicData)])
    {
        NSMutableArray            * muarray       =[NSMutableArray array];
        NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager       * manager       = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        NSString                  * strURL        =[NSString stringWithFormat:@"%@_1_20/%@-%@",TuPian_URL,APP_ID,APP_KEY];
        NSURL                     * URL           = [NSURL URLWithString:strURL];
        NSURLRequest              * request       = [NSURLRequest requestWithURL:URL];
        NSURLSessionDataTask      * dataTask      = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error)
            {
                if (error)
                {
                    NSLog(@"Error: %@", error);
                }
                else
                {
                    NSLog(@"%@",response);
    
                    for (NSDictionary * dic in responseObject[@"data"][@"content"])
                    {
                    TXListModel      * listModel   = [[TXListModel alloc]initWithDic:dic];
                    TXPic_titleFrameModel * frameModel  = [TXPic_titleFrameModel pic_titleWithModel:listModel];
                    [muarray addObject:frameModel];
                    }
                                                             
                }
             _picFrameModel     = muarray;
             [_requestNotifiction postNotificationName:@"RequestPicTitleData" object:self];
          }];
        [dataTask resume];
    }
    
}
#pragma mark-------------添加图片数据-------------
-(void)addPicDataWithPag:(int)pag Number:(int)number
{
    if ([self respondsToSelector:@selector(addPicDataWithPag:Number:)])
    {
        NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager       * manager       = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        NSString                  *strURL         = [NSString stringWithFormat:@"%@_%i_%i/%@-%@",TuPian_URL,pag,number,APP_ID,APP_KEY];
        NSURL                     * URL           = [NSURL URLWithString:strURL];
        NSURLRequest              * request       = [NSURLRequest requestWithURL:URL];
        NSURLSessionDataTask      * dataTask      = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error)
         {
            if (error)
            {
                NSLog(@"Error: %@", error);
            }
            else
            {
                 NSLog(@"%@",response);
                 for (NSDictionary * dic in responseObject[@"data"][@"content"])
                 {
                   TXListModel      * listModel   = [[TXListModel alloc]initWithDic:dic];
                   TXPic_titleFrameModel * frameModel  = [TXPic_titleFrameModel pic_titleWithModel:listModel];
                    [_picFrameModel addObject:frameModel];
                 }
            }
        }];
        [dataTask resume];
    }

}
#pragma mark----------请求链接页面数据------------------
-(void)requestLinkData
{
    if ([self respondsToSelector:@selector(requestLinkData)])
    {
        NSMutableArray            * muarray       = [NSMutableArray array];
        
        NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        AFURLSessionManager       * manager       = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        NSString                  * strURL         = [NSString stringWithFormat:@"%@_1_20/%@-%@",WenZhang_URL,APP_ID,APP_KEY];
        NSURL                     * URL           = [NSURL URLWithString:strURL];
        NSURLRequest              * request       = [NSURLRequest requestWithURL:URL];
        NSURLSessionDataTask      * dataTask      = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error)
        {
            if (error)
            {
                NSLog(@"Error: %@", error);
            } else
            {
                NSLog(@"%@",response);
                for (NSDictionary * dic in responseObject[@"data"][@"content"])
                {
                    TXListModel      * listModel    = [[TXListModel alloc]initWithDic:dic];
                    TXListFrameModel * frameModel   = [TXListFrameModel recommendWithModel:listModel];
                    [muarray addObject:frameModel];
                }
                _linkFrameModel                     = muarray;
                [_requestNotifiction postNotificationName:@"RequestLinkDataComplete" object:self];
            }
        }];
        [dataTask resume];
    }
}
#pragma mark---------------------添加链接页面数据-----------------
-(void)addLinkDataWithPag:(int)pag Number:(int)number
{
    if ([self respondsToSelector:@selector(addLinkDataWithPag:Number:)])
    {
        //可以把总跳数传递过来
        NSURLSessionConfiguration * configuration  = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager       * manager        = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        NSString                  *strURL         = [NSString stringWithFormat:@"%@_%i_%i/%@-%@",WenZhang_URL,pag,number,APP_ID,APP_KEY];
        NSURL                     * URL            = [NSURL URLWithString:strURL];
        NSURLRequest              * request        = [NSURLRequest requestWithURL:URL];
        NSURLSessionDataTask      * dataTask       = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error)
         {
            if (error)
            {
                NSLog(@"Error: %@", error);
            } else
            {
                NSLog(@"%@",response);
                for (NSDictionary * dic in responseObject[@"data"][@"content"])
                {
                    TXListModel      * listModel  = [[TXListModel alloc]initWithDic:dic];
                    TXListFrameModel * frameModel = [TXListFrameModel recommendWithModel:listModel];
                    [_linkFrameModel addObject:frameModel];
                }
            }
        }];
        [dataTask resume];
    }
}
#pragma mark-----------------请求搜索界面的数据-----------------
-(void)requestSeachDataWithString:(NSString *)string
{
   
    if ([self respondsToSelector:@selector(requestSeachDataWithString:)])
    {
        NSMutableArray            * muarray       = [NSMutableArray array];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSString *URLString = [@"http://www.quumii.com/app/api.php?method=" stringByAppendingString:@"getlist"];
        NSDictionary *parameters = @{
                                     @"search":string,
                                     @"ftime":@1,
                                     @"type":@0,
                                     @"start":@0,
                                     @"end":@10
                                     };
        [manager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSDictionary *dicData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableContainers error:nil];
            
            for (NSDictionary * dic in dicData[@"content"])
            {
                TXListModel      * listModel  = [[TXListModel alloc]initWithDic:dic];
                TXListFrameModel * frameModel = [TXListFrameModel recommendWithModel:listModel];
                [muarray addObject:frameModel];
            }
            _seachFrameModel=muarray;
            [_requestNotifiction postNotificationName:@"RequestSeachDataComplete" object:self];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            nil;
        }];

    }
    
}
#pragma mark-----------------------登录获取用户数据数据-------------------
-(void)signInWithUserAccount:(NSString*)userAccount UserPassword:(NSString*)userPassword
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *URLString = [@"http://www.quumii.com/app/api.php?method=registerlogin&type=0" stringByAppendingString:@"usercenter"];
    NSDictionary *parameters = @{@"type":@0,
                                 @"username":userAccount,
                                 @"password":userPassword
                                 };
    [manager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableContainers error:nil];
        
        TXPersonalCenterModel * personalCenterModel=[[TXPersonalCenterModel alloc]initWithDic:dic[@"userinfo"]];
        NSData * data=[NSKeyedArchiver archivedDataWithRootObject:personalCenterModel];
                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        [user setValue:data forKey:@"用户信息"];
        [_requestNotifiction postNotificationName:@"个人中心" object:self];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        nil;
    }];

    
    
}
#pragma mark----------------短信验证--------------
-(void)SMSVerificationWithPhone:(NSString*)phone
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *URLString = @"http://api.huojidao.com/VerificationCode/token/7f5133db96a3f3e19a-88f9cec25baadaa9a8209c49db4";
    NSNumber*  phoneNum=(NSNumber *)phone;
    NSLog(@"%@",phoneNum);
    NSDictionary *parameters = @{
                                 @"imei":@"sssslllll",
                                 @"phone":phoneNum,
                                 @"timeout":@5,
                                 };
    [manager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableContainers error:nil];
        NSLog(@"短信dic:%@",dic);
        NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
        [user setValue:dic[@"data"][@"vcode"] forKey:@"verificationCode"];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
        nil;
    }];

}
#pragma mark---------------注册---------------
//-(void)registerWithUser:(NSString*) Password:(NSString *)password
//{
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    NSString *URLString = @"http://api.huojidao.com/Register/token/7f5133db96a3f3e19a-88f9cec25baadaa9a8209c49db4";
//    NSDictionary *parameters = @{
//                                 @"imei":@"sssslllll",
//                                 @"phone":,
//                                 @"timeout":@5,
//                                 };
//    [manager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
//        NSLog(@"%@",downloadProgress);
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableContainers error:nil];
//        NSLog(@"短信dic:%@",dic);
//        NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
//        [user setValue:dic[@"data"][@"vcode"] forKey:@"verificationCode"];
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
//        nil;
//    }];
//
//}






-(void)dealloc
{
   NSLog(@"释放");
}
@end
