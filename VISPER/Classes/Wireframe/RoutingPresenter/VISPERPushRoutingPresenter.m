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
        [wireframe setCurrentViewController:controller];
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

-(void)dismissViewController:(UIViewController*) controller
                    animated:(BOOL)animated
                 onWireframe:(NSObject<IVISPERWireframe>*)wireframe
                  completion:(void(^)(void))completion{
    
    
    if(controller != wireframe.currentViewController){
        @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                       reason:@"controller is not the wireframes current vc" userInfo:nil];
    }else if(!controller.routingOptions || ![self isResponsibleForRoutingOption:controller.routingOptions]) {
        
        NSString *message = [NSString stringWithFormat:@"presenter: %@ is not responsible for controller %@",NSStringFromClass(self.class), controller ];
        
        @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                       reason:message
                                     userInfo:nil];
        
    } else {
        
        if(animated){
            
            [CATransaction begin];
            [CATransaction setCompletionBlock:^{
                completion();
            }];
            
            [self.navigationController popViewControllerAnimated:YES];
            
            [CATransaction commit];
            
        }else {
            [self.navigationController popViewControllerAnimated:FALSE];
            completion();
        }
        
    }

}
/*
 //
 // Raus genommen da es controller gibt die mysteriöser weise ihre navigationController property verlieren
 //
-(void)dismissViewController:(UIViewController*) controller
                    animated:(BOOL)animated
                 onWireframe:(NSObject<IVISPERWireframe>*)wireframe
                  completion:(void(^)())completion{
    
    if(controller.navigationController){
        
        if(self.navigationController != controller.navigationController){
            @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                           reason:@"controller could not be popped since it doesn't live in it's wireframes navigation controller" userInfo:nil];
        }else {
          
            if(animated){
                
                [CATransaction begin];
                [CATransaction setCompletionBlock:^{
                    completion();
                }];
                
                [self.navigationController popViewControllerAnimated:YES];
                
                [CATransaction commit];
            
            }else {
                [self.navigationController popViewControllerAnimated:FALSE];
                completion();
            }
            
    
        }
        
    
    }else {
        @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                       reason:@"controller could not be popped since it has no navigation controller" userInfo:nil];
    }
    
}
*/

@end
