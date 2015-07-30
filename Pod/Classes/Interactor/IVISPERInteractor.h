//
//  IVISPERInteractor.h
//  Pods
//
//  Created by Bartel on 23.07.15.
//
//

#import <Foundation/Foundation.h>

@protocol IVISPERInteractor <NSObject>

-(BOOL)isResponsibleForCommand:(NSObject*)command
                         error:(NSError*)error;

-(NSString*)identifier;

-(void)processCommand:(NSObject*)command
                completion:(void(^)(NSString *identifier,NSObject *object,NSError *error))completion;

@end
