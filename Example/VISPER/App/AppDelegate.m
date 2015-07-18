//
//  AppDelegate.m
//  VISPER
//
//  Created by Bartel on 10.07.15.
//  Copyright (c) 2015 Bartel. All rights reserved.
//


#import "AppDelegate.h"
#import "Example1VisperViewController.h"
#import "Example2VisperViewController.h"
#import "Example3VisperViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    Example2VisperViewController *example2VC = [[Example2VisperViewController alloc] initWithNibName:@"Example2VisperViewController" bundle:nil];
    
    self.wireframe.controllerServiceProvider     = self;
    self.wireframe.routingOptionsServiceProvider = self;

    [self.wireframe addRoute:@"/example2"
              withController:example2VC
                     options:[self.wireframe pushRoutingOption:YES]];

    [self.wireframe addRoute:@"/example3"];
    
    return YES;
}

-(UIViewController*)controllerForRoute:(NSString*)routePattern
                        routingOptions:(NSObject<IVISPERRoutingOption>*)options
                        withParameters:(NSDictionary*)parameters{
    if ([routePattern isEqualToString:@"/example3"]) {
        Example3VisperViewController *viewController =
                [[Example3VisperViewController alloc] initWithNibName:@"Example3VisperViewController"
                                                               bundle:nil];
        viewController.presenter.wireframe = self.wireframe;
        return viewController;
    }

    return nil;
}

-(NSObject<IVISPERRoutingOption> *)optionForRoutePattern:(NSString *)routePattern{
    return [self.wireframe modalRoutingOption:YES];
}

@end