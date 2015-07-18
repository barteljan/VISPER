//
//  AppDelegate.m
//  VISPER
//
//  Created by Bartel on 10.07.15.
//  Copyright (c) 2015 Bartel. All rights reserved.
//


#import "AppDelegate.h"
#import "Example1VisperViewController.h"
#import "Example1VisperViewControllerPresenter.h"
#import "Example2VisperViewController.h"
#import "Example2VisperViewControllerPresenter.h"
#import "Example3VisperViewController.h"
#import "Example3VisperViewControllerPresenter.h"
#import <VISPER/UIViewController+VISPER.h>


@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [UIViewController enableVISPEREventsOnAllViewControllers];
    self.wireframe.controllerServiceProvider     = self;
    self.wireframe.routingOptionsServiceProvider = self;

    Example1VisperViewControllerPresenter *example1VCPresenter =
        [[Example1VisperViewControllerPresenter alloc] initWithWireframe:self.wireframe];

    Example1VisperViewController *example1VC =
        [[Example1VisperViewController alloc] initWithNibName:@"Example1VisperViewController"
                                                       bundle:nil
                                              serviceProvider:nil
                                                    presenter:example1VCPresenter];
    
    
    [self.navigationController setViewControllers:@[example1VC]];
    

    Example2VisperViewControllerPresenter *example2VCPresenter =
        [[Example2VisperViewControllerPresenter alloc] initWithWireframe:self.wireframe];
    
    Example2VisperViewController *example2VC = [[Example2VisperViewController alloc] initWithNibName:@"Example2VisperViewController"
                                                                                              bundle:nil];
    [example2VC addVisperPresenter:example2VCPresenter];
    
   
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
        Example3VisperViewControllerPresenter *example3VCPresenter =
            [[Example3VisperViewControllerPresenter alloc] initWithWireframe:self.wireframe];
        
        Example3VisperViewController *viewController =
                [[Example3VisperViewController alloc] initWithNibName:@"Example3VisperViewController"
                                                                       bundle:nil];
        [viewController addVisperPresenter:example3VCPresenter];

        return viewController;
    }

    return nil;
}

-(NSObject<IVISPERRoutingOption> *)optionForRoutePattern:(NSString *)routePattern{
    return [self.wireframe modalRoutingOption:YES];
}

@end