//
//  VISPERInteractor.m
//  Pods
//
//  Created by Bartel on 23.07.15.
//
//

#import "VISPERInteractor.h"

@implementation VISPERInteractor

-(BOOL)isResponsibleForCommand:(NSObject<IVISPERInteractorCommand>*)command
                         error:(NSError*)error{
    return NO;
}


-(NSObject*)processCommand:(NSObject<IVISPERInteractorCommand>*)command
                completion:(void(^)(NSObject*,NSError*))completion{
    completion(nil,nil);
    return nil;
}


@end
