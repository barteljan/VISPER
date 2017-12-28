//
//  VISPER.h
//  Pods
//
//  Created by Bartel on 21.08.15.
//
//

#import <Foundation/Foundation.h>
#import "VISPERCommandHandler.h"
#import "IVISPERViewController.h"
#import "IVISPERViewControllerServiceProvider.h"
#import "VISPERViewControllerServiceProvider.h"
#import "UIViewController+VISPER.h"
#import "VISPERViewController.h"
#import "IVISPEREvent.h"
#import "IVISPERViewEvent.h"
#import "VISPERViewEvent.h"
#import "VISPEREvent.h"
#import "IVISPERRoutingEvent.h"
#import "VISPERRoutingEvent.h"
#import "IVISPERApplication.h"
#import "IVISPERFeature.h"
#import "IVISPERPresenter.h"
#import "IVISPERViewControllerPresenter.h"
#import "VISPERViewControllerPresenter.h"
#import "VISPERViewPresenter.h"
#import "IVISPERServiceProvider.h"
#import "VISPERServiceProvider.h"
#import "VISPERFeature.h"
#import "IVISPERWireframe.h"
#import "IVISPERRoutingOption.h"
#import "IVISPERRoutingOptionsFactory.h"
#import "IVISPERWireframePresentationType.h"
#import "IVISPERWireframePresentationTypeBackToRoute.h"
#import "IVISPERWireframePresentationTypeDoNotPresentVC.h"
#import "IVISPERWireframePresentationTypeModal.h"
#import "IVISPERWireframePresentationTypePush.h"
#import "IVISPERWireframePresentationTypeReplaceTopVC.h"
#import "IVISPERWireframePresentationTypeRootVC.h"
#import "IVISPERWireframePresentationTypeShow.h"
#import "VISPERPresentationType.h"
#import "VISPERPresentationTypeBackToRoute.h"
#import "VISPERPresentationTypeModal.h"
#import "VISPERPresentationTypePush.h"
#import "VISPERPresentationTypeReplaceTopVC.h"
#import "VISPERPresentationTypeRootVC.h"
#import "VISPERPresentationTypeShow.h"
#import "VISPERPresententationTypeDoNotPresentVC.h"
#import "VISPERRoutingOption.h"
#import "VISPERRoutingOptionsFactory.h"
#import "IVISPERRoutingObserver.h"
#import "IVISPERRoutingPresenter.h"
#import "IVISPERRoutingPresenterServiceProvider.h"
#import "VISPERRoutingPresenterServiceProvider.h"
#import "VISPERDoNotPresentRoutingPresenter.h"
#import "VISPERNavigationControllerBasedRoutingPresenter.h"
#import "VISPERRoutingPresenter.h"
#import "IVISPERControllerProvider.h"
#import "IVISPERRoutingOptionsProvider.h"
#import "IVISPERWireframeRoutingOptionsServiceProvider.h"
#import "IVISPERWireframeServiceProvider.h"
#import "IVISPERWireframeViewControllerServiceProvider.h"

@interface VISPER : NSObject

+ (NSObject<IVISPERRoutingOptionsFactory>*)sharedRoutingOptionsFactory;
+ (void)setSharedRoutingOptionsFactory:(NSObject<IVISPERRoutingOptionsFactory>*)factory;

+(NSObject<IVISPERRoutingOption> *)routingOption;
+(NSObject<IVISPERRoutingOption> *)routingOption:(BOOL)animated;

+(NSObject<IVISPERRoutingOption> *)routingOptionPush;
+(NSObject<IVISPERRoutingOption> *)routingOptionPush:(BOOL)animated;

+(NSObject<IVISPERRoutingOption> *)routingOptionModal;
+(NSObject<IVISPERRoutingOption> *)routingOptionModal:(BOOL)animated;

+(NSObject<IVISPERRoutingOption> *)routingOptionPopover;
+(NSObject<IVISPERRoutingOption> *)routingOptionPopover:(BOOL)animated;

+(NSObject<IVISPERRoutingOption> *)backToRoute;
+(NSObject<IVISPERRoutingOption> *)backToRoute:(BOOL)animated;

+(NSObject<IVISPERRoutingOption> *)routingOptionPresentRootVC;
+(NSObject<IVISPERRoutingOption> *)routingOptionPresentRootVC:(BOOL)animated;

+(NSObject<IVISPERRoutingOption> *)routingOptionReplaceTopVC;
+(NSObject<IVISPERRoutingOption> *)routingOptionReplaceTopVC:(BOOL)animated;

+(NSObject<IVISPERRoutingOption> *)routingOptionDoNotPresentVC:( void(^)(NSString *routePattern,
                                                                         UIViewController *controller,
                                                                         NSObject<IVISPERRoutingOption>*options,
                                                                         NSDictionary *parameters,
                                                                         NSObject<IVISPERWireframe>*wireframe))completion;

+(NSObject<IVISPERRoutingOption> *)routingOptionShow;
+(NSObject<IVISPERRoutingOption> *)routingOptionShow:(BOOL)animated;



@end
