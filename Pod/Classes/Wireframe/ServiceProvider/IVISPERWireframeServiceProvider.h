//
//  IVISPERWireframeServiceProvider.h
//  Pods
//
//  Created by Bartel on 12.07.15.
//
//

#import <Foundation/Foundation.h>
#import "IVISPERRoutingOption.h"
#import "IVISPERRoutingPresenter.h"
#import "IVISPERWireframeViewControllerServiceProvider.h"
#import "IVISPERRoutingEvent.h"

@protocol IVISPERWireframeServiceProvider <NSObject>

/**
 *
 * Provide some convienience RoutingOptions
 *
 */
-(NSObject<IVISPERRoutingOption> *)routingOption:(BOOL)animated;
-(NSObject<IVISPERRoutingOption> *)pushRoutingOption:(BOOL)animated;
-(NSObject<IVISPERRoutingOption> *)modalRoutingOption:(BOOL)animated;
-(NSObject<IVISPERRoutingOption> *)presentRootVCRoutingOption:(BOOL)animated;
-(NSObject<IVISPERRoutingOption> *)doNotPresentVCOption:(void(^)(NSString *routePattern,
                                                                 UIViewController *controller,
                                                                 NSObject<IVISPERRoutingOption>*options,
                                                                 NSDictionary *parameters,
                                                                 NSObject<IVISPERWireframe>*wireframe))completion;

/**
 * Generate a new empty wireframe
 */
-(NSObject<IVISPERWireframe>*)emptyWireframeFromWireframe:(NSObject<IVISPERWireframe>*)existingWireframe;

/**
 * Generate routing event
 */
-(NSObject<IVISPERRoutingEvent>*)createEventWithName:(NSString*)name
                                              sender:(id)sender
                                                info:(NSDictionary*)info;

@end
