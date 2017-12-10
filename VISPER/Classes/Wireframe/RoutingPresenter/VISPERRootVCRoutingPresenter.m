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
        [self.serviceProvider createEventWithName:@"willPresentRootViewController"
                                           sender:wireframe
                                             info:@{
                                                    @"routePattern":routePattern,
                                                    @"options" : options,
                                                    @"parameters": parameters
                                                }];
    
    [controller routingEvent:willPresentControllerEvent withWireframe:wireframe];
    
    [CATransaction begin];
    
    [self.navigationController setViewControllers:@[controller]
                                                   animated:options.wireframePresentationType.animated];
    
    [CATransaction setCompletionBlock:^{
        [wireframe setCurrentViewController:controller];
        NSObject <IVISPERRoutingEvent> *didPresentControllerEvent =
        [self.serviceProvider createEventWithName:@"didPresentRootViewController"
                                           sender:wireframe
                                             info:@{
                                                    @"routePattern":routePattern,
                                                    @"options" : options,
                                                    @"parameters": parameters
                                                    }];
        [controller routingEvent:didPresentControllerEvent withWireframe:wireframe];
        completion(routePattern,controller,options,parameters,wireframe);
    }];
    [CATransaction commit];


}

-(void)dismissViewController:(UIViewController*) controller
                    animated:(BOOL)animated
                 onWireframe:(NSObject<IVISPERWireframe>*)wireframe
                  completion:(void(^)(void))completion{
    NSLog(@"ERROR: there is no way to dismiss a rootViewController");
    completion();
}

@end
