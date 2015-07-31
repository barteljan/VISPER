//
//  VISPERRoutingPresenter.m
//  Pods
//
//  Created by Bartel on 18.07.15.
//
//

#import "VISPERRoutingPresenter.h"
#import "VISPERRoutingPresenterServiceProvider.h"
#import "UIViewController+VISPER.h"

@implementation VISPERRoutingPresenter

-(instancetype)init{
    VISPERRoutingPresenterServiceProvider *provider = [[VISPERRoutingPresenterServiceProvider alloc] init];
    return [self initWithServiceProvider:provider];
}


-(instancetype)initWithServiceProvider:(NSObject<IVISPERRoutingPresenterServiceProvider>*)serviceProvider{
    self = [super init];
    if(self){
        self->_serviceProvider = serviceProvider;
    }
    return self;
}


-(BOOL)isResponsibleForRoutingOption:(NSObject<IVISPERRoutingOption>*)routingOption{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

-(UIViewController*)controllerForRoute:(NSString*)routePattern
                        routingOptions:(NSObject<IVISPERRoutingOption>*)options
                        withParameters:(NSDictionary*)parameters{
    
    UIViewController *controller = nil;
    
    if(self.controllerServiceProviders){
        for(NSObject<IVISPERWireframeViewControllerServiceProvider> *provider in self.controllerServiceProviders){
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
                                                    @"paameters"     :parameters
                                                }];
    }

    return controller;
}

- (void)addRoute:(NSString *)routePattern
        priority:(NSUInteger)priority
  withController:(UIViewController*)controller
         options:(NSObject<IVISPERRoutingOption>*)options
     onWireframe:(NSObject<IVISPERWireframe>*)wireframe{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

-(void)sendWillRouteToControllerEventForController:(UIViewController*)controller
                                         wireframe:(NSObject<IVISPERWireframe>*)wireframe
                                      routePattern:(NSString*)routePattern
                                          priority:(NSInteger)priority
                                           options:(NSObject<IVISPERRoutingOption>*)options
                                        parameters:(NSDictionary*)parameters{
    NSObject <IVISPERRoutingEvent> *willRouteToControllerEvent =
    [self.serviceProvider createEventWithName:@"willRouteToController"
                                       sender:wireframe
                                         info:@{
                                                @"routePattern":routePattern,
                                                @"priority":[NSNumber numberWithLong:priority],
                                                @"options" : options,
                                                @"parameters": parameters
                                                }];
    [controller routingEvent:willRouteToControllerEvent withWireframe:wireframe];

}

-(void)sendDidRouteToControllerEventForController:(UIViewController*)controller
                                         wireframe:(NSObject<IVISPERWireframe>*)wireframe
                                      routePattern:(NSString*)routePattern
                                          priority:(NSInteger)priority
                                           options:(NSObject<IVISPERRoutingOption>*)options
                                        parameters:(NSDictionary*)parameters{
    NSObject <IVISPERRoutingEvent> *willRouteToControllerEvent =
    [self.serviceProvider createEventWithName:@"didRouteToController"
                                       sender:wireframe
                                         info:@{
                                                @"routePattern":routePattern,
                                                @"priority":[NSNumber numberWithLong:priority],
                                                @"options" : options,
                                                @"parameters": parameters
                                                }];
    [controller routingEvent:willRouteToControllerEvent withWireframe:wireframe];
    
}


@end
