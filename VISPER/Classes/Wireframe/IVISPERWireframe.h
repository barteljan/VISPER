//
//  IVISPERWireframe.h
//  Pods
//
//  Created by Bartel on 11.07.15.
//
//

@import Foundation;
@import UIKit;
#import "IVISPERRoutingPresenter.h"
#import "IVISPERRoutingOption.h"
#import "IVISPERControllerProvider.h"
#import "IVISPERRoutingOptionsProvider.h"
#import "IVISPERRoutingOptionsFactory.h"
#import "IVISPERRoutingObserver.h"

@protocol IVISPERWireframe <NSObject>


/**
 * add route for handling a contoller or a (should be discovered by the controllerServiceProvider of this wireframe)
 */
- (void)addRoute:(NSString *)routePattern;

- (void)addRoute:(NSString *)routePattern
        priority:(NSUInteger)priority
         handler:(BOOL (^)(NSDictionary *parameters))handlerBlock;

/**
 * Routes a URL, calling handler blocks (for patterns that match URL) until 
 * one returns YES, optionally specifying add'l parameters
 **/
- (BOOL)routeURL:(NSURL *)URL;
- (BOOL)routeURL:(NSURL *)URL withParameters:(NSDictionary *)parameters;
- (BOOL)routeURL:(NSURL *)URL withParameters:(NSDictionary *)parameters options:(NSObject<IVISPERRoutingOption>*)options;


/**
* Returns the controller presented by the wireframe when routing this URL
*/
-(UIViewController*)controllerForURL:(NSURL*)URL withParameters:(NSDictionary *)parameters;

/**
 * Returns whether a route exists for a URL
 **/
- (BOOL)canRouteURL:(NSURL *)URL; // instance method
- (BOOL)canRouteURL:(NSURL *)URL withParameters:(NSDictionary *)parameters;

/**
 *  IVISPERWireframeViewControllerServiceProvider for providing controllers when none are given
 */
-(void)addControllerServiceProvider:(NSObject<IVISPERControllerProvider>*)controllerServiceProvider
                       withPriority:(NSInteger)priority;

/**
 * add Routing presenter, responsible for routing controllers with specific RoutingOptions
 **/
-(void)addRoutingPresenter:(NSObject<IVISPERRoutingPresenter>*)presenter withPriority:(NSInteger)priority;


/**
 * add routing observer for observing controller routing
 **/
-(void)addRoutingObserver:(NSObject<IVISPERRoutingObserver>*)observer withPriority:(NSInteger)priority;


/**
 *  IVISPERWireframeViewControllerServiceProvider for providing routing options when none are given
 */
-(void)addRoutingOptionsServiceProvider:(NSObject<IVISPERRoutingOptionsProvider>*)routingOptionsServiceProvider
                           withPriority:(NSInteger)priority;

/**
 * ViewController management
 **/
-(UIViewController*)currentViewController;
-(void)back:(BOOL)animated completion:(void(^)(void))completion;

@end
