//
//  IVISPERControllerProvider.h
//  Pods
//
//  Created by Bartel on 22.12.15.
//
//

#import <Foundation/Foundation.h>

@protocol IVISPERControllerProvider <NSObject>

/**
 *
 * Provide view controller if none is given
 *
 */
-(UIViewController*)controllerForRoute:(NSString*)routePattern
                        routingOptions:(NSObject<IVISPERRoutingOption>*)options
                        withParameters:(NSDictionary*)parameters;


@end
