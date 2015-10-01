//
//  IVISPERRoutingObserver.h
//  Pods
//
//  Created by Jan Bartel on 01.10.15.
//
//

#import <Foundation/Foundation.h>
#import "IVISPERRoutingOption.h"
#import "IVISPERRoutingPresenter.h"
#import "IVISPERWireframe.h"

@protocol IVISPERRoutingObserver <NSObject>

-(void) routeToController:(UIViewController*)controller
             routePattern:(NSString*)routePattern
                  options:(NSObject<IVISPERRoutingOption>*)option
               parameters:(NSDictionary*)parameters
         routingPresenter:(NSObject<IVISPERRoutingPresenter>*)presenter
                wireframe:(NSObject<IVISPERWireframe>*)wireframe;


@end

