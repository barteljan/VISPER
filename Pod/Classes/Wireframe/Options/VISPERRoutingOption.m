//
//  VISPERRoutingOption.m
//  Pods
//
//  Created by Bartel on 14.07.15.
//
//

#import "VISPERRoutingOption.h"

@implementation VISPERRoutingOption

-(id)initWithPresentationType:(NSObject <IVISPERWireframePresentationType>*)presentationType{
    self = [super init];
    if(self){
        self->_wireframePresentationType = presentationType;
    }
    return self;
}

@end
