//
//  UIViewController+Presenter.m
//  VISPER-UIViewController
//
//  Created by bartel on 13.12.17.
//

@import VISPER_Presenter;
#import "UIViewController+Presenter.h"
#import <objc/runtime.h>

@implementation UIViewController (Presenter)

@dynamic visperPresenters;

-(NSArray*)visperPresenters{
    NSArray *result = objc_getAssociatedObject(self, @selector(visperPresenters));
    
    if(result == nil) {
        [self setVisperPresenters:[NSArray array]];
    }
    
    return result;
}

-(void)setVisperPresenters:(NSArray *)myVisperPresenters{
    objc_setAssociatedObject(self, @selector(visperPresenters), myVisperPresenters , OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)addVisperPresenter:(NSObject<ViewControllerEventPresenter> * __nonnull)presenter {
    
    NSMutableArray *presenters = [NSMutableArray arrayWithArray:self.visperPresenters];
    [presenters addObject:presenter];
    [self setVisperPresenters:presenters];
    
}

-(void)removeVisperPresenter:(NSObject<ViewControllerEventPresenter> *__nonnull)presenter {
    
    NSMutableArray *presenters = [NSMutableArray arrayWithArray:self.visperPresenters];
    [presenters removeObject:presenter];
    [self setVisperPresenters:presenters];
    
}

-(void)notifyPresentersOfView:(UIView* __nonnull)view
                    withEvent:(NSObject* __nonnull)event {
    
    NSArray *presenters = [NSArray arrayWithArray:self.visperPresenters];
    
    for(NSObject<ViewControllerEventPresenter>*presenter in presenters ){
        
        if([presenter isResponsibleForEvent:event view:view controller:self]){
            [presenter receivedEventWithEvent:event view:view controller:self];
        }
        
    }
    
}

@end
