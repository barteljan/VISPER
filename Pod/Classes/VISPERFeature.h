//
//  VISPERFeature.h
//  Pods
//
//  Created by Bartel on 20.08.15.
//
//

#import <Foundation/Foundation.h>
#import "IVISPERFeature.h"
#import "IVISPERWireframeViewControllerServiceProvider.h"
#import "IVISPERWireframeRoutingOptionsServiceProvider.h"

@interface VISPERFeature : NSObject<IVISPERFeature,
                                    IVISPERWireframeViewControllerServiceProvider,
                                    IVISPERWireframeRoutingOptionsServiceProvider>


@property(readonly,nonatomic,strong)NSObject<IVISPERWireframe>*wireframe;
@property(readonly,nonatomic,strong)NSObject<IVISPERComposedInteractor>*interactor;

-(void)addRoutePattern:(NSString*)routePattern;
-(void)removeRoutePattern:(NSString*)routePattern;
-(NSMutableArray*)routePatternStrings;

@end
