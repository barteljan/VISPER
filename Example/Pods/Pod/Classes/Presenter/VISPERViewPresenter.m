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
    
    @try {
        if(![self isAllowedToRenderView:view onViewEvent:event]){
            @throw [NSException exceptionWithName:NSInvalidArgumentException
                                           reason:[NSString stringWithFormat:@"this view with class %@ is not allowed for rendering on %@ ",
                                                                            [view class],[event name]]
                                         userInfo:@{@"view":view,@"controller":viewController} ];
            
        }
    }
    @catch (NSException *exception) {
        @throw [NSException exceptionWithName:NSInvalidArgumentException
                                       reason:[NSString stringWithFormat:@"this view with class %@ is not allowed for rendering on %@ \nterminated with the following exception:\n %@",[view class],[event name],exception.reason]
                                     userInfo:@{@"view":view,@"controller":viewController} ];
    }

    @try {
        if(![self isAllowedToRenderViewController:viewController onViewEvent:event]){
            @throw [NSException exceptionWithName:NSInvalidArgumentException
                                           reason:[NSString stringWithFormat:@"this viewController with class %@ is not allowed for rendering on %@ ",
                                                   [viewController class],[event name]]
                                         userInfo:@{@"view":view,@"controller":viewController} ];
            
        }
    }
    @catch (NSException *exception) {
        @throw [NSException exceptionWithName:NSInvalidArgumentException
                                       reason:[NSString stringWithFormat:@"this viewController with class %@ is not allowed for rendering on %@ \nterminated with the following exception:\n %@", [viewController class], [event name], exception.reason]
                                     userInfo:@{@"view" : view, @"controller" : viewController}];
    }
}

-(BOOL)isAllowedToRenderView:(UIView*)view onViewEvent:(NSObject<IVISPERViewEvent>*)event{
    return TRUE;
}

-(BOOL)isAllowedToRenderViewController:(UIViewController*)viewController onViewEvent:(NSObject<IVISPERViewEvent>*)event{
    return TRUE;
}


@end
