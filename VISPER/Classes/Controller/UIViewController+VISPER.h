//
//  UIViewController+VISPER.h
//  Pods
//
//  Created by Bartel on 18.07.15.
//
//

#import <UIKit/UIKit.h>
#import "IVISPERPresenter.h"
#import "IVISPERViewControllerServiceProvider.h"
#import "IVISPERRoutingEvent.h"
#import "IVISPERWireframe.h"

@interface UIViewController (VISPER)

+ (BOOL)areVISPEREventsOnAllViewControllersEnabled;
+ (void)enableVISPEREventsOnAllViewControllers;

@property (nonatomic,strong) IBOutlet NSObject<IVISPERViewControllerServiceProvider> *visperServiceProvider;

@property (nonatomic,strong) NSString *routePattern;
@property (nonatomic,strong) NSDictionary *routeParameters;
@property (nonatomic,strong) NSObject<IVISPERRoutingOption> *routingOptions;
@property (nonatomic,strong) NSObject<IVISPERWireframe> *wireframe;


#pragma mark presenter management
@property (readonly,nonatomic, strong) NSArray *visperPresenters;

-(void)addVisperPresenter:(NSObject<IVISPERPresenter> *)presenter;
-(void)removeVisperPresenter:(NSObject<IVISPERPresenter> *)presenter;
-(void)notifyPresentersOfView:(UIView*)view
                    withEvent:(NSObject<IVISPERViewEvent>*)event;

-(void)routingEvent:(NSObject<IVISPERRoutingEvent>*)event
      withWireframe:(NSObject<IVISPERWireframe>*)wireframe;

-(void)willRouteToViewControllerOnWireframe:(NSObject<IVISPERWireframe>*)wireframe
                               routePattern:(NSString*)routePattern
                                    options:(NSObject<IVISPERRoutingOption>*)options
                                 parameters:(NSDictionary *)parameters;

-(void)didRouteToViewControllerOnWireframe:(NSObject<IVISPERWireframe>*)wireframe
                              routePattern:(NSString*)routePattern
                                   options:(NSObject<IVISPERRoutingOption>*)options
                                parameters:(NSDictionary *)parameters;

-(void)willPushViewControllerOnWireframe:(NSObject<IVISPERWireframe>*)wireframe
                            routePattern:(NSString*)routePattern
                                 options:(NSObject<IVISPERRoutingOption>*)options
                              parameters:(NSDictionary *)parameters;

-(void)didPushViewControllerOnWireframe:(NSObject<IVISPERWireframe>*)wireframe
                           routePattern:(NSString*)routePattern
                                options:(NSObject<IVISPERRoutingOption>*)options
                             parameters:(NSDictionary *)parameters;

-(void)willPresentViewControllerOnWireframe:(NSObject<IVISPERWireframe>*)wireframe
                               routePattern:(NSString*)routePattern
                                    options:(NSObject<IVISPERRoutingOption>*)options
                                 parameters:(NSDictionary *)parameters;

-(void)didPresentViewControllerOnWireframe:(NSObject<IVISPERWireframe>*)wireframe
                              routePattern:(NSString*)routePattern
                                   options:(NSObject<IVISPERRoutingOption>*)options
                                parameters:(NSDictionary *)parameters;

-(void)willPresentRootViewControllerOnWireframe:(NSObject<IVISPERWireframe>*)wireframe
                                   routePattern:(NSString*)routePattern
                                        options:(NSObject<IVISPERRoutingOption>*)options
                                     parameters:(NSDictionary *)parameters;

-(void)didPresentRootViewControllerOnWireframe:(NSObject<IVISPERWireframe>*)wireframe
                                  routePattern:(NSString*)routePattern
                                       options:(NSObject<IVISPERRoutingOption>*)options
                                    parameters:(NSDictionary *)parameters;

-(void)willDismissViewController;
-(void)didDismissViewController;

-(void)dismissThisViewControllerAnimated:(BOOL)animated completion:(void (^)(void))completion;

@end
