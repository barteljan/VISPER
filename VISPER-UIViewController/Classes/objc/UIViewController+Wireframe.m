//
//  UIViewController+NVMDummy__Wireframe.m
//  VISPER-Wireframe
//
//  Created by Jan Bartel on 20.11.17.
//


#import "UIViewController+Wireframe.h"
@import VISPER_Objc;
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
    return self.routeResultObjc.routePattern;
}



#pragma mark routeParameters
-(NSDictionary*)routeParameters{
    return self.routeResultObjc.parameters;
}

#pragma mark routing events
-(void)willRoute: (WireframeObjc*) wireframe
     routeResult: (RouteResultObjc*) routeResult {
    [self setRouteResultObjc:routeResult];
}
    
-(void) didRoute: (WireframeObjc*) wireframe
     routeResult: (RouteResultObjc*) routeResult  {
    ;
}

@end
