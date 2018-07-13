//
//  UIViewController+NVMDummy__Wireframe.h
//  VISPER-Wireframe
//
//  Created by Jan Bartel on 20.11.17.
//


#import <UIKit/UIKit.h>
@import VISPER_Objc;

@interface UIViewController (Wireframe)

@property (nonatomic,strong,nullable) RouteResultObjc *routeResultObjc;
@property (nonatomic,readonly,nullable) NSString *routePattern;
@property (nonatomic,readonly,nullable) NSDictionary *routeParameters;

-(void)willRoute: (WireframeObjc* _Nonnull) wireframe
     routeResult: (RouteResultObjc* _Nonnull) routeResult;
    
-(void) didRoute: (WireframeObjc* _Nonnull) wireframe
     routeResult: (RouteResultObjc* _Nonnull) routeResult;

@end


