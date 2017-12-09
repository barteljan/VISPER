//
// Created by bartel on 13.08.15.
//

#import "VISPERPresententationTypeDoNotPresentVC.h"


@implementation VISPERPresententationTypeDoNotPresentVC

-(instancetype)initWithCompletion:(void(^)(NSString *routePattern,
                                           UIViewController *controller,
                                           NSObject<IVISPERRoutingOption>*options,
                                           NSDictionary *parameters,
                                           NSObject<IVISPERWireframe>*wireframe))completion{
    self = [super initIsAnimated:NO];
    if(self){
        self->_completionBlock = completion;
    }
    return self;
}

@end