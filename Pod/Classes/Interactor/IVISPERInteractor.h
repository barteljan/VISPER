//
//  IVISPERInteractor.h
//  Pods
//
//  Created by Bartel on 23.07.15.
//
//

#import <Foundation/Foundation.h>
#import "IVISPERInteractorCommand.h"

@protocol IVISPERInteractor <NSObject>

-(BOOL)isResponsibleForCommand:(NSObject<IVISPERInteractorCommand>*)command
                         error:(NSError*)error;


@end
