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
-(UIViewController* _Nullable)controllerForRoute:(NSString* _Nonnull )routePattern
                        routingOptions:(NSObject<IVISPERRoutingOption>* _Nonnull)options
                        withParameters:(NSDictionary* _Nonnull)parameters;


@end
