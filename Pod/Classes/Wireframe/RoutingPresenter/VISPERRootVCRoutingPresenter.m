//
//  VISPERRootVCRoutingPresenter.m
//  Pods
//
//  Created by Bartel on 31.07.15.
//
//

#import "VISPERRootVCRoutingPresenter.h"
#import "IVISPERWireframePresentationTypeRootVC.h"
#import "IVISPERWireframe.h"
#import "UIViewController+VISPER.h"
#import "IVISPERRoutingEvent.h"


@implementation VISPERRootVCRoutingPresenter
-(BOOL)isResponsibleForRoutingOption:(NSObject<IVISPERRoutingOption>*)routingOption{
    if([routingOption.wireframePresentationType conformsToProtocol:@protocol(IVISPERWireframePresentationTypeRootVC)]){
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
                    [self.serviceProvider createEventWithName:@"willPresentRootViewController"
                                                       sender:blockWireframe
                                                         info:@{
                                                                @"routePattern":routePattern,
                                                                @"priority":[NSNumber numberWithLong:priority],
                                                                @"options" : options,
                                                                @"parameters": parameters
                                                                }];
                    [blockController routingEvent:willPresentControllerEvent withWireframe:blockWireframe];
                    
                    [CATransaction begin];
                   
                    [blockWireframe.navigationController setViewControllers:@[blockController]
                                                                   animated:options.wireframePresentationType.animated];
                    
                    [CATransaction setCompletionBlock:^{
                        NSObject <IVISPERRoutingEvent> *didPresentControllerEvent =
                        [self.serviceProvider createEventWithName:@"didPresentRootViewController"
                                                           sender:blockWireframe
                                                             info:@{
                                                                    @"routePattern":routePattern,
                                                                    @"priority":[NSNumber numberWithLong:priority],
                                                                    @"options" : options,
                                                                    @"parameters": parameters
                                                                    }];
                        [blockController routingEvent:didPresentControllerEvent withWireframe:blockWireframe];
                    }];
                    [CATransaction commit];

                    
                    return YES;
                }];
}

@end
