//
//  VISPERModalRoutingPresenter.m
//  Pods
//
//  Created by Bartel on 18.07.15.
//
//

#import "VISPERModalRoutingPresenter.h"
#import "IVISPERWireframePresentationTypeModal.h"
#import "IVISPERWireframe.h"
#import "UIViewController+VISPER.h"
#import "IVISPERRoutingEvent.h"

@import UIKit;

@implementation VISPERModalRoutingPresenter

-(BOOL)isResponsibleForRoutingOption:(NSObject<IVISPERRoutingOption>*)routingOption{
    if([routingOption.wireframePresentationType conformsToProtocol:@protocol(IVISPERWireframePresentationTypeModal)]){
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
                    
        NSObject <IVISPERRoutingEvent> *willPresentControllerEvent =
                    [self.serviceProvider createEventWithName:@"willPresentController"
                                                       sender:blockWireframe
                                                         info:@{
                                                                @"routePattern":routePattern,
                                                                @"priority":[NSNumber numberWithLong:priority],
                                                                @"options" : options,
                                                                @"parameters": parameters
                                                                }];
        [blockController routingEvent:willPresentControllerEvent withWireframe:blockWireframe];
        [blockWireframe.navigationController presentViewController:blockController
                                                          animated:options.wireframePresentationType.animated completion:^{
                                                              NSObject <IVISPERRoutingEvent> *didPresentControllerEvent =
                                                              [self.serviceProvider createEventWithName:@"didPresentController"
                                                                                                 sender:blockWireframe
                                                                                                   info:@{
                                                                                                          @"routePattern":routePattern,
                                                                                                          @"priority":[NSNumber numberWithLong:priority],
                                                                                                          @"options" : options,
                                                                                                          @"parameters": parameters
                                                                                                          }];
                                                              [blockController routingEvent:didPresentControllerEvent withWireframe:blockWireframe];
                                                          }];
        return YES;
    }];
}

@end
