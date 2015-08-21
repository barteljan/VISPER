//
//  VISPERWireframe.m
//  Pods
//
//  Created by Bartel on 11.07.15.
//
//

#import "VISPERWireframe.h"
#import "VISPERWireframeServiceProvider.h"
#import "UIViewController+VISPER.h"
#import "VISPERDoNotPresentRoutingPresenter.h"
#import "IVISPERWireframePresentationTypeDoNotPresentVC.h"

@interface VISPERWireframe()

/**
 * JLRoutes object for routing
 **/
@property(nonatomic)JLRoutes *routes;

@property(nonatomic,strong) VISPERPriorizedObjectStore *privateControllerServiceProviders;
@property(nonatomic,strong) VISPERPriorizedObjectStore *privateRoutingOptionServiceProviders;
@property(nonatomic,strong) VISPERPriorizedObjectStore *privateRoutingPresenters;
@end


@implementation VISPERWireframe

/**
 * init functions
 **/
-(instancetype)init{
    VISPERWireframeServiceProvider *serviceProvider = [[VISPERWireframeServiceProvider alloc] init];
    return [self initWithRoutes:[JLRoutes globalRoutes]
                serviceProvider:serviceProvider];
}

-(instancetype)initWithServiceProvider:(NSObject<IVISPERWireframeServiceProvider>*)serviceProvider{
    
    return [self initWithRoutes:[JLRoutes globalRoutes]
                serviceProvider:serviceProvider];
}

-(instancetype)initWithRoutes:(JLRoutes*)routes{
    VISPERWireframeServiceProvider *serviceProvider = [[VISPERWireframeServiceProvider alloc] init];
    return [self initWithRoutes:routes
                serviceProvider:serviceProvider];
   
}

-(instancetype)initWithRoutes:(JLRoutes*)routes
              serviceProvider:(NSObject<IVISPERWireframeServiceProvider>*)serviceProvider{
    self = [super init];
    if(self){
        self->_routes = routes;
        self->_serviceProvider = serviceProvider;
        
        VISPERDoNotPresentRoutingPresenter *doNotRoutePresenter = [[VISPERDoNotPresentRoutingPresenter alloc] init];
        [self addRoutingPresenter:doNotRoutePresenter withPriority:0];
    }
    return self;
}


/**
 * Returns the global routing namespace
 **/
- (NSObject<IVISPERWireframe>*)globalRoutes{
    return [[VISPERWireframe alloc] initWithRoutes:[JLRoutes globalRoutes]];
}

/**
 * Returns a routing namespace for the given scheme
 */
- (NSObject<IVISPERWireframe>*)routesForScheme:(NSString *)scheme{
    return [[VISPERWireframe alloc] initWithRoutes:[JLRoutes routesForScheme:scheme]];
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
    [self addRoute:routePattern priority:0];
}

- (void)addRoute:(NSString *)routePattern priority:(NSInteger)priority{
    NSObject<IVISPERWireframe> *blockWireframe = self;
    
    [self addRoute:routePattern priority:priority handler:^BOOL(NSDictionary *parameters) {
        
        NSObject<IVISPERRoutingOption>* options = nil;
        
        //get routing options from parameters
        if([parameters objectForKey:@"routingOption"] && [[parameters objectForKey:@"routingOption"] conformsToProtocol:@protocol(IVISPERRoutingOption)]){
            options = [parameters objectForKey:@"routingOption"];
        }
        
        BOOL replacingOptionsAllowed = (!options) || ![options.wireframePresentationType conformsToProtocol:@protocol(IVISPERWireframePresentationTypeDoNotPresentVC)];
        
        //replace or create options from routing option service provider
        if(blockWireframe.routingOptionsServiceProviders && replacingOptionsAllowed){
            for (NSObject<IVISPERWireframeRoutingOptionsServiceProvider> *provider in blockWireframe.routingOptionsServiceProviders) {
                
                options = [provider optionForRoutePattern:routePattern
                                               parameters:parameters
                                           currentOptions:options];
            }
        }
        
        //get controller from controller service providers
        UIViewController *controller = nil;
        
        if(blockWireframe.controllerServiceProviders){
            for(NSObject<IVISPERWireframeViewControllerServiceProvider> *provider in blockWireframe.controllerServiceProviders){
                controller = [provider controllerForRoute:routePattern
                                           routingOptions:options
                                           withParameters:parameters];
                if(controller){
                    break;
                }
            }
            
        }
        
        if(!controller){
            @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                           reason:[NSString stringWithFormat:@"No controller for routePattern:%@ and parameters:%@ found", routePattern,parameters]
                                         userInfo:@{
                                                    @"routePattern"  :routePattern,
                                                    @"routingOptions":options,
                                                    @"parameters"     :parameters
                                                    }];
        }
        
        //TODO: presenter aus dem service provider raus
        for(NSObject <IVISPERRoutingPresenter> *presenter in blockWireframe.routingPresenters){
            
            if([presenter isResponsibleForRoutingOption:options]){
                
                //send will route event
                NSObject <IVISPERRoutingEvent> *willRouteToControllerEvent =
                [blockWireframe.serviceProvider createEventWithName:@"willRouteToController"
                                                             sender:blockWireframe
                                                               info:@{
                                                                      @"routePattern":routePattern,
                                                                      @"options" : options,
                                                                      @"parameters": parameters
                                                                      }];
                [controller routingEvent:willRouteToControllerEvent withWireframe:blockWireframe];
                
                
                
                [presenter routeForPattern:routePattern
                                controller:controller
                                   options:options
                                parameters:parameters
                               onWireframe:blockWireframe
                                completion:^(NSString *routePattern,
                                             UIViewController *controller,
                                             NSObject<IVISPERRoutingOption> *option,
                                             NSDictionary *parameters,
                                             NSObject<IVISPERWireframe> *wireframe) {
                                    
                                    //send did route event
                                    NSObject <IVISPERRoutingEvent> *didRouteToControllerEvent =
                                    [wireframe.serviceProvider createEventWithName:@"didRouteToController"
                                                                            sender:wireframe
                                                                              info:@{
                                                                                     @"routePattern":routePattern,
                                                                                     @"options" : options,
                                                                                     @"parameters": parameters
                                                                                     }];
                                    [controller routingEvent:didRouteToControllerEvent withWireframe:wireframe];
                                }];
                return YES;
            }
        }
        
        return NO;
        
    }];

}

