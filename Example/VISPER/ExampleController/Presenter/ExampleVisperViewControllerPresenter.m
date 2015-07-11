//
//  ExampleVisperViewControllerPresenter.m
//  VISPER
//
//  Created by Bartel on 11.07.15.
//  Copyright (c) 2015 Jan Bartel. All rights reserved.
//

#import "ExampleVisperViewControllerPresenter.h"

@implementation ExampleVisperViewControllerPresenter

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
    NSLog(@"Next Button Pressed");
}

@end
