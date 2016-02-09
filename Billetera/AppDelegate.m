//
//  AppDelegate.m
//  Billetera
//
//  Created by Vicente de Miguel on 1/2/16.
//  Copyright © 2016 Nicatec Software. All rights reserved.
//

#import "AppDelegate.h"
#import "AGTWalletTableViewController.h"
#import "AGTWallet.h"
#import "AGTMoney.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    AGTWallet *wallet = [[AGTWallet alloc]initWithAmount:1 currency:@"EUR"];
    [wallet plus:[AGTMoney euroWithAmount:40]];
    [wallet plus:[AGTMoney dollarWithAmount:95]];
    [wallet plus:[AGTMoney dollarWithAmount:53]];
    [wallet plus:[AGTMoney dollarWithAmount:85]];
    [wallet plus:[AGTMoney dollarWithAmount:35]];
    
    AGTMoney *yen = [[AGTMoney alloc] initWithAmount:400 currency:@"JPY"];
    [wallet plus:yen];

    

    AGTWalletTableViewController *tabla = [[AGTWalletTableViewController alloc] initWithModel:wallet];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:tabla];
    
    self.window.rootViewController=nav;
    
    [self.window makeKeyAndVisible];
    
    return YES;
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
