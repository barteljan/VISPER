//
//  VISPERRoutingOption.h
//  Pods
//
//  Created by Bartel on 14.07.15.
//
//

#import <Foundation/Foundation.h>
#import "IVISPERWireframePresentationType.h"
#import "IVISPERRoutingOption.h"

@interface VISPERRoutingOption : NSObject
@property (nonatomic)NSObject<IVISPERWireframePresentationType> *wireframePresentationType;
@end
