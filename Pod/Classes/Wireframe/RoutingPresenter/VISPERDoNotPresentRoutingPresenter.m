//
//  VISPERDoNotPresentRoutingPresenter.m
//  Pods
//
//  Created by bartel on 13.08.15.
//
//

#import "VISPERDoNotPresentRoutingPresenter.h"
#import "IVISPERWireframePresentationTypeDoNotPresentVC.h"

@implementation VISPERDoNotPresentRoutingPresenter

-(BOOL)isResponsibleForRoutingOption:(NSObject<IVISPERRoutingOption>*)routingOption{
    if([routingOption.wireframePresentationType conformsToProtocol:@protocol(IVISPERWireframePresentationTypeDoNotPresentVC)]){
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
    
    NSObject<IVISPERWireframePresentationTypeDoNotPresentVC> *doNotPresentOptionType = (NSObject<IVISPERWireframePresentationTypeDoNotPresentVC>*)options.wireframePresentationType;
    
    if(doNotPresentOptionType.completionBlock){
        doNotPresentOptionType.completionBlock(routePattern,
                                               controller,
                                               options,
                                               parameters,
                                               wireframe);
    }
}

@end
