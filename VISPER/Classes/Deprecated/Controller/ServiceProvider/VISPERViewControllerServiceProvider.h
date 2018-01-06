//
//  VISPERViewControllerServiceProvider.h
//  Pods
//
//  Created by Bartel on 11.07.15.
//
//

#import <Foundation/Foundation.h>
#import "IVISPERViewControllerServiceProvider.h"

@interface VISPERViewControllerServiceProvider : NSObject<IVISPERViewControllerServiceProvider>

-(NSObject<IVISPERViewEvent>*)createEventWithName:(NSString*)name
                                           sender:(id)sender
                                             info:(NSDictionary*)info;

@end
