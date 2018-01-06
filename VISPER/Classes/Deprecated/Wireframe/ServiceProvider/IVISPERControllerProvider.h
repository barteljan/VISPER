//
//  IVISPERControllerProvider.h
//  Pods
//
//  Created by Bartel on 22.12.15.
//
//
#import <Foundation/Foundation.h>


/**
 An instance that provides a view controller for a specifc route-pattern
 */
@protocol IVISPERControllerProvider <NSObject>

/**
 
 Provide provide a view controller for a specifc route-pattern, return nil if you are not responsible for the given route pattern

 @param routePattern The route pattern for which a controller should be provided
 @param options The given routing options to describe the presentation mode in which the controller will be presented
 @param parameters An dictionary of parameters for this route (use them to configure your VC)
 @return Returns a ViewController if the provider is responsible for this route pattern, or nil otherwise ...
 */
-(UIViewController* _Nullable)controllerForRoute:(NSString* _Nonnull )routePattern
                        routingOptions:(NSObject<IVISPERRoutingOption>* _Nonnull)options
                        withParameters:(NSDictionary* _Nonnull)parameters;

@optional
-(BOOL)isResponsibleForRoute:(NSString* _Nonnull )routePattern
              routingOptions:(NSObject<IVISPERRoutingOption>* _Nullable)options
              withParameters:(NSDictionary* _Nonnull)parameters;

@end
