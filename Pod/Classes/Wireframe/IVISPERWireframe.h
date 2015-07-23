//
//  IVISPERWireframe.h
//  Pods
//
//  Created by Bartel on 11.07.15.
//
//

@import Foundation;
@import UIKit;
#import "IVISPERWireframeServiceProvider.h"
#import "IVISPERRoutingPresenter.h"
#import "IVISPERRoutingOption.h"
#import "IVISPERWireframeViewControllerServiceProvider.h"
#import "IVISPERWireframeRoutingOptionsServiceProvider.h"

@protocol IVISPERWireframe <NSObject>

/**
  * Removes a routePattern from the receiving scheme namespace.
 **/
- (void)removeRoute:(NSString *)routePattern;

/**
  * Registers a routePattern in the global scheme namespace with a handlerBlock to call when the route pattern is matched by a URL.
  * The block returns a BOOL representing if the handlerBlock actually handled the route or not. If
  * a block returns NO, JLRoutes will continue trying to find a matching route.
 **/
- (void)addRoute:(NSString *)routePattern priority:(NSUInteger)priority handler:(BOOL (^)(NSDictionary *parameters))handlerBlock;
- (void)addRoute:(NSString *)routePattern handler:(BOOL (^)(NSDictionary *parameters))handlerBlock;

/**
 * add route for handling a block (should be discovered by the controllerServiceProvider of this wireframe)
 */
- (void)addRoute:(NSString *)routePattern;


/**
 * add route for pushing a view controller (should be discovered by the controllerServiceProvider of this wireframe)
 */
- (void)addRoute:(NSString *)routePattern
         options:(NSObject<IVISPERRoutingOption>*)options;


/**
 * add route for a controller (instance will be discovered at runtime by the service provider)
 */
- (void)addRoute:(NSString *)routePattern
  withController:(UIViewController *)controller
         options:(NSObject<IVISPERRoutingOption>*)options;

- (void)addRoute:(NSString *)routePattern
        priority:(NSUInteger)priority
  withController:(UIViewController *)controller
         options:(NSObject<IVISPERRoutingOption>*)options;


/**
 * Routes a URL, calling handler blocks (for patterns that match URL) until 
 * one returns YES, optionally specifying add'l parameters
 **/
- (BOOL)routeURL:(NSURL *)URL; // instance method
- (BOOL)routeURL:(NSURL *)URL withParameters:(NSDictionary *)parameters;

/**
 * Returns whether a route exists for a URL
 **/
- (BOOL)canRouteURL:(NSURL *)URL; // instance method
- (BOOL)canRouteURL:(NSURL *)URL withParameters:(NSDictionary *)parameters;

/**
 * Prints the entire routing table
 **/
-(NSString*)printRoutingTable;

/**
 * Returns the global routing namespace
 **/
- (NSObject<IVISPERWireframe>*)globalRoutes;

/**
 * Returns a routing namespace for the given scheme
 */
- (NSObject<IVISPERWireframe>*)routesForScheme:(NSString *)scheme;

/**
 * Unregister and delete an entire scheme namespace
 */
- (void)unregisterRouteScheme:(NSString *)scheme;

/**
 * Getter and setter for the UINavigationController of this wireframe
 **/
-(UINavigationController*)navigationController;
-(void)setNavigationController:(UINavigationController*)navigationController;


/**
 * Getter and setter for the service provider
 **/
-(NSObject<IVISPERWireframeServiceProvider>*)serviceProvider;
-(void)setServiceProvider:(NSObject<IVISPERWireframeServiceProvider>*)serviceProvider;


/**
 *  IVISPERWireframeViewControllerServiceProvider for providing controllers when none are given
 */
-(NSObject<IVISPERWireframeViewControllerServiceProvider>*)controllerServiceProvider;
-(void)setControllerServiceProvider:(NSObject<IVISPERWireframeViewControllerServiceProvider>*)controllerServiceProvider;


/**
 *  IVISPERWireframeViewControllerServiceProvider for providing routing options when none are given
 */
-(NSObject<IVISPERWireframeRoutingOptionsServiceProvider>*)routingOptionsServiceProvider;
-(void)setRoutingOptionsServiceProvider:(NSObject<IVISPERWireframeRoutingOptionsServiceProvider>*)routingOptionsServiceProvider;


/**
 * Called any time routeURL returns NO. Respects shouldFallbackToGlobalRoutes.
 **/
@property (nonatomic, copy) void (^unmatchedURLHandler)(NSObject<IVISPERWireframe> *routes, NSURL *URL, NSDictionary *parameters);


/**
 * GENERATING CONVINIENCE ROUTING OPTIONS
 **/
-(NSObject<IVISPERRoutingOption> *)routingOption;
-(NSObject<IVISPERRoutingOption> *)routingOption:(BOOL)animated;

-(NSObject<IVISPERRoutingOption> *)pushRoutingOption;
-(NSObject<IVISPERRoutingOption> *)pushRoutingOption:(BOOL)animated;

-(NSObject<IVISPERRoutingOption> *)modalRoutingOption;
-(NSObject<IVISPERRoutingOption> *)modalRoutingOption:(BOOL)animated;


@end
