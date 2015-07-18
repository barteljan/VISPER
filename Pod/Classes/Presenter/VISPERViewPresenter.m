//
//  VISPERViewPresenter.m
//  VISPER
//
//  Created by Bartel on 10.07.15.
//  Copyright (c) 2015 Jan Bartel. All rights reserved.
//

#import "VISPERViewPresenter.h"

@implementation VISPERViewPresenter

-(instancetype)initWithWireframe:(NSObject<IVISPERWireframe>*)wireframe{
    self = [super init];
    if(self){
        self->_wireframe = wireframe;
    }
    return self;
}


-(void)renderView:(UIView*)view
   withController:(UIViewController*)viewController
          onEvent:(NSObject<IVISPERViewEvent>*)event{
    
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
    
}

-(BOOL)isResponsibleForView:(UIView*)view
             withController:(UIViewController*)controller
                    onEvent:(NSObject<IVISPERViewEvent> *)event{

    return TRUE;
}

@end
