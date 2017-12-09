//
// Created by bartel on 13.08.15.
//

#import <Foundation/Foundation.h>
#import "IVISPERWireframePresentationType.h"

@protocol IVISPERRoutingOption;
@protocol IVISPERWireframe;

@protocol IVISPERWireframePresentationTypeDoNotPresentVC <IVISPERWireframePresentationType>

@property (readonly,nonatomic,copy) void(^completionBlock)(NSString *routePattern,
                                                           UIViewController *controller,
                                                           NSObject<IVISPERRoutingOption>*options,
                                                           NSDictionary *parameters,
                                                           NSObject<IVISPERWireframe>*wireframe);

@end