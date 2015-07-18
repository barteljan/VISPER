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

@implementation VISPERPushRoutingPresenter

-(BOOL)isResponsibleForRoutingOption:(NSObject<IVISPERRoutingOption>*)routingOption{
    if([routingOption.wireframePresentationType conformsToProtocol:@protocol(IVISPERWireframePresentationTypePush)]){
        return YES;
    }
    return NO;
}

- (void)addRoute:(NSString *)routePattern
        priority:(NSUInteger)priority
  withController:(UIViewController*)controller
         options:(NSObject<IVISPERRoutingOption>*)options
     onWireframe:(NSObject<IVISPERWireframe>*)wireframe{

    NSObject<IVISPERWireframe> *blockWireframe = wireframe;
    
    [wireframe addRoute:routePattern
               priority:priority
                handler:^BOOL(NSDictionary *parameters) {
                    
        UIViewController *blockController = controller;
        if(!blockController){
            blockController = [self controllerForRoute:routePattern
                                        routingOptions:options
                                        withParameters:parameters];
        }
        
        if([blockWireframe.navigationController respondsToSelector:@selector(showViewController:sender:)]){
            [blockWireframe.navigationController showViewController:blockController sender:blockWireframe];
        }else{
            [blockWireframe.navigationController pushViewController:blockController animated:YES];
        }
        return YES;
                    
    }];
}

@end
