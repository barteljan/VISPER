//
//  Example1VisperViewControllerPresenter.m
//  VISPER
//
//  Created by Bartel on 11.07.15.
//  Copyright (c) 2015 Jan Bartel. All rights reserved.
//

#import "Example1VisperViewControllerPresenter.h"
#import <VISPER/IVISPERViewEvent.h>

@implementation Example1VisperViewControllerPresenter

-(void)renderView:(UIView*)view
   withController:(UIViewController*)viewController
          onEvent:(NSObject<IVISPERViewEvent>*)event{
    
    [super renderView:view withController:viewController onEvent:event];
    
    if([event.name isEqualToString:@"nextButtonPressed"]){
        [self nextButtonPressed:event.sender
                           view:view
                 viewController:viewController];
    }
}


-(void)nextButtonPressed:(id)sender
                    view:(UIView*)view
          viewController:(UIViewController*)viewController{
    [self.wireframe routeURL:[NSURL URLWithString:@"/example2"]];
}

@end
