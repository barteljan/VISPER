//
//  VISPERRoutingPresenter.h
//  Pods
//
//  Created by Bartel on 18.07.15.
//
//

#import <Foundation/Foundation.h>
@import UIKit;
#import "IVISPERRoutingPresenter.h"
#import "IVISPERWireframeViewControllerServiceProvider.h"
#import "IVISPERRoutingOption.h"


@interface VISPERRoutingPresenter : NSObject<IVISPERRoutingPresenter>

@property(nonatomic)NSObject<IVISPERWireframeViewControllerServiceProvider>*controllerServiceProvider;

-(UIViewController*)controllerForRoute:(NSString*)routePattern
                        routingOptions:(NSObject<IVISPERRoutingOption>*)options
                        withParameters:(NSDictionary*)parameters;

@end
