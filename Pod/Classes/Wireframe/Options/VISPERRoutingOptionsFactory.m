//
//  VISPERRoutingOptionsFactory.m
//  Pods
//
//  Created by Bartel on 21.08.15.
//
//

#import "VISPERRoutingOptionsFactory.h"
#import "VISPERRoutingOption.h"
#import "VISPERPresentationType.h"
#import "VISPERPresentationTypePush.h"
#import "VISPERPresentationTypeModal.h"
#import "VISPERPresentationTypeRootVC.h"
#import "VISPERPresententationTypeDoNotPresentVC.h"
#import "VISPERPresentationTypeReplaceTopVC.h"

@implementation VISPERRoutingOptionsFactory

/**
 *
 * Provide some convienience RoutingOptions
 *
 */
-(NSObject<IVISPERRoutingOption> *)routingOption{
    return [self routingOption:YES];
}

-(NSObject<IVISPERRoutingOption> *)routingOption:(BOOL)animated{
    NSObject <IVISPERWireframePresentationType> *type =
    [[VISPERPresentationType alloc] initIsAnimated:animated];
    
    return [[VISPERRoutingOption alloc] initWithPresentationType:type];
}

-(NSObject<IVISPERRoutingOption> *)routingOptionPush{
    return [self routingOptionPush:YES];
}

-(NSObject<IVISPERRoutingOption> *)routingOptionPush:(BOOL)animated{
    NSObject <IVISPERWireframePresentationType> *type =
    [[VISPERPresentationTypePush alloc] initIsAnimated:animated];
    
    return [[VISPERRoutingOption alloc] initWithPresentationType:type];
}


-(NSObject<IVISPERRoutingOption> *)routingOptionModal{
    return [self routingOptionModal:YES];
}

-(NSObject<IVISPERRoutingOption> *)routingOptionModal:(BOOL)animated{
    NSObject <IVISPERWireframePresentationType> *type =
    [[VISPERPresentationTypeModal alloc] initIsAnimated:animated];
    
    return [[VISPERRoutingOption alloc] initWithPresentationType:type];
}

-(NSObject<IVISPERRoutingOption> *)routingOptionPresentRootVC{
    return [self routingOptionPresentRootVC:YES];
}

-(NSObject<IVISPERRoutingOption> *)routingOptionPresentRootVC:(BOOL)animated{
    NSObject <IVISPERWireframePresentationType> *type =
    [[VISPERPresentationTypeRootVC alloc] initIsAnimated:animated];
    
    return [[VISPERRoutingOption alloc] initWithPresentationType:type];
    
}

-(NSObject<IVISPERRoutingOption> *)routingOptionDoNotPresentVC:( void(^)(NSString *routePattern,
                                                                 UIViewController *controller,
                                                                 NSObject<IVISPERRoutingOption>*options,
                                                                 NSDictionary *parameters,
                                                                 NSObject<IVISPERWireframe>*wireframe))completion{
    NSObject <IVISPERWireframePresentationType> *type =
    [[VISPERPresententationTypeDoNotPresentVC alloc] initWithCompletion:completion];
    
    return [[VISPERRoutingOption alloc] initWithPresentationType:type];
}


-(NSObject<IVISPERRoutingOption> *)routingOptionReplaceTopVC{
    return [self routingOptionReplaceTopVC:YES];
}


-(NSObject<IVISPERRoutingOption> *)routingOptionReplaceTopVC:(BOOL)animated{
    
    NSObject <IVISPERWireframePresentationType> *type =
    [[VISPERPresentationTypeReplaceTopVC alloc] initIsAnimated:animated];
    
    return [[VISPERRoutingOption alloc] initWithPresentationType:type];

}
@end
