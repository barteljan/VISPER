//
//  VISPERApplication.h
//  Pods
//
//  Created by Bartel on 20.08.15.
//
//

#import <Foundation/Foundation.h>
@import UIKit;
#import "IVISPERApplication.h"
#import "IVISPERWireframe.h"
#import "IVISPERComposedInteractor.h"

@interface VISPERApplication : NSObject<IVISPERApplication>

-(instancetype)initWithNavigationController:(UINavigationController*)controller;
-(instancetype)initWithNavigationController:(UINavigationController*)controller
                                  wireframe:(NSObject<IVISPERWireframe>*)wireframe;
-(instancetype)initWithNavigationController:(UINavigationController*)controller
                                  wireframe:(NSObject<IVISPERWireframe>*)wireframe
                                 interactor:(NSObject<IVISPERComposedInteractor>*)interactor;
@end
