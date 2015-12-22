//
//  VISPERWireframe.h
//  Pods
//
//  Created by Bartel on 11.07.15.
//
//

#import <Foundation/Foundation.h>
@import JLRoutes;
#import "IVISPERWireframe.h"
#import "IVISPERWireframeServiceProvider.h"
#import "IVISPERRoutingOption.h"
#import "IVISPERControllerProvider.h"
#import "IVISPERRoutingOptionsProvider.h"
#import "VISPERPriorizedObjectStore.h"

@interface VISPERWireframe : NSObject<IVISPERWireframe>



/**
 *  Service Provider
 **/
@property(nonatomic)IBOutlet NSObject<IVISPERWireframeServiceProvider>*serviceProvider;


/**
 * Child wireframes of this wireframe
 **/
@property(nonatomic) NSArray *childWireframes;


/**
 * Called any time routeURL returns NO. Respects shouldFallbackToGlobalRoutes.
 **/
@property (nonatomic, copy) BOOL (^unmatchedURLHandler)(NSObject<IVISPERWireframe> *routes, NSURL *URL, NSDictionary *parameters);

/**
 * Factory for generating routing options internally
 */
@property (nonatomic,strong) NSObject<IVISPERRoutingOptionsFactory> *routingOptionsFactory;

/**
 * init functions
 **/
-(instancetype)initWithRoutes:(JLRoutes*)routes;

-(instancetype)initWithServiceProvider:(NSObject<IVISPERWireframeServiceProvider>*)serviceProvider;

-(instancetype)initWithRoutes:(JLRoutes*)routes
              serviceProvider:(NSObject<IVISPERWireframeServiceProvider>*)serviceProvider;


@end
