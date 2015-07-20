//
//  Example3VisperViewControllerPresenter.m
//  VISPER
//
//  Created by Bartel on 12.07.15.
//  Copyright (c) 2015 Jan Bartel. All rights reserved.
//

#import "Example3VisperViewControllerPresenter.h"

@implementation Example3VisperViewControllerPresenter

-(void)viewEvent:(NSObject<IVISPERViewEvent> *)event withView:(UIView *)view andController:(UIViewController *)viewController{
    [super viewEvent:event withView:view andController:viewController];
    
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
