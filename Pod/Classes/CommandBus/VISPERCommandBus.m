//
//  VISPERCommandBus.m
//  Pods
//
//  Created by Bartel on 22.12.15.
//
//

#import "VISPERCommandBus.h"

@interface VISPERCommandBus()
@property (nonatomic) BOOL strictMode;
@end

@implementation VISPERCommandBus

#pragma mark properties
-(NSArray*)commandHandlers{
    if(!self->_commandHandlers){
        self->_commandHandlers = [[NSArray alloc] init];
    }
    return self->_commandHandlers;
}


#pragma mark IVISPERCommandBus protocol
-(void)addHandler:(NSObject<IVISPERCommandHandler> *)commandHandler{
    self.commandHandlers = [self.commandHandlers arrayByAddingObject:commandHandler];
}

-(void)removeHandler:(NSObject<IVISPERCommandHandler> *)commandHandler{
    if([self.commandHandlers containsObject:commandHandler]){
        NSMutableArray *commandHandlers = [NSMutableArray arrayWithArray:self.commandHandlers];
        [commandHandlers removeObject:commandHandler];
        self.commandHandlers = [NSArray arrayWithArray:commandHandlers];
    }
}

-(BOOL)isInStrictMode{
    return self.strictMode;
}

-(void)setStrictMode:(BOOL)isInStrictMode{
    self->_strictMode = isInStrictMode;
}


#pragma mark IVISPERCommandHandler protocol
-(BOOL)isResponsibleForCommand:(NSObject*)command{
    BOOL responsible = FALSE;
    
    for(NSObject<IVISPERCommandHandler>*handler in self.commandHandlers){
        if([handler isResponsibleForCommand:command]){
            responsible = TRUE;
            break;
        }
    }
    
    return responsible;
}

-(void)processCommand:(NSObject*)command
           completion:(BOOL(^)(NSString *identifier,NSObject *object,NSError **error))completion{
    
    BOOL foundResponsibleCommand = FALSE;
    
    for(NSObject<IVISPERCommandHandler>*handler in self.commandHandlers){
        if([handler isResponsibleForCommand:command] &&
           [self canCallHandler:handler]){
            foundResponsibleCommand = TRUE;
            [handler processCommand:command
                            completion:completion];
        }
    }
    
    
    if(self.strictMode && !foundResponsibleCommand){
        @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                       reason:[NSString stringWithFormat:@"Did not found handler for command %@",command]
                                     userInfo:@{
                                                @"command":command
                                                }];
    }
}

#pragma mark helper functions
-(BOOL)canCallHandler:(NSObject<IVISPERCommandHandler>*)handler{
    return [handler respondsToSelector:@selector(processCommand:completion:)];
}


#pragma mark deprecated methods
-(NSArray*)interactors{
    if(!self->_commandHandlers){
        self->_commandHandlers = [[NSArray alloc] init];
    }
    return self->_commandHandlers;
}


-(void)setInteractors:(NSArray *)interactors{
    self->_commandHandlers = interactors;
}

-(void)addInteractor:(NSObject<IVISPERCommandHandler>*)interactor{
    [self addHandler:interactor];
}

-(void)removeInteractor:(NSObject<IVISPERCommandHandler>*)interactor{
    [self removeHandler:interactor];
}

@end
