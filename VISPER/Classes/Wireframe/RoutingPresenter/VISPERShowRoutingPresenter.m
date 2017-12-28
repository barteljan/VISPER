//
//  VISPERShowRoutingPresenter.m
//  Pods
//
//  Created by Jan Bartel on 16.08.16.
//
//

#import "VISPERShowRoutingPresenter.h"
#import "IVISPERWireframePresentationTypeShow.h"
#import "IVISPERWireframe.h"
#import "UIViewController+VISPER.h"
/*
@interface VISPERShowRoutingPresenter()

@end

@implementation VISPERShowRoutingPresenter

-(BOOL)isResponsibleForRoutingOption:(NSObject<IVISPERRoutingOption>*)routingOption{
    if([routingOption.wireframePresentationType conformsToProtocol:@protocol(IVISPERWireframePresentationTypeShow)]){
        return YES;
    }
    return NO;
}

-(void)routeForPattern:(NSString*)routePattern
            controller:(UIViewController*)controller
               options:(NSObject<IVISPERRoutingOption>*)options
            parameters:(NSDictionary*)parameters
           onWireframe:(NSObject<IVISPERWireframe>*)wireframe
            completion:(void(^)(NSString*routePattern,
                                UIViewController *controller,
                                NSObject<IVISPERRoutingOption>*options,
                                NSDictionary *parameters,
                                NSObject<IVISPERWireframe>*wireframe))completion{
    
    NSObject <IVISPERRoutingEvent> *willPushControllerEvent =
    
    [self.serviceProvider createEventWithName:@"willPushController"
                                       sender:wireframe
                                         info:@{
                                                @"routePattern":routePattern,
                                                @"options" : options,
                                                @"parameters": parameters
                                                }];
    [controller routingEvent:willPushControllerEvent withWireframe:wireframe];
    
    UIViewController *controllerToPopTo = nil;
    
    for(UIViewController *pushedController in self.navigationController.viewControllers){
        if(pushedController.routePattern == routePattern){
            controllerToPopTo = pushedController;
            break;
        }
    }
    
    [CATransaction begin];
    if(controllerToPopTo){
        [self.navigationController popToViewController:controllerToPopTo animated:options.wireframePresentationType.animated];
    }else{
        if([self.navigationController respondsToSelector:@selector(showViewController:sender:)] &&
           options.wireframePresentationType.animated == YES){
            [self.navigationController showViewController:controller sender:wireframe];
        }else{
            [self.navigationController pushViewController:controller
                                                 animated:options.wireframePresentationType.animated];
        }
    }
    [CATransaction setCompletionBlock:^{
        if(controllerToPopTo) {
            //[wireframe setCurrentViewController:controllerToPopTo];
        }else {
            //[wireframe setCurrentViewController:controller];
        }
        
        NSObject <IVISPERRoutingEvent> *didPushControllerEvent =
        [self.serviceProvider createEventWithName:@"didPushController"
                                           sender:wireframe
                                             info:@{
                                                    @"routePattern":routePattern,
                                                    @"options" : options,
                                                    @"parameters": parameters
                                                    }];
        [controller routingEvent:didPushControllerEvent withWireframe:wireframe];
        completion(routePattern,controller,options,parameters,wireframe);
    }];
    [CATransaction commit];
    
    
    
}



@end
 */
