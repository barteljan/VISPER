//
//  IVISPERApplication.h
//  Pods
//
//  Created by Bartel on 20.08.15.
//
//

#import <Foundation/Foundation.h>
#import "IVISPERFeature.h"
#import "IVISPERRoutingPresenter.h"

@protocol IVISPERApplication <NSObject>

//the root view controller to add to your view hierarchie
-(UIViewController*)rootViewController;

//add a feature
-(void)addFeature:(NSObject<IVISPERFeature>*)feature;
-(void)addRoutingPresenter:(NSObject<IVISPERRoutingPresenter>*)routingPresenter withPriority:(NSInteger)priority;

- (BOOL)routeURL:(NSURL *)URL withParameters:(NSDictionary *)parameters options:(NSObject<IVISPERRoutingOption>*)options;
- (BOOL)canRouteURL:(NSURL *)URL withParameters:(NSDictionary *)parameters;
-(UIViewController*)controllerForURL:(NSURL*)URL withParameters:(NSDictionary *)parameters;


@end
