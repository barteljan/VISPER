//
//  IVISPERRoutingOptionsProvider.h
//  Pods
//
//  Created by Bartel on 22.12.15.
//
//

#import <Foundation/Foundation.h>

/**
 * A provider to provide routing options for a specific route pattern
 **/
@protocol IVISPERRoutingOptionsProvider <NSObject>

/**
 Provides a routing option if you are responsible for this route pattern.
 
 If a currentOptions parameter is given, the default behaviour should be to return the given routing option.
 You can replace the current options to enforce a specific option for this route pattern, but be careful,
 this could lead to a behaviour which could be diffcult to debug.
 
 If you are responsible for this route pattern, and no current options are provided, return a default routing option

 @param routePattern The route pattern for which a routing option should be provided
 @param parameters An dictionary of parameters for this route (use them to configure your VC)
 @param currentOptions The currently provided routing options for this route pattern (could be nil if you are the first responsible provider)
 @return return the correct routing options if you are responsible for this route pattern, return the currentOptions or nil otherwise.
 */
-( NSObject<IVISPERRoutingOption>* _Nullable )optionForRoutePattern:(NSString* _Nonnull)routePattern
                                                         parameters:(NSDictionary* _Nonnull)parameters
                                                     currentOptions:(NSObject<IVISPERRoutingOption>* _Nullable)currentOptions;

@end
