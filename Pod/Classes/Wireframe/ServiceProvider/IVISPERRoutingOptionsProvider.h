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
-(NSObject<IVISPERRoutingOption>*)optionForRoutePattern:(NSString*)routePattern
                                             parameters:(NSDictionary*)dictionary
                                         currentOptions:(NSObject<IVISPERRoutingOption>*)currentOptions;

@end
