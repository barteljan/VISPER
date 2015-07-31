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
#import "IVISPERRoutingPresenterServiceProvider.h"


@interface VISPERRoutingPresenter : NSObject<IVISPERRoutingPresenter>

@property(nonatomic)NSArray *controllerServiceProviders;
@property(nonatomic)NSObject<IVISPERRoutingPresenterServiceProvider>*serviceProvider;


-(instancetype)initWithServiceProvider:(NSObject<IVISPERRoutingPresenterServiceProvider>*)serviceProvider;

-(UIViewController*)controllerForRoute:(NSString*)routePattern
                        routingOptions:(NSObject<IVISPERRoutingOption>*)options
                        withParameters:(NSDictionary*)parameters;

-(void)sendWillRouteToControllerEventForController:(UIViewController*)controller
                                         wireframe:(NSObject<IVISPERWireframe>*)wireframe
                                      routePattern:(NSString*)routePattern
                                          priority:(NSInteger)priority
                                           options:(NSObject<IVISPERRoutingOption>*)options
                                        parameters:(NSDictionary*)parameters;

-(void)sendDidRouteToControllerEventForController:(UIViewController*)controller
                                        wireframe:(NSObject<IVISPERWireframe>*)wireframe
                                     routePattern:(NSString*)routePattern
                                         priority:(NSInteger)priority
                                          options:(NSObject<IVISPERRoutingOption>*)options
                                       parameters:(NSDictionary*)parameters;

@end
