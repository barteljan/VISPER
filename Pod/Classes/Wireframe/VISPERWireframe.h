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

@interface VISPERWireframe : NSObject<IVISPERWireframe>

/**
 * JLRoutes object for routing
 **/
@property(nonatomic)JLRoutes *routes;

/**
 *  Service Provider for getting controller instances an routing blocks at runtime
 **/
@property(nonatomic)IBOutlet NSObject<IVISPERWireframeServiceProvider>*serviceProvider;

/**
 * Navigation controller of the wireframe
 **/
@property(nonatomic) IBOutlet UINavigationController *navigationController;

/**
 * Called any time routeURL returns NO. Respects shouldFallbackToGlobalRoutes.
 **/
@property (nonatomic, copy) void (^unmatchedURLHandler)(NSObject<IVISPERWireframe> *routes, NSURL *URL, NSDictionary *parameters);

/**
 * init functions
 **/

-(instancetype)initWithServiceProvider:(NSObject<IVISPERWireframeServiceProvider>*)serviceProvider;
-(instancetype)initWithRoutes:(JLRoutes*)routes;
-(instancetype)initWithNavigationController:(UINavigationController*)navigationController;

-(instancetype)initWithRoutes:(JLRoutes*)routes
              serviceProvider:(NSObject<IVISPERWireframeServiceProvider>*)serviceProvider;

-(instancetype)initWithRoutes:(JLRoutes*)routes
         navigationController:(UINavigationController*)navigationController;

-(instancetype)initWithRoutes:(JLRoutes*)routes
         navigationController:(UINavigationController*)navigationController
              serviceProvider:(NSObject<IVISPERWireframeServiceProvider>*)serviceProvider;

-(instancetype)initWithNavigationController:(UINavigationController*)navigationController
                            serviceProvider:(NSObject<IVISPERWireframeServiceProvider>*)serviceProvider;

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
 * add route for handling a block (block instance will be discovered at runtime 
 * by the service provider)
 */
- (void)addRoute:(NSString *)routePattern;

/**
 * Registers a routePattern in the global scheme namespace with a UIViewController to push on the wireframes navigation controller
 * when the route pattern is matched by a URL.
 **/
- (void)addRoute:(NSString *)routePattern priority:(NSUInteger)priority pushedViewController:(UIViewController*)viewController;
- (void)addRoute:(NSString *)routePattern pushedViewController:(UIViewController*)viewController;

/**
 * add route for pushing a controller (instance will be discovered at runtime by the service provider)
 */
- (void)addRouteForPushedController:(NSString*)routePattern;

/**
 * Registers a routePattern in the global scheme namespace with a modal UIViewController to be shown
 * when the route pattern is matched by a URL.
 **/
- (void)addRoute:(NSString *)routePattern priority:(NSUInteger)priority modalViewController:(UIViewController*)viewController;
- (void)addRoute:(NSString *)routePattern modalViewController:(UIViewController*)viewController;

/**
 * add route for a modal controller (instance will be discovered at runtime by the service provider)
 */
- (void)addRouteForModalController:(NSString*)routePattern;

/**
 * Registers a routePattern in the global scheme namespace with a UIViewController to be shown
 * when the route pattern is matched by a URL.
 **/
- (void)addRoute:(NSString *)routePattern priority:(NSUInteger)priority viewController:(UIViewController*)viewController;
- (void)addRoute:(NSString *)routePattern viewController:(UIViewController*)viewController;

/**
 * add route for a controller (instance will be discovered at runtime by the service provider)
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



@end
