//
//  VISPERViewControllerServiceProvider.m
//  Pods
//
//  Created by Bartel on 11.07.15.
//
//

#import "VISPERViewControllerServiceProvider.h"
#import "VISPERViewEvent.h"

@implementation VISPERViewControllerServiceProvider
-(NSObject<IVISPERViewEvent>*)createEventWithName:(NSString*)name
                                           sender:(id)sender
                                             info:(NSDictionary*)info{
    return [[VISPERViewEvent alloc] initWithName:name
                                          sender:sender
                                            info:info];
}
@end
