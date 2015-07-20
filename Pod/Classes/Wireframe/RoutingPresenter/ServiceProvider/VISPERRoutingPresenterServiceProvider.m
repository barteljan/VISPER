//
//  VISPERRoutingPresenterServiceProvider.m
//  Pods
//
//  Created by Bartel on 20.07.15.
//
//

#import "VISPERRoutingPresenterServiceProvider.h"
#import "VISPERRoutingEvent.h"
#import "IVISPERRoutingEvent.h"
@implementation VISPERRoutingPresenterServiceProvider

-(NSObject<IVISPERRoutingEvent>*)createEventWithName:(NSString*)name
                                           sender:(id)sender
                                             info:(NSDictionary*)info{
    return [[VISPERRoutingEvent alloc] initWithName:name
                                             sender:sender
                                               info:info];
}
@end
