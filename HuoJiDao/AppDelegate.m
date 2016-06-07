//
//  AppDelegate.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/13.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "AppDelegate.h"
#import "AFNetworking.h"

#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaSSOHandler.h"



@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    self.window.backgroundColor=[UIColor whiteColor];
    //检查app网络连接状态
    [self detectingNetworkState];
    [self YMSDK];
    
       
    
    
    
    return YES;
}

#pragma mark---------------检测网络状态-----------------------
-(void)detectingNetworkState
{
    _manager = [AFNetworkReachabilityManager sharedManager];
    
    typedef NS_ENUM(NSInteger, AFNetworkReachabilityStatus) {
        AFNetworkReachabilityStatusUnknown          = -1,//未识别的网络
        AFNetworkReachabilityStatusNotReachable     = 0,//不可达的网络
        AFNetworkReachabilityStatusReachableViaWWAN = 1,//2G,3G,4G...
        AFNetworkReachabilityStatusReachableViaWiFi = 2,//wifi网络
    };
    [_manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未识别的网络");
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"不可达的网络(未连接)");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                
               
                NSLog(@"2G,3G,4G...的网络");
                
            }
                
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                NSLog(@"wifi的网络");
            }
                
                break;
            default:
                break;
        }
    }];
    [_manager startMonitoring];
}
#pragma mark------------------友盟第三方分享------------------
-(void)YMSDK
{
    // Override point for customization after application launch.
    [UMSocialData setAppKey:AppKey];
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:WeiXinAppID appSecret:WeiXinAppSecret url:@"http://www.umeng.com/social"];
    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
    [UMSocialQQHandler setQQWithAppId:QQAppID appKey:QQAPPKey url:@"http://www.umeng.com/social"];
//    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。需要 #import "UMSocialSinaSSOHandler.h"
//    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"819272468" secret:@"da00667b7bad3ffd8038a93078eef975" RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma mark------------------友盟第三方分享回调------------------
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
}
@end
