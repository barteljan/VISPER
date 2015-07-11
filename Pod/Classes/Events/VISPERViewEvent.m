//
//  VISPERViewEvent.m
//  VISPER
//
//  Created by Bartel on 10.07.15.
//  Copyright (c) 2015 Jan Bartel. All rights reserved.
//

#import "VISPERViewEvent.h"

@implementation VISPERViewEvent

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
