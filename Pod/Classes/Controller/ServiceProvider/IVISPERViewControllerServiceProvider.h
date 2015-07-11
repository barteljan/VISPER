//
//  IVISPERViewControllerServiceProvider.h
//  Pods
//
//  Created by Bartel on 11.07.15.
//
//

#import <Foundation/Foundation.h>
#import "IVISPERViewEvent.h"

@protocol IVISPERViewControllerServiceProvider <NSObject>

-(NSObject<IVISPERViewEvent>*)createEventWithName:(NSString*)name
                                           sender:(id)sender
                                             info:(NSDictionary*)info;


@end
