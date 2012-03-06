//
//  AppDelegate.m
//  StreamTest
//
//  Created by Daniel Czerwonk on 02/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "NotificationKeys.h"

@implementation AppDelegate

@synthesize window = window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[NSNotificationCenter defaultCenter] postNotificationName:ApplicationWillBeSentToBackground object:nil];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[NSNotificationCenter defaultCenter] postNotificationName:ApplicationReturnedFromBackground object:nil];
}

- (void)dealloc {
    [window release];
    [super dealloc];
}

@end