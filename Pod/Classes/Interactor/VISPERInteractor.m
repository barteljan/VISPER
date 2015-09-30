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

-(BOOL)isResponsibleForCommand:(NSObject *)command{

    if([self respondsToSelector:@selector(isResponsibleForCommand:error:)]){
        NSError *error = nil;
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Wdeprecated-declarations"
        return [self isResponsibleForCommand:command error:&error];
        #pragma clang diagnostic pop
    }
    return NO;
}

-(void)processCommand:(NSObject*)command
           completion:(BOOL(^)(NSString *identifier,NSObject *object,NSError **error))completion{
}

@end
