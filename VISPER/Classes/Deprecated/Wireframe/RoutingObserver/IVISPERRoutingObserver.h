//
//  IVISPERRoutingObserver.h
//  Pods
//
//  Created by Jan Bartel on 01.10.15.
//
//

#import <Foundation/Foundation.h>
@import UIKit;
@protocol IVISPERRoutingOption;
@protocol IVISPERWireframe;
@protocol IVISPERRoutingPresenter;

@protocol IVISPERRoutingObserver <NSObject>

-(void) routeToController:(UIViewController* _Nonnull)controller
             routePattern:(NSString* _Nonnull)routePattern
                  options:(NSObject<IVISPERRoutingOption>* _Nonnull)option
               parameters:(NSDictionary* _Nonnull)parameters
         routingPresenter:(NSObject<IVISPERRoutingPresenter>* _Nonnull)presenter
                wireframe:(NSObject<IVISPERWireframe>* _Nonnull)wireframe;


@end

