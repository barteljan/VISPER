//
//  UIViewController+VISPER.m
//  Pods
//
//  Created by Bartel on 18.07.15.
//
//

#import "UIViewController+VISPER.h"
#import "VISPERViewControllerServiceProvider.h"

#import <objc/runtime.h>

@implementation UIViewController (VISPER)
@dynamic visperPresenters;
@dynamic visperServiceProvider;

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


#pragma mark presenter management
-(NSMutableArray*)privatePresentersArray{
    NSMutableArray *presenters = objc_getAssociatedObject(self, @selector(visperPresenters));
    if(!presenters){
        presenters = [NSMutableArray array];
        objc_setAssociatedObject(self, @selector(visperPresenters), presenters , OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return presenters;
}

-(NSArray*)visperPresenters{
    return [NSArray arrayWithArray:[self privatePresentersArray]];
}

-(void)addVisperPresenter:(NSObject<IVISPERPresenter> *)presenter{
    [[self privatePresentersArray] addObject:presenter];
}

-(void)removeVisperPresenter:(NSObject<IVISPERPresenter> *)presenter{
    [[self privatePresentersArray] removeObject:presenter];
}

-(void)notifyPresentersOfView:(UIView*)view
                    withEvent:(NSObject<IVISPERViewEvent>*)event{
    for(NSObject<IVISPERPresenter>*presenter in [self privatePresentersArray] ){
        if([presenter isResponsibleForView:view withController:self onEvent:event]){
            [presenter viewEvent:event withView:view andController:self];
        }
    }
}

#pragma mark routing events

-(void)routingEvent:(NSObject<IVISPERRoutingEvent>*)event
      withWireframe:(NSObject<IVISPERWireframe>*)wireframe{
    for(NSObject<IVISPERPresenter>*presenter in [self privatePresentersArray] ){
        if([presenter isResponsibleForController:self onEvent:event]){
            [presenter routingEvent:event
                         controller:self
                       andWireframe:wireframe];
        }
    }
    
    if([event.name isEqualToString:@"willPushController"]){
        [self willPushViewControllerOnWireframe:event.sender
                       routePattern:[event.info objectForKey:@"routePattern"]
                           priority:[[event.info objectForKey:@"priority"] longValue]
                            options:(NSObject<IVISPERRoutingOption>*)[event.info objectForKey:@"options"]
                         parameters:(NSDictionary*)[event.info objectForKey:@"parameters"]
         ];
    }else if([event.name isEqualToString:@"didPushController"]){
        [self didPushViewControllerOnWireframe:event.sender
                                   routePattern:[event.info objectForKey:@"routePattern"]
                                       priority:[[event.info objectForKey:@"priority"] longValue]
                                        options:(NSObject<IVISPERRoutingOption>*)[event.info objectForKey:@"options"]
                                     parameters:(NSDictionary*)[event.info objectForKey:@"parameters"]
         ];
    }else if([event.name isEqualToString:@"willPresentController"]){
        [self willPresentViewControllerOnWireframe:event.sender
                                  routePattern:[event.info objectForKey:@"routePattern"]
                                      priority:[[event.info objectForKey:@"priority"] longValue]
                                       options:(NSObject<IVISPERRoutingOption>*)[event.info objectForKey:@"options"]
                                    parameters:(NSDictionary*)[event.info objectForKey:@"parameters"]
         ];
    }else if([event.name isEqualToString:@"didPresentController"]){
        [self didPresentViewControllerOnWireframe:event.sender
                                      routePattern:[event.info objectForKey:@"routePattern"]
                                          priority:[[event.info objectForKey:@"priority"] longValue]
                                           options:(NSObject<IVISPERRoutingOption>*)[event.info objectForKey:@"options"]
                                        parameters:(NSDictionary*)[event.info objectForKey:@"parameters"]
         ];
    }
}

-(void)willPushViewControllerOnWireframe:(NSObject<IVISPERWireframe>*)wireframe
                            routePattern:(NSString*)routePattern
                                priority:(NSInteger)priority
                                 options:(NSObject<IVISPERRoutingOption>*)options
                              parameters:(NSDictionary *)parameters{

}


-(void)didPushViewControllerOnWireframe:(NSObject<IVISPERWireframe>*)wireframe
                           routePattern:(NSString*)routePattern
                               priority:(NSInteger)priority
                                options:(NSObject<IVISPERRoutingOption>*)options
                                parameters:(NSDictionary *)parameters{
    
}

-(void)willPresentViewControllerOnWireframe:(NSObject<IVISPERWireframe>*)wireframe
                               routePattern:(NSString*)routePattern
                                   priority:(NSInteger)priority
                                    options:(NSObject<IVISPERRoutingOption>*)options
                                 parameters:(NSDictionary *)parameters{
    
}

-(void)didPresentViewControllerOnWireframe:(NSObject<IVISPERWireframe>*)wireframe
                               routePattern:(NSString*)routePattern
                                   priority:(NSInteger)priority
                                    options:(NSObject<IVISPERRoutingOption>*)options
                                 parameters:(NSDictionary *)parameters{
    
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
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleReplaceSelector:@selector(loadView) with:@selector(visper_loadView)];
        [self swizzleReplaceSelector:@selector(viewDidLoad) with:@selector(visper_viewDidLoad)];
        [self swizzleReplaceSelector:@selector(viewWillAppear:) with:@selector(visper_viewWillAppear:)];
        [self swizzleReplaceSelector:@selector(viewDidAppear:) with:@selector(visper_viewDidAppear:)];
        [self swizzleReplaceSelector:@selector(viewWillDisappear:) with:@selector(visper_viewWillDisappear:)];
        [self swizzleReplaceSelector:@selector(viewDidDisappear:) with:@selector(visper_viewDidDisappear:)];
        [self swizzleReplaceSelector:@selector(viewWillTransitionToSize:withTransitionCoordinator:) with:@selector(visper_viewWillTransitionToSize:withTransitionCoordinator:)];
        [self swizzleReplaceSelector:@selector(didReceiveMemoryWarning) with:@selector(visper_didReceiveMemoryWarning)];
        
        areVISPEREventsOnAllViewControllersEnabledVar = TRUE;
    });
}

