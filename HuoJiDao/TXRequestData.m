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
@interface TXRequestData ()<NSURLSessionDataDelegate>

@end
@implementation TXRequestData


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
-(void)dealloc{
   
    NSLog(@"释放");
}
@end
