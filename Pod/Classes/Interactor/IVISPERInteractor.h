//
//  IVISPERInteractor.h
//  Pods
//
//  Created by Bartel on 23.07.15.
//
//

#import <Foundation/Foundation.h>

@protocol IVISPERInteractor <NSObject>


-(BOOL)isResponsibleForCommand:(NSObject*)command;

-(NSString*)identifier;

-(void)processCommand:(NSObject*)command
           completion:(BOOL(^)(NSString *identifier,NSObject *object,NSError **error))completion;

@optional

-(BOOL)isResponsibleForCommand:(NSObject*)command
                         error:(NSError**)error
                              __attribute((deprecated("use isResponsibleForCommand: instead.")));


@end
