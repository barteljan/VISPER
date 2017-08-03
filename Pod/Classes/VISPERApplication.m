//
//  VISPERApplication.m
//  Pods
//
//  Created by Bartel on 20.08.15.
//
//

#import "VISPERApplication.h"
#import "VISPERWireframe.h"
#import "VISPERPushRoutingPresenter.h"
#import "VISPERModalRoutingPresenter.h"
#import "VISPERRootVCRoutingPresenter.h"
#import "VISPERReplaceTopVCRoutingPresenter.h"
#import "VISPERShowRoutingPresenter.h"
@import VISPER_CommandBus;

@interface VISPERApplication()
@property(nonatomic,strong)UINavigationController *navigationController;
@property(nonatomic,strong)NSObject<IVISPERWireframe> *wireframe;
@property(nonatomic,strong)VISPERCommandBus *commandBus;
@end

@implementation VISPERApplication

-(instancetype)init{
    return [self initWithNavigationController:nil
                                    wireframe:nil
                                   commandBus:nil];
}

-(instancetype)initWithNavigationController:(UINavigationController*)controller{
    return [self initWithNavigationController:controller wireframe:nil commandBus:nil];
}

-(instancetype)initWithNavigationController:(UINavigationController*)controller
                                  wireframe:(NSObject<IVISPERWireframe>*)wireframe{
    return [self initWithNavigationController:controller
                                    wireframe:wireframe
                                   commandBus:nil];
}

-(instancetype)initWithNavigationController:(UINavigationController*)controller
                                  wireframe:(NSObject<IVISPERWireframe>*)wireframe
                                 commandBus:(VISPERCommandBus*)commandBus{
    self = [super init];
    if(self){
        
        if(!wireframe){
            wireframe = [[VISPERWireframe alloc] init];
        }
        
        if(!commandBus){
            commandBus = [[VISPERCommandBus alloc] init];
        }
        
        if(!controller){
            controller = [[UINavigationController alloc] init];
        }
        
        self->_navigationController = controller;
        self->_wireframe = wireframe;
        self->_commandBus = commandBus;
        
        [self addRoutingPresenter:[[VISPERPushRoutingPresenter alloc] initWithNavigationController:self.navigationController]
                     withPriority:0];
        [self addRoutingPresenter:[[VISPERModalRoutingPresenter alloc] initWithNavigationController:self.navigationController]
                     withPriority:0];
        [self addRoutingPresenter:[[VISPERRootVCRoutingPresenter alloc] initWithNavigationController:self.navigationController]
                     withPriority:0];
        [self addRoutingPresenter:[[VISPERReplaceTopVCRoutingPresenter alloc] initWithNavigationController:self.navigationController]
                     withPriority:0];
        [self addRoutingPresenter:[[VISPERShowRoutingPresenter alloc] initWithNavigationController:self.navigationController]
                     withPriority:0];
        
        [self setNavigationController:controller];
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
    
   if([feature respondsToSelector:@selector(bootstrapWireframe:commandBus:)]){
        [feature bootstrapWireframe:self.wireframe
                         commandBus:self.commandBus];
    }else{
        @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                       reason:@"a feature has to implement one of the following methods: bootstrapWireframe:commandBus: or bootstrapWireframe:interactor:"
                                     userInfo:nil];
    }
    
    
    if([feature respondsToSelector:@selector(routePatterns)]){
        NSArray *routePatterns = [feature routePatterns];
        
        for (NSString *routePattern in routePatterns) {
            [self.wireframe addRoute:routePattern];
        }
    }
}

-(void)addCommandHandler:(id)handler{
    [self.commandBus addHandler:handler];
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
    
    [self.wireframe setCurrentViewController:self.navigationController.topViewController];
}

@end
