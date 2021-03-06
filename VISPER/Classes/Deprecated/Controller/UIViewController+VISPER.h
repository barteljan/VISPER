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
@property (nonatomic,strong) NSObject<IVISPERRoutingOption> *routingOptions;
@property (nonatomic,strong) NSObject<IVISPERWireframe> *wireframe;


#pragma mark presenter management
@property (readonly,nonatomic, strong) NSArray *visperPresenters;

-(void)add:(NSObject<IVISPERPresenter> *)presenter;

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

-(void)willDismissViewController;
-(void)didDismissViewController;

-(void)dismissThisViewControllerAnimated:(BOOL)animated completion:(void (^)(void))completion;

@end
