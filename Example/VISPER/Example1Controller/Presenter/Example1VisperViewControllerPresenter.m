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

-(void)viewEvent:(NSObject<IVISPERViewEvent> *)event
        withView:(UIView *)view
   andController:(UIViewController *)viewController{
    [super viewEvent:event
            withView:view
       andController:viewController];
    
    
    if([event.name isEqualToString:@"example2ButtonPressed"]){
        [self example2ButtonPressed:event.sender
                               view:view
                     viewController:viewController];
    }else if([event.name isEqualToString:@"example3ButtonPressed"]){
        [self example3ButtonPressed:event.sender
                               view:view
                     viewController:viewController];
    }
}


-(void)example2ButtonPressed:(id)sender
                        view:(UIView *)view
              viewController:(UIViewController*)viewController{
    [self.wireframe routeURL:[NSURL URLWithString:@"/example2"]];
}


-(void)example3ButtonPressed:(id)sender
                        view:(UIView *)view
              viewController:(UIViewController*)viewController{
    [self.wireframe routeURL:[NSURL URLWithString:@"/example3"]];
}

@end
