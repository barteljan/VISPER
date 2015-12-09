//
//  VISPERReplaceTopVCRoutingPresenter.m
//  Pods
//
//  Created by Jan Bartel on 19.10.15.
//
//

#import "VISPERReplaceTopVCRoutingPresenter.h"
#import "UIViewController+VISPER.h"
#import "IVISPERWireframePresentationTypeReplaceTopVC.h"

@interface VISPERReplaceTopVCRoutingPresenter()
@end

@implementation VISPERReplaceTopVCRoutingPresenter

-(BOOL)isResponsibleForRoutingOption:(NSObject<IVISPERRoutingOption>*)routingOption{
    if([routingOption.wireframePresentationType conformsToProtocol:@protocol(IVISPERWireframePresentationTypeReplaceTopVC)]){
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
    
    NSMutableArray *controllers = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    [controllers removeLastObject];
    [controllers addObject:controller];
    [self.navigationController setViewControllers:[NSArray arrayWithArray:controllers] animated:options.wireframePresentationType.animated];
    
    
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
