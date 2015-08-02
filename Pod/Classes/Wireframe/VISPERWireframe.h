//
//  VISPERWireframe.h
//  Pods
//
//  Created by Bartel on 11.07.15.
//
//

#import <Foundation/Foundation.h>
#import <JLRoutes/JLRoutes.h>
#import "IVISPERWireframe.h"
#import "IVISPERWireframeServiceProvider.h"
#import "IVISPERRoutingOption.h"
#import "IVISPERWireframeViewControllerServiceProvider.h"
#import "IVISPERWireframeRoutingOptionsServiceProvider.h"
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
@property (nonatomic, copy) void (^unmatchedURLHandler)(NSObject<IVISPERWireframe> *routes, NSURL *URL, NSDictionary *parameters);

/**
 * init functions
 **/
-(instancetype)initWithRoutes:(JLRoutes*)routes;

-(instancetype)initWithServiceProvider:(NSObject<IVISPERWireframeServiceProvider>*)serviceProvider;

-(instancetype)initWithRoutes:(JLRoutes*)routes
              serviceProvider:(NSObject<IVISPERWireframeServiceProvider>*)serviceProvider;


@end
