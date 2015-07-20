//
//  IVISPERRoutingPresenterServiceProvider.h
//  Pods
//
//  Created by Bartel on 20.07.15.
//
//

#import <Foundation/Foundation.h>
#import "IVISPERRoutingEvent.h"

@protocol IVISPERRoutingPresenterServiceProvider <NSObject>
-(NSObject<IVISPERRoutingEvent>*)createEventWithName:(NSString*)name
                                           sender:(id)sender
                                             info:(NSDictionary*)info;
@end
