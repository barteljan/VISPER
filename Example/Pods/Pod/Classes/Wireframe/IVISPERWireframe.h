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

@protocol IVISPERWireframe <NSObject>

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
 * add route for handling a block (block instance will be discovered at runtime)
 */
- (void)addRoute:(NSString *)routePattern;

/**
 * Registers a routePattern in the global scheme namespace with a UIViewController to push on the wireframes navigation controller
 * when the route pattern is matched by a URL.
 **/
- (void)addRoute:(NSString *)routePattern priority:(NSUInteger)priority pushedViewController:(UIViewController*)viewController;
- (void)addRoute:(NSString *)routePattern pushedViewController:(UIViewController*)viewController;

/**
 * add route for pushing a controller (instance will be discovered at runtime)
 */
- (void)addRouteForPushedController:(NSString*)routePattern;

/**
 * Registers a routePattern in the global scheme namespace with a modal UIViewController to be shown
 * when the route pattern is matched by a URL.
 **/
- (void)addRoute:(NSString *)routePattern priority:(NSUInteger)priority modalViewController:(UIViewController*)viewController;
- (void)addRoute:(NSString *)routePattern modalViewController:(UIViewController*)viewController;

/**
 * add route for a modal controller (instance will be discovered at runtime)
 */
- (void)addRouteForModalController:(NSString*)routePattern;

/**
 * Registers a routePattern in the global scheme namespace with a UIViewController to be shown
 * when the route pattern is matched by a URL.
 **/
- (void)addRoute:(NSString *)routePattern priority:(NSUInteger)priority viewController:(UIViewController*)viewController;
- (void)addRoute:(NSString *)routePattern viewController:(UIViewController*)viewController;

/**
 * add route for a controller (instance will be discovered at runtime)
 */
- (void)addControllerRoute:(NSString *)routePattern;

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
- (BOOL)canRouteURL:(NSURL *)URL withParameters:(NSDictionary *)parameters; // instance method

/**
 * Prints the entire routing table
 **/
-(NSString*)printRoutingTable;

/**
 * Called any time routeURL returns NO. Respects shouldFallbackToGlobalRoutes.
 **/
@property (nonatomic, copy) void (^unmatchedURLHandler)(NSObject<IVISPERWireframe> *routes, NSURL *URL, NSDictionary *parameters);



@end
