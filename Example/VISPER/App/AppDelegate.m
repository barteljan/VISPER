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
#import <VISPER/VISPERModalRoutingPresenter.h>
#import <VISPER/VISPERPushRoutingPresenter.h>
#import <VISPER/VISPERRootVCRoutingPresenter.h>


@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [UIViewController enableVISPEREventsOnAllViewControllers];
    
    [self.wireframe addControllerServiceProvider:self withPriority:0];
    [self.wireframe addRoutingOptionsServiceProvider:self withPriority:0];
    
    [self.wireframe addRoutingPresenter:[[VISPERModalRoutingPresenter alloc]
                                            initWithNavigationController:self.navigationController]
                           withPriority:0];
    
    [self.wireframe addRoutingPresenter:[[VISPERPushRoutingPresenter alloc]
                                            initWithNavigationController:self.navigationController]
                           withPriority:0];
    
    [self.wireframe addRoutingPresenter:[[VISPERRootVCRoutingPresenter alloc]
                                            initWithNavigationController:self.navigationController]
                           withPriority:0];
    
    [self.wireframe addRoute:@"/example1"];
    [self.wireframe addRoute:@"/example2"];
    [self.wireframe addRoute:@"/example3"];
    
    [self.wireframe routeURL:[NSURL URLWithString:@"/example1"]
              withParameters:nil
                     options:[self.wireframe presentRootVCRoutingOption:NO]];
    
    
    UIViewController *controller = [self.wireframe controllerForURL:[NSURL URLWithString:@"/example1"] withParameters:nil];
    NSLog(@"Controller: %@",controller);
    return YES;
}

-(UIViewController*)controllerForRoute:(NSString*)routePattern
                        routingOptions:(NSObject<IVISPERRoutingOption>*)options
                        withParameters:(NSDictionary*)parameters{
    
    //create controller 1
    if ([routePattern isEqualToString:@"/example1"]){
        Example1VisperViewControllerPresenter *example1VCPresenter =
        [[Example1VisperViewControllerPresenter alloc] initWithWireframe:self.wireframe];
        
        Example1VisperViewController *example1VC =
        [[Example1VisperViewController alloc] initWithNibName:@"Example1VisperViewController"
                                                       bundle:nil
                                              serviceProvider:nil
                                                    presenter:example1VCPresenter];
        return example1VC;
    }
    //create controller 2
    else if ([routePattern isEqualToString:@"/example2"]) {
        Example2VisperViewControllerPresenter *example2VCPresenter =
        [[Example2VisperViewControllerPresenter alloc] initWithWireframe:self.wireframe];
        
        Example2VisperViewController *example2VC = [[Example2VisperViewController alloc] initWithNibName:@"Example2VisperViewController"
                                                                                                  bundle:nil];
        [example2VC addVisperPresenter:example2VCPresenter];
        return example2VC;
    }
    //create controller 3
    else if ([routePattern isEqualToString:@"/example3"]) {
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

-(NSObject<IVISPERRoutingOption> *)optionForRoutePattern:(NSString *)routePattern
                                              parameters:(NSDictionary*)parameters
                                          currentOptions:(NSObject<IVISPERRoutingOption>*)currentOptions{
    if(currentOptions){
        return currentOptions;
    }
    
    if ([routePattern isEqualToString:@"/example2"]) {
        return [self.wireframe pushRoutingOption:YES];
    }else if([routePattern isEqualToString:@"/example3"]){
        return [self.wireframe modalRoutingOption:YES];
    }

    return nil;
}

@end