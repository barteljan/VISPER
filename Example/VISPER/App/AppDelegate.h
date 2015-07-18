//
//  AppDelegate.h
//  VISPER
//
//  Created by Bartel on 10.07.15.
//  Copyright (c) 2015 Bartel. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "IVISPERWireframe.h"
#import <VISPER/IVISPERWireframeViewControllerServiceProvider.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,
                                      IVISPERWireframeViewControllerServiceProvider,
                                      IVISPERWireframeRoutingOptionsServiceProvider>

@property (strong, nonatomic) IBOutlet UIWindow *window;
@property (strong,nonatomic) IBOutlet NSObject<IVISPERWireframe> *wireframe;

@end
