//
//  Example3VisperViewControllerPresenter.m
//  VISPER
//
//  Created by Bartel on 12.07.15.
//  Copyright (c) 2015 Jan Bartel. All rights reserved.
//

#import "Example3VisperViewControllerPresenter.h"

@implementation Example3VisperViewControllerPresenter

-(void)renderView:(UIView*)view
   withController:(UIViewController*)viewController
          onEvent:(NSObject<IVISPERViewEvent>*)event{
    
    [super renderView:view withController:viewController onEvent:event];
    
    if([event.name isEqualToString:@"shouldCloseViewController"]){
        [self closeViewController:viewController];
    }
}

-(void)closeViewController:(UIViewController *)viewController{
    [viewController dismissViewControllerAnimated:YES completion:^{
        ;
    }];
}
@end
