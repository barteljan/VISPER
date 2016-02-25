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
@protocol CommandHandlerProtocol;

@protocol IVISPERApplication <NSObject>

#pragma mark properties
//the root view controller to add to your view hierarchie
-(UIViewController*)rootViewController;

//the wireframe of this application
-(NSObject<IVISPERWireframe>*)wireframe;

//the command bus of this application
-(CommandBus*)commandBus;


#pragma mark root navigation controller of this application
-(UINavigationController*)navigationController;
-(void)setNavigationController:(UINavigationController*)navigationController;

#pragma mark features
-(void)addFeature:(NSObject<IVISPERFeature>*)feature;

#pragma mark command handlers
-(void)addCommandHandler:(id<CommandHandlerProtocol>*)handler;

#pragma mark routing presenters
-(void)addRoutingPresenter:(NSObject<IVISPERRoutingPresenter>*)routingPresenter withPriority:(NSInteger)priority;

#pragma mark routing
- (BOOL)routeURL:(NSURL *)URL withParameters:(NSDictionary *)parameters options:(NSObject<IVISPERRoutingOption>*)options;
- (BOOL)canRouteURL:(NSURL *)URL withParameters:(NSDictionary *)parameters;
- (UIViewController*)controllerForURL:(NSURL*)URL withParameters:(NSDictionary *)parameters;


@end
