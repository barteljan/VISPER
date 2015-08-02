//
// Created by Bartel on 18.07.15.
//
#import "VISPERWireframeServiceProvider.h"
#import "VISPERRoutingOption.h"
#import "VISPERPresentationType.h"
#import "VISPERPresentationTypePush.h"
#import "VISPERPresentationTypeModal.h"
#import "VISPERPushRoutingPresenter.h"
#import "VISPERModalRoutingPresenter.h"
#import "VISPERRootVCRoutingPresenter.h"
#import "VISPERPresentationTypeRootVC.h"
#import "VISPERWireframe.h"
#import "VISPERRoutingEvent.h"


@interface VISPERWireframeServiceProvider()
@end

@implementation VISPERWireframeServiceProvider

/**
 *
 * Provide some convienience RoutingOptions
 *
 */
-(NSObject<IVISPERRoutingOption> *)routingOption:(BOOL)animated{
    NSObject <IVISPERWireframePresentationType> *type =
            [[VISPERPresentationType alloc] initIsAnimated:animated];

    return [[VISPERRoutingOption alloc] initWithPresentationType:type];
}

-(NSObject<IVISPERRoutingOption> *)pushRoutingOption:(BOOL)animated{
    NSObject <IVISPERWireframePresentationType> *type =
            [[VISPERPresentationTypePush alloc] initIsAnimated:animated];

    return [[VISPERRoutingOption alloc] initWithPresentationType:type];
}

-(NSObject<IVISPERRoutingOption> *)modalRoutingOption:(BOOL)animated{
    NSObject <IVISPERWireframePresentationType> *type =
            [[VISPERPresentationTypeModal alloc] initIsAnimated:animated];

    return [[VISPERRoutingOption alloc] initWithPresentationType:type];
}

-(NSObject<IVISPERRoutingOption> *)presentRootVCRoutingOption:(BOOL)animated{
    NSObject <IVISPERWireframePresentationType> *type =
    [[VISPERPresentationTypeRootVC alloc] initIsAnimated:animated];
    
    return [[VISPERRoutingOption alloc] initWithPresentationType:type];

}

-(NSObject<IVISPERWireframe>*)emptyWireframeFromWireframe:(NSObject<IVISPERWireframe>*)existingWireframe{
    NSObject<IVISPERWireframe>*wireframe = [[VISPERWireframe alloc] initWithRoutes:[[JLRoutes alloc] init]
                                                                    serviceProvider:self];
    return wireframe;
}

-(NSObject<IVISPERRoutingEvent>*)createEventWithName:(NSString*)name
                                              sender:(id)sender
                                                info:(NSDictionary*)info{
    return [[VISPERRoutingEvent alloc] initWithName:name
                                             sender:sender
                                               info:info];
}

@end