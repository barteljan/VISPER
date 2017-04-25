//
//  IVISPERRoutingOptionsProvider.h
//  Pods
//
//  Created by Bartel on 22.12.15.
//
//

#import <Foundation/Foundation.h>

@protocol IVISPERRoutingOptionsProvider <NSObject>

/**
 * Default options for routing if none are provided
 **/
-( NSObject<IVISPERRoutingOption>* _Nullable )optionForRoutePattern:(NSString* _Nonnull)routePattern
                                                         parameters:(NSDictionary* _Nonnull)dictionary
                                                     currentOptions:(NSObject<IVISPERRoutingOption>* _Nullable)currentOptions;

@end
