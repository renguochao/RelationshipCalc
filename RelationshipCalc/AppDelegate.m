//
//  AppDelegate.m
//  RelationshipCalc
//
//  Created by Guochao Ren on 2018/1/29.
//  Copyright © 2018年 KS. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <wax/wax.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    

    
    wax_start(nil, nil);//must start
    extern void luaopen_mobdebug_scripts(void* L);
    void * p = wax_currentLuaState();
    luaopen_mobdebug_scripts(p);
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"relationShipExample" ofType:@"lua"];
    int i = wax_runLuaFile(path.UTF8String);
    if(i){
        NSLog(@"error=%s", lua_tostring(wax_currentLuaState(), -1));
    }
    
    
//    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:@"http://p60ruufsr.bkt.clouddn.com/OrangeController.lua"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        if (error || !data) {
//            return;
//        }
//
//    }];
//    [dataTask resume];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [ViewController new];//[[UINavigationController alloc] initWithRootViewController:[ViewController new]];
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
