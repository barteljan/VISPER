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
#import "IVISPERWireframe.h"
#import "IVISPERComposedInteractor.h"

@protocol IVISPERApplication <NSObject>

//the root view controller to add to your view hierarchie
-(UIViewController*)rootViewController;

//the wireframe of this application
-(NSObject<IVISPERWireframe>*)wireframe;

//the composed interactor of this application
-(NSObject<IVISPERComposedInteractor>*)interactor;

//add a feature
-(void)addFeature:(NSObject<IVISPERFeature>*)feature;
-(void)addRoutingPresenter:(NSObject<IVISPERRoutingPresenter>*)routingPresenter withPriority:(NSInteger)priority;

- (BOOL)routeURL:(NSURL *)URL withParameters:(NSDictionary *)parameters options:(NSObject<IVISPERRoutingOption>*)options;
- (BOOL)canRouteURL:(NSURL *)URL withParameters:(NSDictionary *)parameters;
-(UIViewController*)controllerForURL:(NSURL*)URL withParameters:(NSDictionary *)parameters;


@end
