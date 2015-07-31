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


#pragma mark presenter management
@property (readonly,nonatomic, strong) NSArray *visperPresenters;

-(void)addVisperPresenter:(NSObject<IVISPERPresenter> *)presenter;
-(void)removeVisperPresenter:(NSObject<IVISPERPresenter> *)presenter;
-(void)notifyPresentersOfView:(UIView*)view
                    withEvent:(NSObject<IVISPERViewEvent>*)event;

-(void)routingEvent:(NSObject<IVISPERRoutingEvent>*)event
      withWireframe:(NSObject<IVISPERWireframe>*)wireframe;

-(void)willPushViewControllerOnWireframe:(NSObject<IVISPERWireframe>*)wireframe
                            routePattern:(NSString*)routePattern
                                priority:(NSInteger)priority
                                 options:(NSObject<IVISPERRoutingOption>*)options
                              parameters:(NSDictionary *)parameters;

-(void)didPushViewControllerOnWireframe:(NSObject<IVISPERWireframe>*)wireframe
                           routePattern:(NSString*)routePattern
                               priority:(NSInteger)priority
                                options:(NSObject<IVISPERRoutingOption>*)options
                             parameters:(NSDictionary *)parameters;

-(void)willPresentViewControllerOnWireframe:(NSObject<IVISPERWireframe>*)wireframe
                               routePattern:(NSString*)routePattern
                                   priority:(NSInteger)priority
                                    options:(NSObject<IVISPERRoutingOption>*)options
                                 parameters:(NSDictionary *)parameters;

-(void)didPresentViewControllerOnWireframe:(NSObject<IVISPERWireframe>*)wireframe
                              routePattern:(NSString*)routePattern
                                  priority:(NSInteger)priority
                                   options:(NSObject<IVISPERRoutingOption>*)options
                                parameters:(NSDictionary *)parameters;

-(void)willDismissViewController;
-(void)didDismissViewController;

-(void)dismissThisViewControllerAnimated:(BOOL)animated completion:(void (^)(void))completion;

@end
