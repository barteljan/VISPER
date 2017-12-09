//
//  IRoutingOptionsFactory.h
//  Pods
//
//  Created by Bartel on 21.08.15.
//
//

#import <Foundation/Foundation.h>
#import "IVISPERRoutingOption.h"
@protocol IVISPERWireframe;

@protocol IVISPERRoutingOptionsFactory <NSObject>

/**
 * GENERATING CONVINIENCE ROUTING OPTIONS
 **/
-(NSObject<IVISPERRoutingOption> *)routingOption;
-(NSObject<IVISPERRoutingOption> *)routingOption:(BOOL)animated;

-(NSObject<IVISPERRoutingOption> *)routingOptionPush;
-(NSObject<IVISPERRoutingOption> *)routingOptionPush:(BOOL)animated;

-(NSObject<IVISPERRoutingOption> *)routingOptionModal;
-(NSObject<IVISPERRoutingOption> *)routingOptionModal:(BOOL)animated;

-(NSObject<IVISPERRoutingOption> *)backToRoute;
-(NSObject<IVISPERRoutingOption> *)backToRoute:(BOOL)animated;

-(NSObject<IVISPERRoutingOption> *)routingOptionPresentRootVC;
-(NSObject<IVISPERRoutingOption> *)routingOptionPresentRootVC:(BOOL)animated;

-(NSObject<IVISPERRoutingOption> *)routingOptionDoNotPresentVC:( void(^)(NSString *routePattern,
                                                                         UIViewController *controller,
                                                                         NSObject<IVISPERRoutingOption>*options,
                                                                         NSDictionary *parameters,
                                                                         NSObject<IVISPERWireframe>*wireframe))completion;


-(NSObject<IVISPERRoutingOption> *)routingOptionReplaceTopVC;
-(NSObject<IVISPERRoutingOption> *)routingOptionReplaceTopVC:(BOOL)animated;

-(NSObject<IVISPERRoutingOption> *)routingOptionShow;
-(NSObject<IVISPERRoutingOption> *)routingOptionShow:(BOOL)animated;


@end
