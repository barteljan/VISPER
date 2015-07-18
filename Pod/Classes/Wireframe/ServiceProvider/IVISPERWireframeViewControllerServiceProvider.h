//
//  IVISPERWireframeViewControllerServiceProvider.h
//  Pods
//
//  Created by Bartel on 18.07.15.
//
//

#import <Foundation/Foundation.h>
#import "IVISPERRoutingOption.h"
@import UIKit;

@protocol IVISPERWireframeViewControllerServiceProvider <NSObject>

/**
 *
 * Provide view controller if none is given
 *
 */
-(UIViewController*)controllerForRoute:(NSString*)routePattern
                        routingOptions:(NSObject<IVISPERRoutingOption>*)options
                        withParameters:(NSDictionary*)parameters;
@end
