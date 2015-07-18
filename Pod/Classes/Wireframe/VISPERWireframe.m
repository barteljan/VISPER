//
//  VISPERWireframe.m
//  Pods
//
//  Created by Bartel on 11.07.15.
//
//

#import "VISPERWireframe.h"
#import "VISPERWireframeServiceProvider.h"

@implementation VISPERWireframe

/**
 * init functions
 **/
-(instancetype)init{
    VISPERWireframeServiceProvider *serviceProvider = [[VISPERWireframeServiceProvider alloc] init];
    return [self initWithRoutes:[JLRoutes globalRoutes]
           navigationController:nil
                serviceProvider:serviceProvider];
}

-(instancetype)initWithNavigationController:(UINavigationController*)navigationController{
    VISPERWireframeServiceProvider *serviceProvider = [[VISPERWireframeServiceProvider alloc] init];
    return [self initWithRoutes:[JLRoutes globalRoutes]
           navigationController:navigationController
                serviceProvider:serviceProvider];
}

-(instancetype)initWithNavigationController:(UINavigationController*)navigationController
                            serviceProvider:(NSObject<IVISPERWireframeServiceProvider>*)serviceProvider{
    
    return [self initWithRoutes:[JLRoutes globalRoutes]
           navigationController:navigationController
                serviceProvider:serviceProvider];
}

-(instancetype)initWithRoutes:(JLRoutes*)routes
         navigationController:(UINavigationController*)navigationController{
    VISPERWireframeServiceProvider *serviceProvider = [[VISPERWireframeServiceProvider alloc] init];
    return [self initWithRoutes:routes
           navigationController:navigationController
                serviceProvider:serviceProvider];
   
}

-(instancetype)initWithRoutes:(JLRoutes*)routes
         navigationController:(UINavigationController*)navigationController
              serviceProvider:(NSObject<IVISPERWireframeServiceProvider>*)serviceProvider{
    self = [super init];
    if(self){
        self->_routes = routes;
        self->_navigationController = navigationController;
        self->_serviceProvider = serviceProvider;
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

- (void)addRoute:(NSString *)routePattern{
    [self addRoute:routePattern options:nil];
}

- (void)addRoute:(NSString *)routePattern
        priority:(NSUInteger)priority
         handler:(BOOL (^)(NSDictionary *parameters))handlerBlock{
    [self.routes addRoute:routePattern priority:priority handler:handlerBlock];
}

- (void)addRoute:(NSString *)routePattern
         handler:(BOOL (^)(NSDictionary *parameters))handlerBlock{
    [self addRoute:routePattern priority:0 handler:handlerBlock];
}

- (void)addRoute:(NSString *)routePattern
         options:(NSObject<IVISPERRoutingOption>*)options{
    
    
    [self addRoute:routePattern
    withController:nil
           options:options];
    
}

- (void)addRoute:(NSString *)routePattern
  withController:(UIViewController *)controller
         options:(NSObject<IVISPERRoutingOption>*)options{
    [self addRoute:routePattern
          priority:0
    withController:controller
           options:options];
}

- (void)addRoute:(NSString *)routePattern
        priority:(NSUInteger)priority
  withController:(UIViewController *)controller
         options:(NSObject<IVISPERRoutingOption>*)options{
    
    
    if(!options && self.routingOptionsServiceProvider){
        options = [self.routingOptionsServiceProvider optionForRoutePattern:routePattern];
    }
    
    if(!options){
        @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                       reason:[NSString stringWithFormat:@"No routing options for routePattern:%@ found", routePattern]
                                     userInfo:@{
                                                @"routePattern"  :routePattern,
                                                }];
    }
    
    for(NSObject <IVISPERRoutingPresenter> *presenter in self.serviceProvider.routingPresenters){
        [presenter setControllerServiceProvider:self.controllerServiceProvider];
        if([presenter isResponsibleForRoutingOption:options]){
            [presenter addRoute:routePattern
                       priority:priority
                 withController:controller
                        options:options
                    onWireframe:self];
            break;
        }
        
    }

}

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

/**
* GENERATING ROUTING OPTIONS
**/
-(NSObject<IVISPERRoutingOption> *)routingOption{
    return [self routingOption:YES];
}

-(NSObject<IVISPERRoutingOption> *)pushRoutingOption{
    return [self pushRoutingOption:YES];
}

-(NSObject<IVISPERRoutingOption> *)modalRoutingOption{
    return [self modalRoutingOption:YES];
}

-(NSObject<IVISPERRoutingOption> *)routingOption:(BOOL)animated{
    return [self.serviceProvider routingOption:animated];
}

-(NSObject<IVISPERRoutingOption> *)pushRoutingOption:(BOOL)animated{
    return [self.serviceProvider pushRoutingOption:animated];
}

-(NSObject<IVISPERRoutingOption> *)modalRoutingOption:(BOOL)animated{
    return [self.serviceProvider modalRoutingOption:animated];
}

@end
