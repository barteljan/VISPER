//
//  IVISPERRoutingPresenter.h
//  Pods
//
//  Created by Bartel on 18.07.15.
//
//

@import UIKit;
#import <Foundation/Foundation.h>
#import "IVISPERRoutingOption.h"
#import "IVISPERWireframeViewControllerServiceProvider.h"

@protocol IVISPERWireframe;

@protocol IVISPERRoutingPresenter <NSObject>

-(void)setControllerServiceProviders:(NSArray*)controllerServiceProviders;

-(BOOL)isResponsibleForRoutingOption:(NSObject<IVISPERRoutingOption>*)routingOption;

- (void)addRoute:(NSString *)routePattern
        priority:(NSUInteger)priority
  withController:(UIViewController*)controller
         options:(NSObject<IVISPERRoutingOption>*)options
     onWireframe:(NSObject<IVISPERWireframe>*)wireframe;


@end
