//
//  AppDelegate.m
//  HuoJiDao
//
//  Created by IOS开发 on 16/4/13.
//  Copyright © 2016年 IOS开发. All rights reserved.
//

#import "AppDelegate.h"
#import "AFNetworking.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    //检查app网络连接状态
    [self detectingNetworkState];
    
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

@end
