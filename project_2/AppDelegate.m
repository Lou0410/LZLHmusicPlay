//
//  AppDelegate.m
//  project_2
//
//  Created by lizhi on 2022/7/21.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
        //创建根视图控制器
    ViewController* rootVC = [[ViewController alloc] init];
        //创建UINavigationController，将根视图控制器作为它的根视图
    UINavigationController* navVC = [[UINavigationController alloc] initWithRootViewController:rootVC];
        //设置window的根视图控制器为UINavigationController
    //navVC.navigationBarHidden = NO;
    self.window.rootViewController = navVC;
        //显示Window
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    UIApplication* app = [UIApplication sharedApplication];
    __block UIBackgroundTaskIdentifier bgTask;
    bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (bgTask != UIBackgroundTaskInvalid)
        {
            bgTask = UIBackgroundTaskInvalid;
        }
        });
    }];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (bgTask != UIBackgroundTaskInvalid)
        {
            bgTask = UIBackgroundTaskInvalid;
        }
        });
    });
}

#pragma mark - UISceneSession lifecycle


/*- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}*/


@end
