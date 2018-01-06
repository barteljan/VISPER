//
//  UIViewController+VISPER.m
//  Pods
//
//  Created by Bartel on 18.07.15.
//
//

#import "UIViewController+VISPER.h"
#import "VISPERViewControllerServiceProvider.h"
#import <VISPER/VISPER-Swift.h>
@import VISPER_UIViewController;

#import <objc/runtime.h>

@implementation UIViewController (VISPER)
@dynamic visperPresenters;
@dynamic visperServiceProvider;
//@dynamic routePattern;
//@dynamic routeParameters;
@dynamic routingOptions;
@dynamic wireframe;


static BOOL areVISPEREventsOnAllViewControllersEnabledVar;

#pragma mark getter and setter for the visper service provider
-(NSObject<IVISPERViewControllerServiceProvider>*)visperServiceProvider{
    NSObject<IVISPERViewControllerServiceProvider> *provider = objc_getAssociatedObject(self, @selector(visperServiceProvider));
    if(!provider){
        provider = [[VISPERViewControllerServiceProvider alloc] init];
        [self setVisperServiceProvider:provider];
    }
    return provider;
}

-(void)setVisperServiceProvider:(NSObject<IVISPERViewControllerServiceProvider> *)visperServiceProvider{
    objc_setAssociatedObject(self, @selector(visperServiceProvider), visperServiceProvider , OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark routing options
-(NSObject<IVISPERRoutingOption> *)routingOptions{
    NSObject<IVISPERRoutingOption> *routingOption =  objc_getAssociatedObject(self, @selector(routingOptions));
    return routingOption;
}

-(void)setRoutingOptions:(NSObject<IVISPERRoutingOption> *)myRoutingOptions{
    objc_setAssociatedObject(self, @selector(routingOptions), myRoutingOptions , OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark wireframe
-(NSObject<IVISPERWireframe> *)wireframe{
    NSObject<IVISPERWireframe> *myWireframe = objc_getAssociatedObject(self, @selector(wireframe));
    return myWireframe;
}

-(void)setWireframe:(NSObject<IVISPERWireframe> *)myWireframe{
    objc_setAssociatedObject(self, @selector(wireframe), myWireframe , OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


#pragma mark presenter management
-(void)add:(NSObject<IVISPERPresenter> *)presenter {
    [self addVisperPresenter:presenter];
}

#pragma mark routing events
-(void)routingEvent:(NSObject<IVISPERRoutingEvent>*)event
      withWireframe:(NSObject<IVISPERWireframe>*)wireframe{
    
    
    for(NSObject<IVISPERPresenter>*somePresenter in [self visperPresenters] ){
        if([somePresenter conformsToProtocol:@protocol(IVISPERPresenter)]){
            NSObject<IVISPERPresenter> *presenter = (NSObject<IVISPERPresenter> *)somePresenter;
            if([presenter isResponsibleForController:self onEvent:event]){
                [presenter routingEvent:event
                             controller:self
                           andWireframe:wireframe];
            }
        }
    }
}


-(void)willRouteToViewControllerOnWireframe:(NSObject<IVISPERWireframe>*)wireframe
                               routePattern:(NSString*)routePattern
                                    options:(NSObject<IVISPERRoutingOption>*)options
                                 parameters:(NSDictionary *)parameters{
    
}

-(void)didRouteToViewControllerOnWireframe:(NSObject<IVISPERWireframe>*)wireframe
                              routePattern:(NSString*)routePattern
                                   options:(NSObject<IVISPERRoutingOption>*)options
                                parameters:(NSDictionary *)parameters{
    
}

-(void)willRoute:(WireframeObjc *)wireframe routeResult:(RouteResultObjc *)routeResult{
    
    
    VISPERWireframe *visperWireframe = [[VISPERWireframe alloc] initWithWireframe:wireframe];
    [self setWireframe:visperWireframe];
    
    NSObject<IVISPERRoutingOption> *option = [VISPERWireframe routingOptionWithRoutingOptionObjc:routeResult.routingOptionObjc error:nil];
    [self setRoutingOptions:option];
    
    [self willRouteToViewControllerOnWireframe:visperWireframe
                                  routePattern:routeResult.routePattern
                                       options:option
                                    parameters:routeResult.parameters];
    
}

-(void)didRoute:(WireframeObjc *)wireframe routeResult:(RouteResultObjc *)routeResult{
    
    VISPERWireframe *visperWireframe = [[VISPERWireframe alloc] initWithWireframe:wireframe];
    
     NSObject<IVISPERRoutingOption> *option = [VISPERWireframe routingOptionWithRoutingOptionObjc:routeResult.routingOptionObjc error:nil];
    
    [self didRouteToViewControllerOnWireframe:visperWireframe
                                  routePattern:routeResult.routePattern
                                       options:option
                                    parameters:routeResult.parameters];
}

-(void)willDismissViewController{

}

-(void)didDismissViewController{

}

#pragma mark forward view events to presenter

+(void)swizzleReplaceSelector:(SEL)originalSelector
                         with:(SEL)swizzledSelector{
    Class class = [self class];
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}


+ (void)enableVISPEREventsOnAllViewControllers {
    [self enableLifecycleEvents];
    areVISPEREventsOnAllViewControllersEnabledVar = TRUE;
}

+ (BOOL)areVISPEREventsOnAllViewControllersEnabled{
    return areVISPEREventsOnAllViewControllersEnabledVar;
}

-(void)dismissThisViewControllerAnimated:(BOOL)animated completion:(void (^)(void))completion {
    
    void(^eventCompletionBlock)(void) = ^{
        [self didDismissViewController];
        if(completion){
            completion();
        }
    };
    
    [completion copy];
    
    if(self.navigationController){
        
        [CATransaction begin];
        [self.navigationController popViewControllerAnimated:animated];
        [CATransaction setCompletionBlock:eventCompletionBlock];
        [CATransaction commit];
        
    }else{
        [self dismissViewControllerAnimated:animated completion:eventCompletionBlock];
    }
}

@end
