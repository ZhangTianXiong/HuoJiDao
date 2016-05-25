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
#pragma mark---------------请求首页数据-----------
-(void)requestHomeModelData
{
    if ([self respondsToSelector:@selector(requestHomeModelData)])
    {
        //轮播图数据模型
        NSMutableArray * arrScrollFigureModel=[NSMutableArray array];
        NSMutableArray * arrHomeModel=[NSMutableArray array];
        
        NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager       * manager       = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        NSURL                     * URL           = [NSURL URLWithString:@"http://api.huojidao.com/HomePage"];
        
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
                for (NSDictionary * dic in responseObject[@"data"][@"list"]) {
                    
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
#pragma mark----------利用AFNetworking请求推荐页面数据------------------
-(void)requestRecommendData
{
    if ([self respondsToSelector:@selector(requestRecommendData)])
    {
        NSMutableArray            * muarray      = [NSMutableArray array];
        
        NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        
        AFURLSessionManager       * manager       = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        
        NSURL                     * URL           = [NSURL URLWithString:@"http://api.huojidao.com/RecommendPage/1_25"];
        
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
#pragma mark-----------------添加推荐页面数据-------------
-(void)addrecommendDataWithPag:(int)pag Number:(int)number
{
    if ([self respondsToSelector:@selector(addAllDataPag:Number:)])
    {
        //第一个页数
        //第二个条数
        
        
        NSString                  * strURl        =[NSString stringWithFormat:@"http://api.huojidao.com/RecommendPage/%i_%i",pag,number];
        
        
        NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager       * manager       = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
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

#pragma mark----------利用AFNetworking请求数据------------------
-(void)requestPicTitleData
{
    if ([self respondsToSelector:@selector(requestPicTitleData)])
    {
        NSMutableArray            * muarray       =[NSMutableArray array];
        
        NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
        
        AFURLSessionManager       * manager       = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        
        NSURL                     * URL           = [NSURL URLWithString:@"http://www.quumii.com/app/api.php?method=tuji&blogid=6212"];
        
        NSURLRequest              * request       = [NSURLRequest requestWithURL:URL];
        
        NSURLSessionDataTask      * dataTask      = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error)
                                                     {
            if (error)
            {
                NSLog(@"Error: %@", error);
            } else
            {
                NSLog(@"%@",response);
                
                for (NSDictionary * dic in responseObject)
                {
                    TXPic_title           * pic_title  = [[TXPic_title alloc]initWithDic:dic];
                    
                    TXPic_titleFrameModel * frameModel = [TXPic_titleFrameModel pic_titleWithModel:pic_title];
                    
                    [muarray addObject:frameModel];
                }
                _picFrameModel                         = muarray;
                
                 [_requestNotifiction postNotificationName:@"RequestPicTitleData" object:self];
            }
            
        }];
        [dataTask resume];
    }
    
}

#pragma mark----------利用AFNetworking请求全部页面数据------------------
-(void)requestAllData
{
    if ([self respondsToSelector:@selector(requestAllData)])
    {
        NSMutableArray            * muarray       =[NSMutableArray array];
        
        NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        AFURLSessionManager       * manager       = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        //第一个参数：
        //第二个参数：全部
        //第三个参数：页数
        //第四个参数：条数
        
        NSURL                     * URL           = [NSURL URLWithString:@"http://api.huojidao.com/ChannelPage/1_0_1_15"];
        
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
#pragma mark---------------------添加全部页面数据-----------------
-(void)addAllDataPag:(int)pag Number:(int)number
{
    if ([self respondsToSelector:@selector(addAllDataPag:Number:)])
    {
        
        
        NSString                  * strURl        = [NSString stringWithFormat:@"http://api.huojidao.com/ChannelPage/1_0_%i_%i",pag,number];
        
        
        NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager       * manager       = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        NSURL                     * URL           = [NSURL URLWithString:strURl];
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

#pragma mark----------利用AFNetworking请求视频页面数据------------------
-(void)requestVideoData
{
    if ([self respondsToSelector:@selector(requestVideoData)])
    {
        
        NSMutableArray            * muarray        = [NSMutableArray array];
        
        NSURLSessionConfiguration * configuration  = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        AFURLSessionManager       * manager        = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        
        NSURL                     * URL            = [NSURL URLWithString:@"http://api.huojidao.com/ChannelPage/1_3_1_15"];
        
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
-(void)addVideoDataPag:(int)pag Number:(int)number
{
    if ([self respondsToSelector:@selector(addVideoDataPag:Number:)])
    {
        
        
        NSString                  * strURl        = [NSString stringWithFormat:@"http://api.huojidao.com/ChannelPage/1_3_%i_%i",pag,number];
        

        NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager       * manager       = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        NSURL                     * URL           = [NSURL URLWithString:strURl];
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
                    
                    TXListModel      * listModel   = [[TXListModel alloc]initWithDic:dic];
                    TXListFrameModel * frameModel  = [TXListFrameModel recommendWithModel:listModel];
                    
                    [_videoFrameModel addObject:frameModel];
                }
                
                
            }
            
        }];
        [dataTask resume];
       
        
    }

}
#pragma mark----------利用AFNetworking请求链接页面数据------------------
-(void)requestLinkData
{
    if ([self respondsToSelector:@selector(requestLinkData)])
    {
        NSMutableArray            * muarray       = [NSMutableArray array];
        
        NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        AFURLSessionManager       * manager       = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        
        NSURL                     * URL           = [NSURL URLWithString:@"http://api.huojidao.com/ChannelPage/1_4_1_15"];
        
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
-(void)addLinkDataPag:(int)pag Number:(int)number
{
    if ([self respondsToSelector:@selector(addLinkDataPag:Number:)])
    {
        //可以把总跳数传递过来
        
        NSString                  * strURl         = [NSString stringWithFormat:@"http://api.huojidao.com/ChannelPage/1_4_%i_%i",pag,number];
        
        
        NSURLSessionConfiguration * configuration  = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager       * manager        = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        NSURL                     * URL            = [NSURL URLWithString:strURl];
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



-(void)requestBarrageModel
{
    
}
//#pragma mark - 上传进度的代理方法
//- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend
//{
//    // bytesSent totalBytesSent totalBytesExpectedToSend
//    // 发送字节(本次发送的字节数)    总发送字节数(已经上传的字节数)     总希望要发送的字节(文件大小)
//    NSLog(@"%lld-%lld-%lld-", bytesSent, totalBytesSent, totalBytesExpectedToSend);
//    // 已经上传的百分比
//    float progress = (float)totalBytesSent / totalBytesExpectedToSend;
//    NSLog(@"%f", progress);
//}
//
//
//
//
//
// // 下载进度跟进
// - (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
// didWriteData:(int64_t)bytesWritten
// totalBytesWritten:(int64_t)totalBytesWritten
//totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
//
//{
//    NSLog(@"sssssssssswsssssss");
// }
// 
//
// 
// // 完成下载
// - (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
//didFinishDownloadingToURL:(NSURL *)location{
//     
// }

-(void)dealloc{
   
    NSLog(@"释放");
}
@end
