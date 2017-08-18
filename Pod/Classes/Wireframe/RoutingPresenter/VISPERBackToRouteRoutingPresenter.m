//
//  VISPERBackToRouteRoutingPresenter.m
//  Pods
//
//  Created by bartel on 18.08.17.
//
//

#import "VISPERBackToRouteRoutingPresenter.h"
#import "IVISPERWireframePresentationTypeBackToRoute.h"
#import "IVISPERWireframe.h"
#import "UIViewController+VISPER.h"

@implementation VISPERBackToRouteRoutingPresenter

-(BOOL)isResponsibleForRoutingOption:(NSObject<IVISPERRoutingOption>*)routingOption{
    if([routingOption.wireframePresentationType conformsToProtocol:@protocol(IVISPERWireframePresentationTypeBackToRoute)]){
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
    
    UIViewController *currentController = wireframe.currentViewController;
    
    UIViewController *controllerToPresent = controller;
    
    NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    
    // if controller is modally presented replace the top controller of your navigation controller
    // this will only work if it is the first presented modal controller
    // we have no fallback if you have a modal view controller chain
    if(currentController.presentingViewController && currentController.presentingViewController.presentingViewController == nil){
        
        [viewControllers replaceObjectAtIndex:viewControllers.count - 1  withObject:controllerToPresent];
    
    }
    //if controller was pushed replace last vc
    else if(currentController.navigationController){
        
        if(viewControllers.count != 0){
            [viewControllers replaceObjectAtIndex:viewControllers.count - 1 withObject:controllerToPresent];
        }else {
            viewControllers = [NSMutableArray arrayWithObject:controllerToPresent];
        }
        
    } else {
        @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"There is no possibility to replace a modal viewcontroller presenting the current modal viewcontroller " userInfo:nil];
    }
    
    [self.navigationController setViewControllers:viewControllers animated:options.wireframePresentationType.animated];
    
    //go back to the routed controller
    [wireframe back:options.wireframePresentationType.animated completion:^{
        completion(routePattern,controller,options,parameters,wireframe);
    }];
    
}

@end
