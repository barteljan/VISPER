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


@interface VISPERWireframeServiceProvider()

@property (nonatomic) NSMutableArray *privateRoutingPresenters;

@end

@implementation VISPERWireframeServiceProvider
/**
 *
 * Provide routing presenters, which are responsible for creating the real controller transition,
 * depending on some routing options (IVISPERRoutingOption)
 *
 */

-(NSMutableArray*)privateRoutingPresenters{
    if(!self->_privateRoutingPresenters){
        self->_privateRoutingPresenters = [NSMutableArray array];
        [self addRoutingPresenter:[[VISPERPushRoutingPresenter alloc] init]];
        [self addRoutingPresenter:[[VISPERModalRoutingPresenter alloc] init]];
    }
    return self->_privateRoutingPresenters;
}

/**
 * add Routing presenter, responsible for routing controllers with specific RoutingOptions
 **/
-(void)addRoutingPresenter:(NSObject<IVISPERRoutingPresenter>*)presenter{
    [self.privateRoutingPresenters insertObject:presenter atIndex:0];
}

/**
 * remove Routing presenter, responsible for routing controllers with specific RoutingOptions
 **/
-(NSArray*)removeRoutingPresentersResponsibleForRoutingOptions:(NSObject<IVISPERRoutingOption>*)routingOption{
    
    NSMutableArray *presenters = [NSMutableArray array];
    for(NSObject<IVISPERRoutingPresenter> *presenter in self.privateRoutingPresenters){
        if([presenter isResponsibleForRoutingOption:routingOption]){
            [presenters addObject:presenter];
        }
    }
   
    for(NSObject<IVISPERRoutingPresenter> *presenter in presenters){
        [self.privateRoutingPresenters removeObject:presenter];
    }
    
    return [NSArray arrayWithArray:presenters];
}

/**
 * get all registered routing presenters
 **/
-(NSArray*)routingPresenters{
    return [NSArray arrayWithArray:self.privateRoutingPresenters];
}

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

@end