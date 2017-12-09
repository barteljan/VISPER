//
//  UIViewController+NVMDummy__Wireframe.h
//  VISPER-Wireframe
//
//  Created by Jan Bartel on 20.11.17.
//


#import <UIKit/UIKit.h>
@import VISPER_Wireframe_Objc;

@interface UIViewController (Wireframe)


@property (nonatomic,strong,nullable) RouteResultObjc *routeResultObjc;
@property (nonatomic,strong,nullable) NSString *routePattern;
@property (nonatomic,strong,nullable) NSDictionary *routeParameters;

-(void)willRoute: (WireframeObjc* _Nonnull) wireframe
     routeResult: (RouteResultObjc* _Nonnull) routeResult;
    
-(void) didRoute: (WireframeObjc* _Nonnull) wireframe
     routeResult: (RouteResultObjc* _Nonnull) routeResult;

@end


