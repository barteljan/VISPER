//
//  IVISPERRoutingOption.h
//  Pods
//
//  Created by Bartel on 14.07.15.
//
//

#import <Foundation/Foundation.h>
#import "IVISPERWireframePresentationType.h"

@protocol IVISPERRoutingOption <NSObject>
-(NSObject<IVISPERWireframePresentationType>*)wireframePresentationType;
@end