- (void)addRoute:(NSString *)routePattern
         handler:(BOOL (^)(NSDictionary *parameters))handlerBlock{
    [self addRoute:routePattern priority:0 handler:handlerBlock];
}


- (void)addRoute:(NSString *)routePattern
        priority:(NSUInteger)priority
         handler:(BOOL (^)(NSDictionary *parameters))handlerBlock{
    [self.routes addRoute:routePattern priority:priority handler:handlerBlock];
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

- (BOOL)routeURL:(NSURL *)URL withParameters:(NSDictionary *)parameters options:(NSObject<IVISPERRoutingOption>*)options{
    NSMutableDictionary *tempParameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [tempParameters setObject:options forKey:@"routingOption"];
    parameters = [NSDictionary dictionaryWithDictionary:tempParameters];
    return [self routeURL:URL withParameters:parameters];
}

/**
* Returns the controller presented by the wireframe when routing this URL
*/
-(UIViewController*)controllerForURL:(NSURL*)URL withParameters:(NSDictionary *)parameters{
    __block UIViewController *blockVC  = nil;
    
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    
    NSObject<IVISPERRoutingOption> *doNotPresentVCOption = [self.serviceProvider doNotPresentVCOption:^(NSString *routePattern,
                                                                                                        UIViewController *controller,
                                                                                                        NSObject<IVISPERRoutingOption> *options,
                                                                                                        NSDictionary *parameters,
                                                                                                        NSObject<IVISPERWireframe> *wireframe) {
        blockVC = controller;
        dispatch_semaphore_signal(sem);
    }];

    [self routeURL:URL withParameters:parameters options:doNotPresentVCOption];
    
    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
    
    return blockVC;
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
 * Add and remove routing presenters
 **/
-(VISPERPriorizedObjectStore*)privateRoutingPresenters{
    if(!self->_privateRoutingPresenters){
        self->_privateRoutingPresenters = [[VISPERPriorizedObjectStore alloc] init];
    }
    return self->_privateRoutingPresenters;
}

-(void)addRoutingPresenter:(NSObject<IVISPERRoutingPresenter>*)presenter withPriority:(NSInteger)priority{
    [self.privateRoutingPresenters addObject:presenter withPriority:priority];
}


-(void)removeRoutingPresenter:(NSObject<IVISPERRoutingPresenter>*)presenter{
    [self.privateRoutingPresenters removeObject:presenter];
}

-(NSArray*)routingPresenters{
    return [self.privateRoutingPresenters allObjects];
}


/**
 *  IVISPERWireframeViewControllerServiceProvider for providing controllers when none are given
 */
-(VISPERPriorizedObjectStore *)privateControllerServiceProviders{
    if(!self->_privateControllerServiceProviders){
        self->_privateControllerServiceProviders = [[VISPERPriorizedObjectStore alloc] init];
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
-(VISPERPriorizedObjectStore *)privateRoutingOptionServiceProviders{
    if(!self->_privateRoutingOptionServiceProviders){
        self->_privateRoutingOptionServiceProviders = [[VISPERPriorizedObjectStore alloc] init];
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

-(NSObject<IVISPERRoutingOption> *)presentRootVCRoutingOption{
    return [self.serviceProvider presentRootVCRoutingOption:YES];
}

-(NSObject<IVISPERRoutingOption> *)presentRootVCRoutingOption:(BOOL)animated{
    return [self.serviceProvider presentRootVCRoutingOption:animated];
}

@end