+ (BOOL)areVISPEREventsOnAllViewControllersEnabled{
    return areVISPEREventsOnAllViewControllersEnabledVar;
}

-(void)visper_loadView{
    [self visper_loadView];
    
    NSObject<IVISPERViewEvent> *event = [self.visperServiceProvider createEventWithName:NSStringFromSelector(_cmd)
                                                                           sender:self
                                                                             info:nil];
    [self notifyPresentersOfView:self.view withEvent:event];
}


- (void)visper_viewDidLoad {
    [self visper_viewDidLoad];
    NSObject<IVISPERViewEvent> *event = [self.visperServiceProvider createEventWithName:NSStringFromSelector(_cmd)
                                                                           sender:self
                                                                             info:nil];
    [self notifyPresentersOfView:self.view withEvent:event];
}


- (void)visper_viewWillAppear:(BOOL)animated {
    [self visper_viewWillAppear:animated];
    
    NSObject<IVISPERViewEvent> *event = [self.visperServiceProvider createEventWithName:NSStringFromSelector(_cmd)
                                                                                 sender:self
                                                                                   info:@{@"animated":(animated)?@TRUE:@FALSE}];
    [self notifyPresentersOfView:self.view withEvent:event];
}


-(void)visper_viewDidAppear:(BOOL)animated{
    [self visper_viewDidAppear:animated];
    NSObject<IVISPERViewEvent> *event = [self.visperServiceProvider createEventWithName:NSStringFromSelector(_cmd)
                                                                                 sender:self
                                                                                   info:@{@"animated":(animated)?@TRUE:@FALSE}];
    
    [self notifyPresentersOfView:self.view withEvent:event];
}


-(void)visper_viewWillDisappear:(BOOL)animated{
    [self visper_viewWillDisappear:animated];
    
    NSObject<IVISPERViewEvent> *event = [self.visperServiceProvider createEventWithName:NSStringFromSelector(_cmd)
                                                                                 sender:self
                                                                                   info:@{@"animated":(animated)?@TRUE:@FALSE}];
    [self notifyPresentersOfView:self.view withEvent:event];
}


-(void)visper_viewDidDisappear:(BOOL)animated{
    [self visper_viewDidDisappear:animated];
    
    NSObject<IVISPERViewEvent> *event = [self.visperServiceProvider createEventWithName:NSStringFromSelector(_cmd)
                                                                                 sender:self
                                                                                   info:@{@"animated":(animated)?@TRUE:@FALSE}];
    [self notifyPresentersOfView:self.view withEvent:event];
    
}

-(void)visper_viewWillTransitionToSize:(CGSize)size
      withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [self visper_viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    NSObject<IVISPERViewEvent> *event = [self.visperServiceProvider createEventWithName:NSStringFromSelector(_cmd)
                                                                                 sender:self
                                                                                   info:@{
                                                                                        @"width"       :[NSNumber numberWithFloat:size.width],
                                                                                        @"height"      :[NSNumber numberWithFloat:size.height],
                                                                                        @"coordinator" : coordinator
                                                                                    }];
    [self notifyPresentersOfView:self.view withEvent:event];
    
}

- (void)visper_didReceiveMemoryWarning {
    [self visper_didReceiveMemoryWarning];
    NSObject<IVISPERViewEvent> *event = [self.visperServiceProvider createEventWithName:NSStringFromSelector(_cmd)
                                                                                 sender:self
                                                                                   info:nil
                                             ];
    [self notifyPresentersOfView:self.view withEvent:event];
    
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
