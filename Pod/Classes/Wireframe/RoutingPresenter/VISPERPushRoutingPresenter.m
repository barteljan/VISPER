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
@interface VISPERPushRoutingPresenter()

@end

@implementation VISPERPushRoutingPresenter

-(BOOL)isResponsibleForRoutingOption:(NSObject<IVISPERRoutingOption>*)routingOption{
    if([routingOption.wireframePresentationType conformsToProtocol:@protocol(IVISPERWireframePresentationTypePush)]){
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
    
    [CATransaction begin];
    if([self.navigationController respondsToSelector:@selector(showViewController:sender:)] &&
       options.wireframePresentationType.animated == YES){
        [self.navigationController showViewController:controller sender:wireframe];
    }else{
        [self.navigationController pushViewController:controller
                                                  animated:options.wireframePresentationType.animated];
    }
    
    [CATransaction setCompletionBlock:^{
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
