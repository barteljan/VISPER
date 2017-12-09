//
//  AppDelegate.m
//  VISPER
//
//  Created by Bartel on 10.07.15.
//  Copyright (c) 2015 Bartel. All rights reserved.
//


#import "AppDelegate.h"
#import "Example1Feature.h"
#import "ExampleFeature2.h"
#import <VISPER/VISPER.h>
#import "VISPER_Example-Swift.h"


@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.visperApplication = [[VISPERApplication alloc] init];
    
    self.window.rootViewController = self.visperApplication.rootViewController;
    
    [self.visperApplication addFeature:[[Example1Feature alloc] init]];
    [self.visperApplication addFeature:[[ExampleFeature2 alloc] init]];
    [self.visperApplication addFeature:[[ExampleFeature3 alloc] init]];
    
    [self.visperApplication routeURL:[NSURL URLWithString:@"/example1"]
                      withParameters:nil
                             options:[VISPER routingOptionPresentRootVC:NO]];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
