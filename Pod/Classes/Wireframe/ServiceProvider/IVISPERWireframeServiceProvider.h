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

@protocol IVISPERWireframeServiceProvider <NSObject>

/**
 *
 * Provide routing presenters, which are responsible for creating the real controller transition, 
 * depending on some routing options (IVISPERRoutingOption)
 *
 */

/**
 * add Routing presenter, responsible for routing controllers with specific RoutingOptions
 **/
-(void)addRoutingPresenter:(NSObject<IVISPERRoutingPresenter>*)presenter;

/**
 * remove Routing presenter, responsible for routing controllers with specific RoutingOptions
 **/
-(NSArray*)removeRoutingPresentersResponsibleForRoutingOptions:(NSObject<IVISPERRoutingOption>*)routingOption;

/**
 * get all registered routing presenters
 **/
-(NSArray*)routingPresenters;

/**
 *
 * Provide some convienience RoutingOptions
 *
 */
-(NSObject<IVISPERRoutingOption> *)routingOption:(BOOL)animated;
-(NSObject<IVISPERRoutingOption> *)pushRoutingOption:(BOOL)animated;
-(NSObject<IVISPERRoutingOption> *)modalRoutingOption:(BOOL)animated;
@end
