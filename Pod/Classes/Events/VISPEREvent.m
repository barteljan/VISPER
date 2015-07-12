//
//  VISPEREvent.m
//  Pods
//
//  Created by Bartel on 12.07.15.
//
//

#import "VISPEREvent.h"

@implementation VISPEREvent

-(instancetype)initWithName:(NSString*)name
                     sender:(id)sender{
    
    return [self initWithName:name
                       sender:sender
                         info:nil];
    
}

-(instancetype)initWithName:(NSString*)name
                     sender:(id)sender
                       info:(NSDictionary *)info{
    
    self = [super init];
    if(self){
        self->_name   = name;
        self->_sender = sender;
        self->_info   = info;
    }
    return self;
    
}

@end
