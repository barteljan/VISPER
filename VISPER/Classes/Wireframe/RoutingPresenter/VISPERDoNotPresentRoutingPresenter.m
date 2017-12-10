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

-(void)dismissViewController:(UIViewController*) controller
                 onWireframe:(NSObject<IVISPERWireframe>*)wireframe
                  completion:(void(^)(void))completion{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"controller could not be dismissed, since it wasn't presented by VISPER"
                                 userInfo:nil];
}

@end
