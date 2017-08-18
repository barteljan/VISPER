//
//  VISPER.h
//  Pods
//
//  Created by Bartel on 21.08.15.
//
//

#import <Foundation/Foundation.h>
#import "IVISPERRoutingOption.h"
#import "IVISPERRoutingOptionsFactory.h"

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
