//
//  VISPER.m
//  Pods
//
//  Created by Bartel on 21.08.15.
//
//

#import "VISPER.h"
#import "VISPERRoutingOptionsFactory.h"
#import "UIViewController+VISPER.h"
#import "VISPERPresentationTypeModal.h"
#import "VISPERRoutingOption.h"
#import "IVISPERRoutingOptionsFactory.h"
#import "IVISPERWireframePresentationType.h"

@implementation VISPER

static NSObject<IVISPERRoutingOptionsFactory> *routingOptionsFactory = nil;

+ (void)load {
    [UIViewController enableVISPEREventsOnAllViewControllers];
}

+ (id)sharedRoutingOptionsFactory {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        routingOptionsFactory = [[VISPERRoutingOptionsFactory alloc] init];
    });
    return routingOptionsFactory;
}

+ (void)setSharedRoutingOptionsFactory:(NSObject<IVISPERRoutingOptionsFactory>*)factory{
    routingOptionsFactory = factory;
}

+(NSObject<IVISPERRoutingOption> *)routingOptionPush{
    return [[VISPER sharedRoutingOptionsFactory] routingOptionPush];
}

+(NSObject<IVISPERRoutingOption> *)routingOptionPush:(BOOL)animated{
    return [[VISPER sharedRoutingOptionsFactory] routingOptionPush:animated];
}

+(NSObject<IVISPERRoutingOption> *)routingOptionModal{
    return [[VISPER sharedRoutingOptionsFactory] routingOptionModal];
}

+(NSObject<IVISPERRoutingOption> *)routingOptionModal:(BOOL)animated{
    return [[VISPER sharedRoutingOptionsFactory] routingOptionModal:animated];
}

+(NSObject<IVISPERRoutingOption> *)routingOptionPopover {
    return [VISPER routingOptionPopover:true];
}

+(NSObject<IVISPERRoutingOption> *)routingOptionPopover:(BOOL)animated {
    
    NSObject<IVISPERRoutingOption> *option = [[VISPER sharedRoutingOptionsFactory] routingOptionModal:true];
    VISPERPresentationTypeModal *modalType = (VISPERPresentationTypeModal *)option.wireframePresentationType;
    modalType.presentationStyle = UIModalPresentationOverCurrentContext;
    return option;
}

+(NSObject<IVISPERRoutingOption> *)backToRoute {
    return [VISPER backToRoute:true];
}

+(NSObject<IVISPERRoutingOption> *)backToRoute:(BOOL)animated {
    return  [[VISPER sharedRoutingOptionsFactory] backToRoute: animated];
}


+(NSObject<IVISPERRoutingOption> *)routingOptionPresentRootVC{
    return [[VISPER sharedRoutingOptionsFactory] routingOptionPresentRootVC];
}

+(NSObject<IVISPERRoutingOption> *)routingOptionPresentRootVC:(BOOL)animated{
    return [[VISPER sharedRoutingOptionsFactory] routingOptionPresentRootVC:animated];
}

+(NSObject<IVISPERRoutingOption> *)routingOptionReplaceTopVC{
    return [[VISPER sharedRoutingOptionsFactory] routingOptionReplaceTopVC];
}

+(NSObject<IVISPERRoutingOption> *)routingOptionReplaceTopVC:(BOOL)animated{
    return [[VISPER sharedRoutingOptionsFactory] routingOptionReplaceTopVC:animated];
}

+(NSObject<IVISPERRoutingOption> *)routingOptionShow{
    return [[VISPER sharedRoutingOptionsFactory] routingOptionShow];
}

+(NSObject<IVISPERRoutingOption> *)routingOptionShow:(BOOL)animated{
    return [[VISPER sharedRoutingOptionsFactory] routingOptionShow:animated];
}


@end
