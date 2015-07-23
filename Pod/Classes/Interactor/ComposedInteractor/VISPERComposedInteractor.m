//
//  VISPERComposedInteractor.m
//  Pods
//
//  Created by Bartel on 23.07.15.
//
//

#import "VISPERComposedInteractor.h"

@implementation VISPERComposedInteractor

-(NSArray*)interactors{
    if(!self->_interactors){
        self->_interactors = [[NSArray alloc] init];
    }
    return self->_interactors;
}


-(void)addInteractor:(NSObject<IVISPERInteractor>*)interactor{
    self.interactors = [self.interactors arrayByAddingObject:interactor];
}

-(void)removeInteractor:(NSObject<IVISPERInteractor>*)interactor{
    if([self.interactors containsObject:interactor]){
        NSMutableArray *interactors = [NSMutableArray arrayWithArray:self.interactors];
        [interactors removeObject:interactor];
        self.interactors = [NSArray arrayWithArray:interactors];
    }
}

-(BOOL)isResponsibleForCommand:(NSObject<IVISPERInteractorCommand> *)command error:(NSError *)error{
    BOOL responsible = FALSE;
    
    for(NSObject<IVISPERInteractor>*interactor in self.interactors){
        if([interactor isResponsibleForCommand:command error:error]){
            responsible = TRUE;
            break;
        }
    }

    return responsible;
}

-(NSObject*)processCommand:(NSObject<IVISPERInteractorCommand>*)command
                completion:(void(^)(NSString *identifier,NSObject *object,NSError *error))completion{
    NSMutableArray *responseArray = [[NSMutableArray alloc] init];
    
    for(NSObject<IVISPERInteractor>*interactor in self.interactors){
        NSError *error = nil;
        if([interactor isResponsibleForCommand:command error:error] &&
           [interactor respondsToSelector:@selector(processCommand:completion:)]){
           [interactor processCommand:command completion:^(NSString *identifier, NSObject *object, NSError *error) {
               completion(identifier,object,error);
           }];
        }
    }
    
    return [NSArray arrayWithArray:responseArray];
}


@end