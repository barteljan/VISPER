//
//  VISPERViewPresenter.m
//  VISPER
//
//  Created by Bartel on 10.07.15.
//  Copyright (c) 2015 Jan Bartel. All rights reserved.
//

#import "VISPERViewPresenter.h"
#import "UIViewController+VISPER.h"

@implementation VISPERViewPresenter
@synthesize wireframe=_wireframe;

-(instancetype)initWithWireframe:(NSObject<IVISPERWireframe>*)wireframe{
    self = [super init];
    if(self){
        self.wireframe = wireframe;
    }
    return self;
}


-(void)viewEvent:(NSObject<IVISPERViewEvent>*)event
        withView:(UIView*)view
   andController:(UIViewController*)viewController{
    
    
}

-(BOOL)isResponsibleForView:(UIView*)view
             withController:(UIViewController*)controller
                    onEvent:(NSObject<IVISPERViewEvent> *)event{

    return TRUE;
}

-(BOOL)isResponsibleForController:(UIViewController*)viewController
                          onEvent:(NSObject<IVISPERRoutingEvent> *)event{
    return TRUE;
}

-(void)routingEvent:(NSObject<IVISPERRoutingEvent>*)event
         controller:(UIViewController*)viewController
       andWireframe:(NSObject<IVISPERWireframe>*)wireframe{
}

- (void)setWireframe:(NSObject<IVISPERWireframe> *)wireframe {
    self->_wireframe = wireframe;
}


- (NSObject<IVISPERWireframe> *)wireframe {
    return self->_wireframe;
}


- (BOOL)isResponsible:(NSObject *)event view:(UIView *)view controller:(UIViewController *)controller {
    
    if([event conformsToProtocol:@protocol(IVISPERRoutingEvent)]){
        return [self isResponsibleForController:controller onEvent:(NSObject<IVISPERRoutingEvent>*)event];
    }
    if([event conformsToProtocol:@protocol(IVISPERViewEvent)]){
        return [self isResponsibleForView:view withController:controller onEvent:(NSObject<IVISPERViewEvent> *)event];
    }
    return FALSE;
}

- (void)receivedEvent:(NSObject *)event view:(UIView *)view controller:(UIViewController *)controller {
    
    if([event conformsToProtocol:@protocol(IVISPERViewEvent)]){
        [self viewEvent:(NSObject<IVISPERViewEvent> *)event withView:view andController:controller];
    }
    
    if([event conformsToProtocol:@protocol(IVISPERRoutingEvent)]){
        [self routingEvent:(NSObject<IVISPERRoutingEvent> *)event controller:controller andWireframe:controller.wireframe];
    }
    
}

@end
