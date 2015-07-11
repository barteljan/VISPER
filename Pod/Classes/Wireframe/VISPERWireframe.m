//
//  VISPERWireframe.m
//  Pods
//
//  Created by Bartel on 11.07.15.
//
//

#import "VISPERWireframe.h"

@implementation VISPERWireframe

/**
 * init functions
 **/
-(instancetype)init{
    return [self initWithRoutes:[JLRoutes globalRoutes]];
}

-(instancetype)initWithRoutes:(JLRoutes*)routes{
    return [self initWithRoutes:routes navigationController:nil];
}

-(instancetype)initWithNavigationController:(UINavigationController*)navigationController{
    return [self initWithRoutes:[JLRoutes globalRoutes] navigationController:navigationController];
}

-(instancetype)initWithRoutes:(JLRoutes*)routes navigationController:(UINavigationController*)navigationController{
    self = [super init];
    if(self){
        self->_routes = routes;
        self->_navigationController = navigationController;
    }
    return self;
}

/**
 * Returns the global routing namespace
 **/
- (NSObject<IVISPERWireframe>*)globalRoutes{
    return [[VISPERWireframe alloc] initWithRoutes:[JLRoutes globalRoutes] navigationController:self.navigationController];
}

/**
 * Returns a routing namespace for the given scheme
 */
- (NSObject<IVISPERWireframe>*)routesForScheme:(NSString *)scheme{
    return [[VISPERWireframe alloc] initWithRoutes:[JLRoutes routesForScheme:scheme] navigationController:self.navigationController];
}

/**
 * Unregister and delete an entire scheme namespace
 */
- (void)unregisterRouteScheme:(NSString *)scheme{
    [JLRoutes unregisterRouteScheme:scheme];
}

/**
 * Removes a routePattern from the receiving scheme namespace.
 **/
- (void)removeRoute:(NSString *)routePattern{
    [self.routes removeRoute:routePattern];
}

/**
 * Registers a routePattern in the global scheme namespace with a handlerBlock to call when the route pattern is matched by a URL.
 * The block returns a BOOL representing if the handlerBlock actually handled the route or not. If
 * a block returns NO, JLRoutes will continue trying to find a matching route.
 **/
- (void)addRoute:(NSString *)routePattern priority:(NSUInteger)priority handler:(BOOL (^)(NSDictionary *parameters))handlerBlock{
    [self.routes addRoute:routePattern priority:priority handler:handlerBlock];
}

- (void)addRoute:(NSString *)routePattern handler:(BOOL (^)(NSDictionary *parameters))handlerBlock{
    [self.routes addRoute:routePattern handler:handlerBlock];
}

/**
 * Registers a routePattern in the global scheme namespace with a UIViewController to push on the wireframes navigation controller
 * when the route pattern is matched by a URL.
 **/
- (void)addRoute:(NSString *)routePattern priority:(NSUInteger)priority pushedViewController:(UIViewController*)viewController{
    
    VISPERWireframe *wireframe = self;
    
    [self.routes addRoute:routePattern
                 priority:priority
                  handler:^BOOL(NSDictionary *parameters) {
                      if([wireframe.navigationController respondsToSelector:@selector(showViewController:sender:)]){
                          [wireframe.navigationController showViewController:viewController sender:wireframe];
                      }else{
                          [wireframe.navigationController pushViewController:viewController animated:YES];
                      }
                      return TRUE;
                  }];
}

- (void)addRoute:(NSString *)routePattern pushedViewController:(UIViewController*)viewController{
    VISPERWireframe *wireframe = self;
    
    [self.routes addRoute:routePattern
                  handler:^BOOL(NSDictionary *parameters) {
                      if([wireframe.navigationController respondsToSelector:@selector(showViewController:sender:)]){
                          [wireframe.navigationController showViewController:viewController sender:wireframe];
                      }else{
                          [wireframe.navigationController pushViewController:viewController animated:YES];
                      }
                      return TRUE;
                  }];
}

/**
 * Registers a routePattern in the global scheme namespace with a modal UIViewController to be shown
 * when the route pattern is matched by a URL.
 **/

- (void)addRoute:(NSString *)routePattern priority:(NSUInteger)priority modalViewController:(UIViewController*)viewController{
    VISPERWireframe *wireframe = self;

    [self.routes addRoute:routePattern
                 priority:priority
                  handler:^BOOL(NSDictionary *parameters) {
                      [wireframe.navigationController presentViewController:viewController
                                                                   animated:YES
                                                                 completion:nil];
                      return TRUE;
                  }];
}

- (void)addRoute:(NSString *)routePattern modalViewController:(UIViewController*)viewController{

    VISPERWireframe *wireframe = self;

    [self.routes addRoute:routePattern
                  handler:^BOOL(NSDictionary *parameters) {
                      [wireframe.navigationController presentViewController:viewController
                                                                   animated:YES
                                                                 completion:nil];
                      return TRUE;
                  }];
}

/**
 * Registers a routePattern in the global scheme namespace with a UIViewController to be shown
 * when the route pattern is matched by a URL.
 **/

- (void)addRoute:(NSString *)routePattern priority:(NSUInteger)priority viewController:(UIViewController*)viewController{
    VISPERWireframe *wireframe = self;

    [self.routes addRoute:routePattern
                 priority:priority
                  handler:^BOOL(NSDictionary *parameters) {
                      [wireframe.navigationController setViewControllers:@[viewController] animated:YES];
                      return TRUE;
                  }];


}
- (void)addRoute:(NSString *)routePattern viewController:(UIViewController*)viewController{

    VISPERWireframe *wireframe = self;

    [self.routes addRoute:routePattern
                  handler:^BOOL(NSDictionary *parameters) {
                      [wireframe.navigationController setViewControllers:@[viewController] animated:YES];
                      return TRUE;
                  }];}

/**
 * Routes a URL, calling handler blocks (for patterns that match URL) until
 * one returns YES, optionally specifying add'l parameters
 **/
- (BOOL)routeURL:(NSURL *)URL{
    return [self.routes routeURL:URL];
}

- (BOOL)routeURL:(NSURL *)URL withParameters:(NSDictionary *)parameters{
    return [self.routes routeURL:URL withParameters:parameters];
}

/**
 * Returns whether a route exists for a URL
 **/
- (BOOL)canRouteURL:(NSURL *)URL{
    return [self.routes canRouteURL:URL];
}

- (BOOL)canRouteURL:(NSURL *)URL withParameters:(NSDictionary *)parameters{
    return [self.routes canRouteURL:URL];
}

/**
 * Prints the entire routing table
 **/
-(NSString*)printRoutingTable{
    return [self description];
}

-(NSString*)description{
    return [self.routes description];
}


@end
