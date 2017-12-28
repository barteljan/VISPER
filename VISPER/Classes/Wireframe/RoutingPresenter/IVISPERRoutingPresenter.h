//
//  IVISPERRoutingPresenter.h
//  Pods
//
//  Created by Bartel on 18.07.15.
//
//

@import UIKit;
#import <Foundation/Foundation.h>
#import "IVISPERRoutingOption.h"
#import "IVISPERWireframeViewControllerServiceProvider.h"

@protocol IVISPERWireframe;

@protocol IVISPERRoutingPresenter <NSObject>

//-(void)setControllerServiceProviders:(NSArray*)controllerServiceProviders;

-(BOOL)isResponsibleForRoutingOption:(NSObject<IVISPERRoutingOption>*)routingOption;

-(void)routeForPattern:(NSString*)routePattern
            controller:(UIViewController*)controller
               options:(NSObject<IVISPERRoutingOption>*)options
            parameters:(NSDictionary*)parameters
           onWireframe:(NSObject<IVISPERWireframe>*)wireframe
            completion:(void(^)(NSString *routePattern,
                                UIViewController *controller,
                                NSObject<IVISPERRoutingOption>*options,
                                NSDictionary *parameters,
                                NSObject<IVISPERWireframe>*wireframe))completion;

/*
-(void)dismissViewController:(UIViewController*) controller
                    animated:(BOOL)animated
                 onWireframe:(NSObject<IVISPERWireframe>*)wireframe
                  completion:(void(^)(void))completion;
*/


@end
