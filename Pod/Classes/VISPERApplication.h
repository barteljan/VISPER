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

#pragma mark initializer
-(instancetype)initWithNavigationController:(UINavigationController*)controller;
-(instancetype)initWithNavigationController:(UINavigationController*)controller
                                  wireframe:(NSObject<IVISPERWireframe>*)wireframe;
-(instancetype)initWithNavigationController:(UINavigationController*)controller
                                  wireframe:(NSObject<IVISPERWireframe>*)wireframe
                                 commandBus:(NSObject<IVISPERCommandBus>*)commandBus;


#pragma mark deprecated
-(instancetype)initWithNavigationController:(UINavigationController*)controller
                                  wireframe:(NSObject<IVISPERWireframe>*)wireframe
                                 interactor:(NSObject<IVISPERComposedInteractor>*)interactor __attribute((deprecated(("use initWithNavigationController:wireframe:commandBus: instead"))));
@end
