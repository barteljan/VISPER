//
//  VISPERWireframe.h
//  Pods
//
//  Created by Bartel on 11.07.15.
//
//

#import <Foundation/Foundation.h>
#import <JLRoutes/JLRoutes.h>
#import "IVISPERWireframe.h"
#import "IVISPERWireframeServiceProvider.h"
#import "IVISPERRoutingOption.h"
#import "IVISPERWireframeViewControllerServiceProvider.h"
#import "IVISPERWireframeRoutingOptionsServiceProvider.h"
#import "PriorizedObjectStore.h"

@interface VISPERWireframe : NSObject<IVISPERWireframe>

/**
 * JLRoutes object for routing
 **/
@property(nonatomic)JLRoutes *routes;

/**
 *  Service Provider
 **/
@property(nonatomic)IBOutlet NSObject<IVISPERWireframeServiceProvider>*serviceProvider;

/**
 *  Service Provider for getting controller instances when none are given at runtime
 **/
-(NSArray *)controllerServiceProviders;


/**
 *  Service provider for providing Routing options if none are given for a specific route
 **/
-(NSArray *)routingOptionsServiceProviders;

/**
 * Navigation controller of the wireframe
 **/
@property(nonatomic) IBOutlet UINavigationController *navigationController;



/**
 * Child wireframes of this wireframe
 **/
@property(nonatomic) IBOutletCollection(NSObject<IVISPERWireframe>) NSArray *childWireframes;


/**
 * Called any time routeURL returns NO. Respects shouldFallbackToGlobalRoutes.
 **/
@property (nonatomic, copy) void (^unmatchedURLHandler)(NSObject<IVISPERWireframe> *routes, NSURL *URL, NSDictionary *parameters);

/**
 * init functions
 **/
-(instancetype)initWithNavigationController:(UINavigationController*)navigationController;

-(instancetype)initWithRoutes:(JLRoutes*)routes
         navigationController:(UINavigationController*)navigationController;

-(instancetype)initWithNavigationController:(UINavigationController*)navigationController
                            serviceProvider:(NSObject<IVISPERWireframeServiceProvider>*)serviceProvider;

-(instancetype)initWithRoutes:(JLRoutes*)routes
         navigationController:(UINavigationController*)navigationController
              serviceProvider:(NSObject<IVISPERWireframeServiceProvider>*)serviceProvider;


@end
