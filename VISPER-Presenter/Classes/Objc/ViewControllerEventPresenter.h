//
//  ViewControllerEventPresenter.h
//
//  Created by bartel on 15.12.17.
//

#import <Foundation/Foundation.h>
@import UIKit;

@protocol ViewControllerEventPresenter <NSObject>

-(BOOL)isResponsible:(NSObject*)event view:(UIView*)view controller:(UIViewController*)controller;
-(void)receivedEvent:(NSObject*)event view:(UIView*)view controller:(UIViewController*)controller;

@end
