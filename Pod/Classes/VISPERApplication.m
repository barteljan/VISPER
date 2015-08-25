//
//  VISPERApplication.m
//  Pods
//
//  Created by Bartel on 20.08.15.
//
//

#import "VISPERApplication.h"
#import "VISPERWireframe.h"
#import "VISPERComposedInteractor.h"
#import "VISPERPushRoutingPresenter.h"
#import "VISPERModalRoutingPresenter.h"
#import "VISPERRootVCRoutingPresenter.h"

@interface VISPERApplication()
@property(nonatomic,strong)UINavigationController *navigationController;
@property(nonatomic,strong)NSObject<IVISPERWireframe> *wireframe;
@property(nonatomic,strong)NSObject<IVISPERComposedInteractor> *interactor;
@end

@implementation VISPERApplication

-(instancetype)init{
    return [self initWithNavigationController:nil
                                    wireframe:nil
                                   interactor:nil];
}

-(instancetype)initWithNavigationController:(UINavigationController*)controller{
    return [self initWithNavigationController:controller wireframe:nil];
}

-(instancetype)initWithNavigationController:(UINavigationController*)controller
                                  wireframe:(NSObject<IVISPERWireframe>*)wireframe{
    return [self initWithNavigationController:controller
                                    wireframe:wireframe
                                   interactor:nil];
}

-(instancetype)initWithNavigationController:(UINavigationController*)controller
                                  wireframe:(NSObject<IVISPERWireframe>*)wireframe
                                 interactor:(NSObject<IVISPERComposedInteractor>*)interactor{
    self = [super init];
    if(self){
        
        if(!wireframe){
            wireframe = [[VISPERWireframe alloc] init];
        }
        
        if(!interactor){
            interactor = [[VISPERComposedInteractor alloc] initWithIdentifier:@"composedInteractor"];
        }
        
        if(!controller){
            controller = [[UINavigationController alloc] init];
        }
        
        self->_navigationController = controller;
        self->_wireframe = wireframe;
        self->_interactor = interactor;
        
        [self addRoutingPresenter:[[VISPERPushRoutingPresenter alloc] initWithNavigationController:self.navigationController]
                     withPriority:0];
        [self addRoutingPresenter:[[VISPERModalRoutingPresenter alloc] initWithNavigationController:self.navigationController]
                     withPriority:0];
        [self addRoutingPresenter:[[VISPERRootVCRoutingPresenter alloc] initWithNavigationController:self.navigationController]
                     withPriority:0];
    }
    return self;

}


-(UIViewController*)rootViewController{
    return self.navigationController;
}

-(void)addRoutingPresenter:(NSObject<IVISPERRoutingPresenter> *)routingPresenter
              withPriority:(NSInteger)priority{
    [self.wireframe addRoutingPresenter:routingPresenter withPriority:priority];
}

-(void)addFeature:(NSObject<IVISPERFeature> *)feature{
    [feature bootstrapWireframe:self.wireframe
                     interactor:self.interactor];
    
    if([feature respondsToSelector:@selector(routePatterns)]){
        NSArray *routePatterns = [feature routePatterns];
        
        for (NSString *routePattern in routePatterns) {
            [self.wireframe addRoute:routePattern];
        }
    }
}

-(BOOL)canRouteURL:(NSURL *)URL
    withParameters:(NSDictionary *)parameters{
    return [self.wireframe canRouteURL:URL withParameters:parameters];
}

-(BOOL)routeURL:(NSURL *)URL
 withParameters:(NSDictionary *)parameters
        options:(NSObject<IVISPERRoutingOption> *)options{
    return [self.wireframe routeURL:URL
                     withParameters:parameters
                            options:options];
}

-(UIViewController*)controllerForURL:(NSURL *)URL
                      withParameters:(NSDictionary *)parameters{
    return [self.wireframe controllerForURL:URL withParameters:parameters];
}


-(void)setNavigationController:(UINavigationController *)navigationController{
    self->_navigationController = navigationController;
    
    NSArray *routingPresenters = self.wireframe.routingPresenters;
    
    for(NSObject <IVISPERRoutingPresenter> *routingPresenter in routingPresenters){
        if([routingPresenter respondsToSelector:@selector(setNavigationController:)]){
            [routingPresenter performSelector:@selector(setNavigationController:) withObject:navigationController];
        }
    }
}
@end
