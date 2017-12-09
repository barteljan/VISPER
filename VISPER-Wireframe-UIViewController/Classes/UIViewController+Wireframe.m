//
//  UIViewController+NVMDummy__Wireframe.m
//  VISPER-Wireframe
//
//  Created by Jan Bartel on 20.11.17.
//


#import "UIViewController+Wireframe.h"
@import VISPER_Wireframe_Objc;
#import <objc/runtime.h>

@implementation UIViewController (Wireframe)
@dynamic routeResultObjc;
@dynamic routePattern;
@dynamic routeParameters;

#pragma mark route pattern
-(RouteResultObjc*)routeResultObjc{
    RouteResultObjc *result = objc_getAssociatedObject(self, @selector(routeResultObjc));
    return result;
}

-(void)setRouteResultObjc:(RouteResultObjc *)myRouteResult{
    objc_setAssociatedObject(self, @selector(routeResultObjc), myRouteResult , OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark route pattern
-(NSString*)routePattern{
    NSString *routePattern = objc_getAssociatedObject(self, @selector(routePattern));
    return routePattern;
}

-(void)setRoutePattern:(NSString *)myRoutePattern{
    objc_setAssociatedObject(self, @selector(routePattern), myRoutePattern , OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark routeParameters
-(NSDictionary*)routeParameters{
    NSDictionary *params = objc_getAssociatedObject(self, @selector(routeParameters));
    return params;
}


-(void)setRouteParameters:(NSDictionary *)myRouteParameters{
    objc_setAssociatedObject(self, @selector(routeParameters), myRouteParameters , OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark routing events
-(void)willRoute: (WireframeObjc*) wireframe
     routeResult: (RouteResultObjc*) routeResult {
    self.routeResultObjc = routeResult;
    self.routePattern = routeResult.routePattern;
    self.routeParameters = routeResult.parameters;
}
    
-(void) didRoute: (WireframeObjc*) wireframe
     routeResult: (RouteResultObjc*) routeResult  {
    ;
}

@end
