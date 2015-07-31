//
//  VISPERPushRoutingPresenter.m
//  Pods
//
//  Created by Bartel on 18.07.15.
//
//

#import "VISPERPushRoutingPresenter.h"
#import "IVISPERWireframePresentationTypePush.h"
#import "IVISPERWireframe.h"
#import "UIViewController+VISPER.h"

@implementation VISPERPushRoutingPresenter

-(BOOL)isResponsibleForRoutingOption:(NSObject<IVISPERRoutingOption>*)routingOption{
    if([routingOption.wireframePresentationType conformsToProtocol:@protocol(IVISPERWireframePresentationTypePush)]){
        return YES;
    }
    return NO;
}

- (void)addRoute:(NSString *)routePattern
        priority:(NSUInteger)priority
  withController:(UIViewController*)controller
         options:(NSObject<IVISPERRoutingOption>*)options
     onWireframe:(NSObject<IVISPERWireframe>*)wireframe{

    NSObject<IVISPERWireframe> *blockWireframe = wireframe;
    
    [wireframe addRoute:routePattern
               priority:priority
                handler:^BOOL(NSDictionary *parameters) {
                    
        UIViewController *blockController = controller;
        if(!blockController){
            blockController = [self controllerForRoute:routePattern
                                        routingOptions:options
                                        withParameters:parameters];
        }
        
        [self sendWillRouteToControllerEventForController:blockController
                                                wireframe:blockWireframe
                                             routePattern:routePattern
                                                 priority:priority
                                                  options:options
                                               parameters:parameters];
                    
                    
        NSObject <IVISPERRoutingEvent> *willPushControllerEvent =
                [self.serviceProvider createEventWithName:@"willPushController"
                                                   sender:blockWireframe
                                                     info:@{
                                                            @"routePattern":routePattern,
                                                            @"priority":[NSNumber numberWithLong:priority],
                                                            @"options" : options,
                                                            @"parameters": parameters
                                                            }];
        [blockController routingEvent:willPushControllerEvent withWireframe:blockWireframe];
        
        [CATransaction begin];
        if([blockWireframe.navigationController respondsToSelector:@selector(showViewController:sender:)] &&
           options.wireframePresentationType.animated == YES){
            [blockWireframe.navigationController showViewController:blockController sender:blockWireframe];
        }else{
            [blockWireframe.navigationController pushViewController:blockController animated:options.wireframePresentationType.animated];
        }
        [CATransaction setCompletionBlock:^{
            NSObject <IVISPERRoutingEvent> *didPushControllerEvent =
            [self.serviceProvider createEventWithName:@"didPushController"
                                               sender:blockWireframe
                                                 info:@{
                                                        @"routePattern":routePattern,
                                                        @"priority":[NSNumber numberWithLong:priority],
                                                        @"options" : options,
                                                        @"parameters": parameters
                                                        }];
            [blockController routingEvent:didPushControllerEvent withWireframe:blockWireframe];
            
            [self sendDidRouteToControllerEventForController:blockController
                                                    wireframe:blockWireframe
                                                 routePattern:routePattern
                                                     priority:priority
                                                      options:options
                                                   parameters:parameters];
        }];
        [CATransaction commit];
        return YES;
                    
    }];
}

@end
