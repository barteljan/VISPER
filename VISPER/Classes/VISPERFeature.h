//
//  VISPERFeature.h
//  Pods
//
//  Created by Bartel on 20.08.15.
//
//

#import <Foundation/Foundation.h>
#import "IVISPERFeature.h"
#import "IVISPERControllerProvider.h"
#import "IVISPERRoutingOptionsProvider.h"

@interface VISPERFeature : NSObject<IVISPERFeature,
                                    IVISPERControllerProvider,
                                    IVISPERRoutingOptionsProvider>


@property(readonly,nonatomic,strong)NSObject<IVISPERWireframe>*wireframe;
@property(readonly,nonatomic,strong)VISPERCommandBus *commandBus;

-(void)addRoutePattern:(NSString*)routePattern;
-(void)removeRoutePattern:(NSString*)routePattern;
-(NSMutableArray*)routePatternStrings;


@end
