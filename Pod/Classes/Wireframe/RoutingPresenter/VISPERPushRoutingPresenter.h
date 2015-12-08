//
//  VISPERPushRoutingPresenter.h
//  Pods
//
//  Created by Bartel on 18.07.15.
//
//

#import <Foundation/Foundation.h>
#import "VISPERNavigationControllerBasedRoutingPresenter.h"

@interface VISPERPushRoutingPresenter : VISPERNavigationControllerBasedRoutingPresenter

@property NSString *lastRoutePattern;
@property NSDictionary *lastParameters;


@end
