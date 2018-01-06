//
//  VISPERCommandHandler.m
//  Pods
//
//  Created by Jan Bartel on 26.02.16.
//
//

#import "VISPERCommandHandler.h"

@implementation VISPERCommandHandler

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

-(BOOL)isResponsibleForCommand:(NSObject *)command error:(NSError**)error{
    return NO;
}

-(void)processCommand:(NSObject*)command
           completion:(BOOL(^)(NSString *identifier,NSObject *object,NSError **error))completion{
}


@end
