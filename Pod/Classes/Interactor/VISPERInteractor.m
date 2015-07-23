//
//  VISPERInteractor.m
//  Pods
//
//  Created by Bartel on 23.07.15.
//
//

#import "VISPERInteractor.h"

@implementation VISPERInteractor

-(id)initWithIdentifier:(NSString*)identifier{
    self = [super init];
    if(self){
        self->_identifier = identifier;
    }
    return self;
}


-(BOOL)isResponsibleForCommand:(NSObject*)command
                         error:(NSError*)error{
    return NO;
}

-(NSObject*)processCommand:(NSObject*)command
                completion:(void(^)(NSString *identifier,NSObject *object,NSError *error))completion{
    return nil;
}

@end
