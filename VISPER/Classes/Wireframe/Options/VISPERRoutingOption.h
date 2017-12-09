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

@interface VISPERRoutingOption : NSObject<IVISPERRoutingOption>

@property (nonatomic)NSObject<IVISPERWireframePresentationType> *wireframePresentationType;

-(id)initWithPresentationType:(NSObject <IVISPERWireframePresentationType>*)presentationType;
@end
