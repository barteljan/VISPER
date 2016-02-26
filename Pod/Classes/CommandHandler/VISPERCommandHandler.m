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
    return NO;
}

-(void)processCommand:(NSObject*)command
           completion:(BOOL(^)(NSString *identifier,NSObject *object,NSError **error))completion{
}


@end
