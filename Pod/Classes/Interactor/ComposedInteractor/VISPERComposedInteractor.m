//
//  VISPERComposedInteractor.m
//  Pods
//
//  Created by Bartel on 23.07.15.
//
//

#import "VISPERComposedInteractor.h"
@interface VISPERComposedInteractor()
@property (nonatomic) BOOL strictMode;
@end


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

-(BOOL)isResponsibleForCommand:(NSObject*)command{
    BOOL responsible = FALSE;
    
    for(NSObject<IVISPERInteractor>*interactor in self.interactors){
        if([interactor isResponsibleForCommand:command]){
            responsible = TRUE;
            break;
        }
    }
    
    return responsible;
}

-(void)processCommand:(NSObject*)command
                completion:(BOOL(^)(NSString *identifier,NSObject *object,NSError **error))completion{

    BOOL foundResponsibleCommand = FALSE;
    
    for(NSObject<IVISPERInteractor>*interactor in self.interactors){
        if([interactor isResponsibleForCommand:command] &&
           [self canCallInteractor:interactor]){
                foundResponsibleCommand = TRUE;
                [interactor processCommand:command
                                completion:completion];
        }
    }
    
    
    if(self.strictMode && !foundResponsibleCommand){
        @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                       reason:[NSString stringWithFormat:@"Did not found interactor for command %@",command]
                                     userInfo:@{
                                                @"command":command
                                                }];
    }
}

-(BOOL)canCallInteractor:(NSObject<IVISPERInteractor>*)interactor{
    return [interactor respondsToSelector:@selector(processCommand:completion:)];
}

-(BOOL)isInStrictMode{
    return self.strictMode;
}

-(void)setStrictMode:(BOOL)isInStrictMode{
    self->_strictMode = isInStrictMode;
}

@end
