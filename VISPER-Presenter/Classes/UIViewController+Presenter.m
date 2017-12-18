//
//  UIViewController+Presenter.m
//  VISPER-UIViewController
//
//  Created by bartel on 13.12.17.
//

#import "UIViewController+Presenter.h"
#import <objc/runtime.h>

@interface VISPERPresenterWrapper: NSObject
@property NSObject<ViewControllerEventPresenter> *presenter;
@property NSInteger priority;
-(instancetype)initWith:(NSObject<ViewControllerEventPresenter> *)presenter priority:(NSInteger)priority;
@end
@implementation VISPERPresenterWrapper
-(instancetype)initWith:(NSObject<ViewControllerEventPresenter> *)presenter priority:(NSInteger)priority{
    self = [super init];
    if(self){
        self->_presenter = presenter;
        self->_priority = priority;
    }
    return self;
}
@end

@implementation UIViewController (Presenter)

@dynamic visperPresenters;

-(NSArray*)visperPresenters{
    NSArray *wrappers = objc_getAssociatedObject(self, @selector(visperPresenters));
    
    NSMutableArray *results = [NSMutableArray array];
    
    for(VISPERPresenterWrapper *wrapper in wrappers){
        [results addObject:wrapper.presenter];
    }
    
    return [NSArray arrayWithArray:results];
}

-(void)setVisperPresenters:(NSArray *)myVisperPresenters{
    objc_setAssociatedObject(self, @selector(visperPresenters), myVisperPresenters , OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)addVisperPresenter:(NSObject<ViewControllerEventPresenter> * __nonnull)presenter {
    [self addVisperPresenter:presenter priority: 0];
}

-(void)addVisperPresenter:(NSObject<ViewControllerEventPresenter> * __nonnull)presenter priority:(NSInteger)priority{
    
    NSMutableArray *presenters = [NSMutableArray arrayWithArray:self.visperPresenters];
    VISPERPresenterWrapper *wrapper = [[VISPERPresenterWrapper alloc] initWith:presenter priority:priority];
    [presenters addObject:wrapper];
    
    [presenters sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        
        VISPERPresenterWrapper *wrapper1 = (VISPERPresenterWrapper*)obj1;
        VISPERPresenterWrapper *wrapper2 = (VISPERPresenterWrapper*)obj2;
        
        if(!wrapper1){
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if(!wrapper2){
            return (NSComparisonResult)NSOrderedAscending;
        }

        if(wrapper1.priority > wrapper2.priority){
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if(wrapper1.priority < wrapper2.priority){
            return (NSComparisonResult)NSOrderedAscending;
        }
        
        return (NSComparisonResult)NSOrderedSame;
    }];
    
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
        
        if([presenter isResponsible:event view:view controller:self]) {
            [presenter receivedEvent:event view:view controller:self];
        }
        
    }
    
}

@end
