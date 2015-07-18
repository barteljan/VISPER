//
//  IVISPERWireframeRoutingOptionsServiceProvider.h
//  Pods
//
//  Created by Bartel on 18.07.15.
//
//

#import <Foundation/Foundation.h>

@protocol IVISPERWireframeRoutingOptionsServiceProvider <NSObject>

/**
 * Default options for routing if none are provided
 **/
-(NSObject<IVISPERRoutingOption>*)optionForRoutePattern:(NSString*)routePattern;

@end
