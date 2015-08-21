//
//  ExampleFeature2.m
//  VISPER
//
//  Created by Bartel on 20.08.15.
//  Copyright (c) 2015 Jan Bartel. All rights reserved.
//

#import "ExampleFeature2.h"
#import "Example2VisperViewController.h"
#import "Example2VisperViewControllerPresenter.h"
#import <VISPER/VISPER.h>

@implementation ExampleFeature2

-(instancetype)init{
    self = [super init];
    if(self){
        [self addRoutePattern:@"/example2"];
    }
    return self;
}

-(UIViewController*)controllerForRoute:(NSString*)routePattern
                        routingOptions:(NSObject<IVISPERRoutingOption>*)options
                        withParameters:(NSDictionary*)parameters{
    
    if ([routePattern isEqualToString:@"/example2"]) {
        Example2VisperViewControllerPresenter *example2VCPresenter =
        [[Example2VisperViewControllerPresenter alloc] initWithWireframe:self.wireframe];
        
        Example2VisperViewController *example2VC = [[Example2VisperViewController alloc] initWithNibName:@"Example2VisperViewController"
                                                                                                  bundle:nil];
        [example2VC addVisperPresenter:example2VCPresenter];
        return example2VC;
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
        return [VISPER routingOptionPush:YES];
    }
    
    return nil;
}


@end
