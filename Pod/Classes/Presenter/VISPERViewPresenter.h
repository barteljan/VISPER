//
//  VISPERViewPresenter.h
//  VISPER
//
//  Created by Bartel on 10.07.15.
//  Copyright (c) 2015 Jan Bartel. All rights reserved.
//

@import Foundation;
@import UIKit;

#import "IVISPERPresenter.h"
#import "IVISPERViewEvent.h"

@interface VISPERViewPresenter : NSObject<IVISPERPresenter>

-(void)renderView:(UIView*)view
   withController:(UIViewController*)viewController
          onEvent:(NSObject<IVISPERViewEvent>*)event;

-(BOOL)isAllowedToRenderView:(UIView*)view
                 onViewEvent:(NSObject<IVISPERViewEvent>*)event;

-(BOOL)isAllowedToRenderViewController:(UIViewController*)viewController
                           onViewEvent:(NSObject<IVISPERViewEvent>*)event;

@end
