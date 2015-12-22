//
//  VISPERFeature.m
//  Pods
//
//  Created by Bartel on 20.08.15.
//
//

#import "VISPERFeature.h"
@interface VISPERFeature()

@property(nonatomic,strong)NSMutableArray *routePatternStrings;
@property(nonatomic,strong)NSObject<IVISPERWireframe>*wireframe;
@property(nonatomic,strong)NSObject<IVISPERCommandBus>*commandBus;

@end

@implementation VISPERFeature

#pragma mark IVISPERFeature protocol

-(void)bootstrapWireframe:(NSObject<IVISPERWireframe> *)wireframe
               commandBus:(NSObject<IVISPERCommandBus> *)commandBus{
    
    self.wireframe = wireframe;
    self.commandBus = commandBus;
    
    [wireframe addControllerServiceProvider:self withPriority:0];
    [wireframe addRoutingOptionsServiceProvider:self withPriority:0];


}

-(NSArray*)routePatterns{
    return [NSArray arrayWithArray:self.routePatternStrings];
}

-(void)addRoutePattern:(NSString*)routePattern{
    [self.routePatternStrings addObject:routePattern];
}

-(void)removeRoutePattern:(NSString*)routePattern{
    [self->_routePatternStrings removeObject:routePattern];
}


#pragma mark IVISPERWireframeViewControllerServiceProvider protocol
-(UIViewController*)controllerForRoute:(NSString *)routePattern
                        routingOptions:(NSObject<IVISPERRoutingOption> *)options
                        withParameters:(NSDictionary *)parameters{
    return nil;
}


#pragma mark IVISPERWireframeRoutingOptionsServiceProvider protocol
-(NSObject<IVISPERRoutingOption>*)optionForRoutePattern:(NSString *)routePattern
                                             parameters:(NSDictionary *)dictionary
                                         currentOptions:(NSObject<IVISPERRoutingOption> *)currentOptions{
    return currentOptions;
}


#pragma mark internal functions
-(NSMutableArray*)routePatternStrings{
    if(!self->_routePatternStrings){
        self->_routePatternStrings = [NSMutableArray array];
    }
    
    return self->_routePatternStrings;
}

#pragma mark deprecated functions
-(void)bootstrapWireframe:(NSObject<IVISPERWireframe> *)wireframe
               interactor:(NSObject<IVISPERComposedInteractor> *)interactor{
    
    [self bootstrapWireframe:wireframe commandBus:interactor];
}
@end
