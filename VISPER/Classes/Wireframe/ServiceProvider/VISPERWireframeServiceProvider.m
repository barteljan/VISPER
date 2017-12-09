//
// Created by Bartel on 18.07.15.
//
#import "VISPERWireframeServiceProvider.h"

#import "VISPERWireframe.h"
#import "VISPERRoutingEvent.h"


@interface VISPERWireframeServiceProvider()
@end

@implementation VISPERWireframeServiceProvider

-(NSObject<IVISPERWireframe>*)emptyWireframeFromWireframe:(NSObject<IVISPERWireframe>*)existingWireframe{
    NSObject<IVISPERWireframe>*wireframe = [[VISPERWireframe alloc] initWithRoutes:[[JLRoutes alloc] init]
                                                                    serviceProvider:self];
    return wireframe;
}

-(NSObject<IVISPERRoutingEvent>*)createEventWithName:(NSString*)name
                                              sender:(id)sender
                                                info:(NSDictionary*)info{
    return [[VISPERRoutingEvent alloc] initWithName:name
                                             sender:sender
                                               info:info];
}

@end