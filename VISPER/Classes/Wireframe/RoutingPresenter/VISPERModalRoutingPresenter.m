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
    
    if([options.wireframePresentationType respondsToSelector:@selector(presentationStyle)]){
        UIModalPresentationStyle style = (UIModalPresentationStyle)[options.wireframePresentationType performSelector:@selector(presentationStyle)];
        [controller setModalPresentationStyle:style];
    }
    
    
    NSObject <IVISPERRoutingEvent> *willPresentControllerEvent =
    [self.serviceProvider createEventWithName:@"willPresentController"
                                       sender:wireframe
                                         info:@{
                                                @"routePattern":routePattern,
                                                @"options" : options,
                                                @"parameters": parameters
                                                }];
    [controller routingEvent:willPresentControllerEvent withWireframe:wireframe];
    
    UIViewController *presentingController = wireframe.currentViewController;
    if(!presentingController){
        presentingController = self.navigationController;
    }
    
    
    [presentingController presentViewController:controller
                                       animated:options.wireframePresentationType.animated
                                     completion:^{
                                         [wireframe setCurrentViewController:controller];
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


-(void)dismissViewController:(UIViewController*) controller
                    animated:(BOOL)animated
                 onWireframe:(NSObject<IVISPERWireframe>*)wireframe
                  completion:(void(^)())completion{
    
    // check if it is the first view controller pushed modally
    // we assume in that case that the current view controller
    // of the wireframe has to be the top vc in it's current navigation controller
    if(controller.presentingViewController != nil && controller.presentingViewController.presentingViewController == nil){
        [wireframe setCurrentViewController:self.navigationController.topViewController];
        [controller dismissThisViewControllerAnimated:animated completion:^{
            completion();
        }];
       
    } else if(controller.presentingViewController != nil) {
        [wireframe setCurrentViewController:controller.presentingViewController];
        [controller dismissThisViewControllerAnimated:animated completion:^{
            completion();
        }];
    } else {
        @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"This controller was not presented modally" userInfo:nil];
    }
    
}



@end
