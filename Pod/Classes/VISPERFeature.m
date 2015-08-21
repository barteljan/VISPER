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
@property(nonatomic,strong)NSObject<IVISPERComposedInteractor>*interactor;

@end

@implementation VISPERFeature

-(UIViewController*)controllerForRoute:(NSString *)routePattern
                        routingOptions:(NSObject<IVISPERRoutingOption> *)options
                        withParameters:(NSDictionary *)parameters{
    return nil;
}


-(NSObject<IVISPERRoutingOption>*)optionForRoutePattern:(NSString *)routePattern
                                             parameters:(NSDictionary *)dictionary
                                         currentOptions:(NSObject<IVISPERRoutingOption> *)currentOptions{
    return currentOptions;
}

-(void)bootstrapWireframe:(NSObject<IVISPERWireframe> *)wireframe
               interactor:(NSObject<IVISPERComposedInteractor> *)interactor{
    
    self.wireframe = wireframe;
    self.interactor = interactor;
    
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

-(NSMutableArray*)routePatternStrings{
    if(!self->_routePatternStrings){
        self->_routePatternStrings = [NSMutableArray array];
    }
    
    return self->_routePatternStrings;
}
@end
