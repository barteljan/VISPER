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
    
    
    NSObject <IVISPERRoutingEvent> *willPresentControllerEvent =
    [self.serviceProvider createEventWithName:@"willPresentController"
                                       sender:wireframe
                                         info:@{
                                                @"routePattern":routePattern,
                                                @"options" : options,
                                                @"parameters": parameters
                                                }];
    [controller routingEvent:willPresentControllerEvent withWireframe:wireframe];
    
    [self.navigationController presentViewController:controller
                                                      animated:options.wireframePresentationType.animated
                                                    completion:^{
                                                        NSObject <IVISPERRoutingEvent> *didPresentControllerEvent =
                                                        [self.serviceProvider createEventWithName:@"didPresentController"
                                                                                           sender:wireframe
                                                                                             info:@{
                                                                                                    @"routePattern":routePattern,
                                                                                                    @"options" : options,
                                                                                                    @"parameters": parameters
                                                                                                    }];
                                                        [controller routingEvent:didPresentControllerEvent withWireframe:wireframe];
                                                        completion(routePattern,
                                                                   controller,
                                                                   options,
                                                                   parameters,
                                                                   wireframe);
                                                    }];

}




@end
