//
//  VISPERWireframe.m
//  Pods
//
//  Created by Bartel on 11.07.15.
//
//

#import "VISPERWireframe.h"
#import "VISPERWireframeServiceProvider.h"
#import "PriorizedObjectStore.h"

@interface VISPERWireframe()
@property(nonatomic,strong)PriorizedObjectStore *privateControllerServiceProviders;
@property(nonatomic,strong)PriorizedObjectStore *privateRoutingOptionServiceProviders;
@end


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
    
    
    if(!options && self.routingOptionsServiceProviders){
        for (NSObject<IVISPERWireframeRoutingOptionsServiceProvider> *provider in self.routingOptionsServiceProviders) {
            options = [provider optionForRoutePattern:routePattern];
            if(options){
                break;
            }
        }
    }
    
    if(!options){
        @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                       reason:[NSString stringWithFormat:@"No routing options for routePattern:%@ found", routePattern]
                                     userInfo:@{
                                                @"routePattern"  :routePattern,
                                                }];
    }
    
    for(NSObject <IVISPERRoutingPresenter> *presenter in self.serviceProvider.routingPresenters){
        [presenter setControllerServiceProviders:[self controllerServiceProviders]];
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
    BOOL success = [self.routes routeURL:URL];
    
    if(success){
        return TRUE;
    }
    
    for(NSObject<IVISPERWireframe>*wireframe in self.childWireframes){
        success = [wireframe routeURL:URL];
        if(success){
            return TRUE;
        }
    }
    
    return FALSE;
}

- (BOOL)routeURL:(NSURL *)URL withParameters:(NSDictionary *)parameters{
    
    BOOL success = [self.routes routeURL:URL withParameters:parameters];
    
    if(success){
        return TRUE;
    }
    
    for(NSObject<IVISPERWireframe>*wireframe in self.childWireframes){
        success = [wireframe routeURL:URL withParameters:parameters];
        if(success){
            return TRUE;
        }
    }
    
    return FALSE;
}

/**
 * Returns whether a route exists for a URL
 **/
- (BOOL)canRouteURL:(NSURL *)URL{
    
    BOOL success = [self.routes canRouteURL:URL];
    
    if(success){
        return TRUE;
    }
    
    for(NSObject<IVISPERWireframe>*wireframe in self.childWireframes){
        success = [wireframe canRouteURL:URL];
        if(success){
            return TRUE;
        }
    }
    
    return FALSE;
}

- (BOOL)canRouteURL:(NSURL *)URL withParameters:(NSDictionary *)parameters{
    
    BOOL success = [self.routes canRouteURL:URL withParameters:parameters];
    
    if(success){
        return TRUE;
    }
    
    for(NSObject<IVISPERWireframe>*wireframe in self.childWireframes){
        success = [wireframe canRouteURL:URL withParameters:parameters];
        if(success){
            return TRUE;
        }
    }
    
    return FALSE;
}

/**
 *  IVISPERWireframeViewControllerServiceProvider for providing controllers when none are given
 */
-(PriorizedObjectStore*)privateControllerServiceProviders{
    if(!self->_privateControllerServiceProviders){
        self->_privateControllerServiceProviders = [[PriorizedObjectStore alloc] init];
    }
    return self->_privateControllerServiceProviders;
}


-(void)addControllerServiceProvider:(NSObject<IVISPERWireframeViewControllerServiceProvider>*)controllerServiceProvider
                       withPriority:(NSInteger)priority{
    [self.privateControllerServiceProviders addObject:controllerServiceProvider withPriority:priority];
}

-(void)removeControllerServiceProvider:(NSObject<IVISPERWireframeViewControllerServiceProvider>*)controllerServiceProvider{
    [self.privateControllerServiceProviders removeObject:controllerServiceProvider];
}

-(NSArray*)controllerServiceProviders{
    return [self.privateControllerServiceProviders allObjects];
}

/**
 *  IVISPERWireframeViewControllerServiceProvider for providing routing options when none are given
 */
-(PriorizedObjectStore*)privateRoutingOptionServiceProviders{
    if(!self->_privateRoutingOptionServiceProviders){
        self->_privateRoutingOptionServiceProviders = [[PriorizedObjectStore alloc] init];
    }
    
    return self->_privateRoutingOptionServiceProviders;
}



-(void)addRoutingOptionsServiceProvider:(NSObject<IVISPERWireframeRoutingOptionsServiceProvider>*)routingOptionsServiceProvider
                           withPriority:(NSInteger)priority{
    [self.privateRoutingOptionServiceProviders addObject:routingOptionsServiceProvider withPriority:priority];
}


-(void)removeRoutingOptionsServiceProvider:(NSObject<IVISPERWireframeRoutingOptionsServiceProvider>*)routingOptionsServiceProvider{
    [self.privateRoutingOptionServiceProviders removeObject:routingOptionsServiceProvider];
}

-(NSArray*)routingOptionsServiceProviders{
    return [self.privateRoutingOptionServiceProviders allObjects];
}


/**
 *
 * Child wireframe instances
 *
 */
-(NSArray*)childWireframes{
    if(!self->_childWireframes){
        self->_childWireframes = [NSArray array];
    }
    return self->_childWireframes;
}

/**
 * Add child wireframe
 **/
-(void)addChildWireframe:(NSObject<IVISPERWireframe>*)wireframe{
    self.childWireframes = [self.childWireframes arrayByAddingObject:wireframe];
}

/**
 * Remove child wireframe
 **/
-(void)removeChildWireframe:(NSObject<IVISPERWireframe>*)wireframe{
    NSMutableArray *mutableChildren = [NSMutableArray arrayWithArray:self.childWireframes];
    [mutableChildren removeObject:wireframe];
    self.childWireframes = [NSArray arrayWithArray:mutableChildren];
}


/**
 * Check for child wireframe
 **/
-(BOOL)hasChildWireframe:(NSObject<IVISPERWireframe>*)wireframe{
    return [self.childWireframes containsObject:wireframe];
}

-(BOOL)hasDescendantWireframe:(NSObject<IVISPERWireframe>*)wireframe{
    if([self hasChildWireframe:wireframe]){
        return TRUE;
    }
    
    for(NSObject<IVISPERWireframe> *childWireframe in self.childWireframes){
        if([childWireframe hasDescendantWireframe:wireframe]){
            return TRUE;
        }
    }
    
    return FALSE;
}

/**
 * Prints the entire routing table
 **/
-(NSString*)printRoutingTable{
    
    NSString *routingTable = [self description];
    
    for(NSObject<IVISPERWireframe>*wireframe in self.childWireframes){
        [routingTable stringByAppendingFormat:@"\n%@",[wireframe printRoutingTable]];
    }
    
    return routingTable;
}

-(NSString*)description{
    return [self.routes description];
}

/**
 * Generate an empty wireframe which can communicate with this wireframe
 **/
-(NSObject<IVISPERWireframe>*)emptyWireframe{
    return [self.serviceProvider emptyWireframeFromWireframe:self];
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
