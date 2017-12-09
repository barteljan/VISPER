//
// Created by bartel on 13.08.15.
//

#import <Foundation/Foundation.h>
#import "VISPERPresentationType.h"
#import "IVISPERWireframePresentationTypeDoNotPresentVC.h"

@interface VISPERPresententationTypeDoNotPresentVC : VISPERPresentationType<IVISPERWireframePresentationTypeDoNotPresentVC>


-(instancetype)initWithCompletion:(void(^)(NSString *routePattern,
                                           UIViewController *controller,
                                           NSObject<IVISPERRoutingOption>*options,
                                           NSDictionary *parameters,
                                           NSObject<IVISPERWireframe>*wireframe))completion;

@property (readonly,nonatomic,copy) void(^completionBlock)(NSString *routePattern,
                                                           UIViewController *controller,
                                                           NSObject<IVISPERRoutingOption>*options,
                                                           NSDictionary *parameters,
                                                           NSObject<IVISPERWireframe>*wireframe);

@end