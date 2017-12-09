//
//  IVISPERWireframeServiceProvider.h
//  Pods
//
//  Created by Bartel on 12.07.15.
//
//

#import <Foundation/Foundation.h>
#import "IVISPERRoutingOption.h"
#import "IVISPERRoutingPresenter.h"
#import "IVISPERWireframeViewControllerServiceProvider.h"
#import "IVISPERRoutingEvent.h"

@protocol IVISPERWireframeServiceProvider <NSObject>

/**
 * Generate a new empty wireframe
 */
-(NSObject<IVISPERWireframe>*)emptyWireframeFromWireframe:(NSObject<IVISPERWireframe>*)existingWireframe;

/**
 * Generate routing event
 */
-(NSObject<IVISPERRoutingEvent>*)createEventWithName:(NSString*)name
                                              sender:(id)sender
                                                info:(NSDictionary*)info;

@end
