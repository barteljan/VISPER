//
//  IVISPERPresenter.h
//  VISPER
//
//  Created by Bartel on 10.07.15.
//  Copyright (c) 2015 Jan Bartel. All rights reserved.
//

@import Foundation;
@import UIKit;
#import "IVISPERViewEvent.h"
#import "IVISPERWireframe.h"
#import "IVISPERRoutingEvent.h"
@import VISPER_Presenter;

@protocol IVISPERPresenter <ViewControllerEventPresenter>

-(NSObject<IVISPERWireframe>*)wireframe;
-(void)setWireframe:(NSObject<IVISPERWireframe>*)wireframe;

-(BOOL)isResponsibleForView:(UIView*)view
             withController:(UIViewController*)controller
                    onEvent:(NSObject<IVISPERViewEvent> *)event;

-(void)viewEvent:(NSObject<IVISPERViewEvent>*)event
        withView:(UIView*)view
   andController:(UIViewController*)viewController;

-(BOOL)isResponsibleForController:(UIViewController*)viewController
                          onEvent:(NSObject<IVISPERRoutingEvent> *)event;

-(void)routingEvent:(NSObject<IVISPERRoutingEvent>*)event
         controller:(UIViewController*)viewController
       andWireframe:(NSObject<IVISPERWireframe>*)wireframe;


@end
