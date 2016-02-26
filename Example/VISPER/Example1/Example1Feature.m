//
//  Example1Feature.m
//  VISPER
//
//  Created by Bartel on 20.08.15.
//  Copyright (c) 2015 Jan Bartel. All rights reserved.
//

#import "Example1Feature.h"
#import "Example1VisperViewController.h"
#import "Example1VisperViewControllerPresenter.h"
#import <VISPER/VISPER.h>
#import "VISPER_Example-swift.h"

@implementation Example1Feature

-(instancetype)init{
    self = [super init];
    if(self){
        [self addRoutePattern:@"/example1"];
    }
    return self;
}


-(void)bootstrapWireframe:(NSObject<IVISPERWireframe> *)wireframe commandBus:(VISPERCommandBus *)commandBus{
    [super bootstrapWireframe:wireframe commandBus:commandBus];
    
    DataCommandHandler *dataHandler = [[DataCommandHandler alloc] init];
    
    [commandBus addHandler:dataHandler];

}


-(UIViewController*)controllerForRoute:(NSString*)routePattern
                        routingOptions:(NSObject<IVISPERRoutingOption>*)options
                        withParameters:(NSDictionary*)parameters{
    
    //create controller 1
    if ([routePattern isEqualToString:@"/example1"]){
        Example1VisperViewControllerPresenter *example1VCPresenter =
        [[Example1VisperViewControllerPresenter alloc] initWithWireframe:self.wireframe commandBus:self.commandBus];
        
        Example1VisperViewController *example1VC =
        [[Example1VisperViewController alloc] initWithNibName:@"Example1VisperViewController"
                                                       bundle:nil
                                              serviceProvider:nil
                                                    presenter:example1VCPresenter];
        return example1VC;
    }
    
    return nil;
}


-(NSObject<IVISPERRoutingOption> *)optionForRoutePattern:(NSString *)routePattern
                                              parameters:(NSDictionary*)parameters
                                          currentOptions:(NSObject<IVISPERRoutingOption>*)currentOptions{
    if(currentOptions){
        return currentOptions;
    }
    
    if ([routePattern isEqualToString:@"/example1"]) {
        return [VISPER routingOptionPresentRootVC:NO];
    }
    
    return nil;
}

@end
