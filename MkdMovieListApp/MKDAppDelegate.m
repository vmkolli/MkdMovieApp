//
//  MKDAppDelegate.m
//  MkdMovieListApp
//
//  Created by Vinayakumar Kolli on 1/21/15.
//  Copyright (c) 2015 ___FULLUSERNAME___. All rights reserved.
//

#import "MKDAppDelegate.h"
#import "MKDMovieViewController.h"
#import "DvdViewController.h"

@implementation MKDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    MKDMovieViewController *mvc = [[MKDMovieViewController alloc] init];
    DvdViewController *dvc = [[DvdViewController alloc] init];
    UITabBarController *tbc = [[UITabBarController alloc]init];
//    NSArray *viewControllers = [NSArray arrayWithObjects:mvc, dvc, nil];
//    
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:mvc];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:dvc];
//    nav.viewControllers = viewControllers;
    tbc.viewControllers = [NSArray arrayWithObjects:nav1, nav2, nil];
    UITabBar *tabBars = tbc.tabBar;
    tabBars.barTintColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    UITabBarItem *tabBarItems[2];
    NSArray *titles = @[@"Movies", @"DVDs"];
    for (int i = 0; i < tabBars.items.count ; i++ ) {
        tabBarItems[i]   = [tabBars.items objectAtIndex:i];
        tabBarItems[i].title = titles[i];
        tabBarItems[i].titlePositionAdjustment = UIOffsetMake(10, -20);
        [tabBarItems[i] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                               [UIColor whiteColor], UITextAttributeTextColor,
                                                               [NSValue valueWithUIOffset:UIOffsetMake(0,0)], UITextAttributeTextShadowOffset,
                                                               [UIFont fontWithName:@"Helvetica" size:18.0], UITextAttributeFont, nil]
                                                     forState:UIControlStateNormal];
    
    }
    //UITabBarItem *mvTabBarItem = [tabBars.items objectAtIndex:0];
    //UITabBarItem *dvdTabBarItem = [tabBars.items objectAtIndex:1];
    //mvTabBarItem.title = @"Movies";
    //dvdTabBarItem.title = @"DVDs";
    
    
    
    
    self.window.rootViewController = tbc;
    
    [self.window makeKeyAndVisible];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
