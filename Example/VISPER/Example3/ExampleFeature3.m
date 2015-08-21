//
//  ExampleFeature3.m
//  VISPER
//
//  Created by Bartel on 20.08.15.
//  Copyright (c) 2015 Jan Bartel. All rights reserved.
//

#import "ExampleFeature3.h"

@implementation ExampleFeature3

-(instancetype)init{
    self = [super init];
    if(self){
        [self addRoutePattern:@"/example3"];
    }
    return self;
}

-(UIViewController*)controllerForRoute:(NSString*)routePattern
                        routingOptions:(NSObject<IVISPERRoutingOption>*)options
                        withParameters:(NSDictionary*)parameters{
    
    if ([routePattern isEqualToString:@"/example3"]) {
        Example3VisperViewControllerPresenter *example3VCPresenter =
        [[Example3VisperViewControllerPresenter alloc] initWithWireframe:self.wireframe];
        
        Example3VisperViewController *viewController =
        [[Example3VisperViewController alloc] initWithNibName:@"Example3VisperViewController"
                                                       bundle:nil];
        [viewController addVisperPresenter:example3VCPresenter];
        
        return viewController;
    }

    
    
    return nil;
}


-(NSObject<IVISPERRoutingOption> *)optionForRoutePattern:(NSString *)routePattern
                                              parameters:(NSDictionary*)parameters
                                          currentOptions:(NSObject<IVISPERRoutingOption>*)currentOptions{
    if(currentOptions){
        return currentOptions;
    }
    
    if ([routePattern isEqualToString:@"/example2"]) {
        return [self.wireframe pushRoutingOption:YES];
    }
    
    return nil;
}


@end
