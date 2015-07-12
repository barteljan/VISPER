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

@protocol IVISPERPresenter <NSObject>

-(NSObject<IVISPERWireframe>*)wireframe;
-(void)setWireframe:(NSObject<IVISPERWireframe>*)wireframe;

-(void)renderView:(UIView*)view
   withController:(UIViewController*)viewController
          onEvent:(NSObject<IVISPERViewEvent>*)event;

@end
