//
//  IVISPERWireframeServiceProvider.h
//  Pods
//
//  Created by Bartel on 12.07.15.
//
//

#import <Foundation/Foundation.h>

@protocol IVISPERWireframeServiceProvider <NSObject>

@optional

-(BOOL (^)(NSDictionary *parameters))blockForRoute:(NSString*)routePattern
                                      withParameters:(NSDictionary *)parameters;

-(UIViewController*)controllerForRoute:(NSString*)routePattern
                        withParameters:(NSDictionary*)parameters;
@end
