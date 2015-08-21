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
#import "IVISPERRoutingOptionsFactory.h"

@protocol IVISPERWireframe <NSObject>

/**
  * Removes a routePattern from the receiving scheme namespace.
 **/
- (void)removeRoute:(NSString *)routePattern;

/**
 * add route for handling a contoller or a (should be discovered by the controllerServiceProvider of this wireframe)
 */
- (void)addRoute:(NSString *)routePattern;

- (void)addRoute:(NSString *)routePattern
        priority:(NSUInteger)priority
         handler:(BOOL (^)(NSDictionary *parameters))handlerBlock;

/**
 * Routes a URL, calling handler blocks (for patterns that match URL) until 
 * one returns YES, optionally specifying add'l parameters
 **/
- (BOOL)routeURL:(NSURL *)URL;
- (BOOL)routeURL:(NSURL *)URL withParameters:(NSDictionary *)parameters;
- (BOOL)routeURL:(NSURL *)URL withParameters:(NSDictionary *)parameters options:(NSObject<IVISPERRoutingOption>*)options;


/**
* Returns the controller presented by the wireframe when routing this URL
*/
-(UIViewController*)controllerForURL:(NSURL*)URL withParameters:(NSDictionary *)parameters;

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
 * Getter and setter for the service provider
 **/
-(NSObject<IVISPERWireframeServiceProvider>*)serviceProvider;
-(void)setServiceProvider:(NSObject<IVISPERWireframeServiceProvider>*)serviceProvider;


/**
 *  IVISPERWireframeViewControllerServiceProvider for providing controllers when none are given
 */
-(void)addControllerServiceProvider:(NSObject<IVISPERWireframeViewControllerServiceProvider>*)controllerServiceProvider
                       withPriority:(NSInteger)priority;

-(void)removeControllerServiceProvider:(NSObject<IVISPERWireframeViewControllerServiceProvider>*)controllerServiceProvider;

-(NSArray*)controllerServiceProviders;


/**
 * add Routing presenter, responsible for routing controllers with specific RoutingOptions
 **/
-(void)addRoutingPresenter:(NSObject<IVISPERRoutingPresenter>*)presenter withPriority:(NSInteger)priority;
-(void)removeRoutingPresenter:(NSObject<IVISPERRoutingPresenter>*)presenter;
-(NSArray*)routingPresenters;


/**
 *  IVISPERWireframeViewControllerServiceProvider for providing routing options when none are given
 */

-(void)addRoutingOptionsServiceProvider:(NSObject<IVISPERWireframeRoutingOptionsServiceProvider>*)routingOptionsServiceProvider
                           withPriority:(NSInteger)priority;

-(void)removeRoutingOptionsServiceProvider:(NSObject<IVISPERWireframeRoutingOptionsServiceProvider>*)routingOptionsServiceProvider;

-(NSArray*)routingOptionsServiceProviders;



/**
 *
 * Child wireframe instances
 *
 */


/**
 * Add child wireframe
 **/
-(void)addChildWireframe:(NSObject<IVISPERWireframe>*)wireframe;

/**
 * Remove child wireframe
 **/
-(void)removeChildWireframe:(NSObject<IVISPERWireframe>*)wireframe;


/**
 * Check for child wireframe
 **/
-(BOOL)hasChildWireframe:(NSObject<IVISPERWireframe>*)wireframe;


/**
 * Check if this wireframe is a descendant of the current wireframe
 **/
-(BOOL)hasDescendantWireframe:(NSObject<IVISPERWireframe>*)wireframe;


/**
 * Called any time routeURL returns NO. Respects shouldFallbackToGlobalRoutes.
 **/
@property (nonatomic, copy) void (^unmatchedURLHandler)(NSObject<IVISPERWireframe> *routes, NSURL *URL, NSDictionary *parameters);

/**
 * Generate an empty wireframe which can communicate with this wireframe
 **/
-(NSObject<IVISPERWireframe>*)emptyWireframe;

/**
 * Factory for generating routing options internally
 */
-(void)setRoutingOptionsFactory:(NSObject<IVISPERRoutingOptionsFactory>*)factory;
-(NSObject<IVISPERRoutingOptionsFactory>*)routingOptionsFactory;
@end
