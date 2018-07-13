//
//  UIViewController+Lifecycle.m
//  VISPER-UIViewController
//
//  Created by bartel on 13.12.17.
//

@import VISPER_Objc;
@import VISPER_Presenter;
#import "UIViewController+Lifecycle.h"
#import "UIViewController+Presenter.h"
#import <objc/runtime.h>


@implementation UIViewController (Lifecycle)

#pragma mark: method swizzeling
//(doing some bad stuff to deliver controller lifecycle events to our presenters)
+(void)swizzleReplaceSelector:(SEL)originalSelector
                         with:(SEL)swizzledSelector{
    Class class = [self class];
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

#pragma mark: Load enable visper lifecycle events
+ (void)enableLifecycleEvents {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleReplaceSelector:@selector(loadView) with:@selector(visper_loadView)];
        [self swizzleReplaceSelector:@selector(viewDidLoad) with:@selector(visper_viewDidLoad)];
        [self swizzleReplaceSelector:@selector(viewWillAppear:) with:@selector(visper_viewWillAppear:)];
        [self swizzleReplaceSelector:@selector(viewDidAppear:) with:@selector(visper_viewDidAppear:)];
        [self swizzleReplaceSelector:@selector(viewWillDisappear:) with:@selector(visper_viewWillDisappear:)];
        [self swizzleReplaceSelector:@selector(viewDidDisappear:) with:@selector(visper_viewDidDisappear:)];
    });
}

-(void)visper_loadView{
    [self visper_loadView];
    
    LoadViewEvent *event = [[LoadViewEvent alloc] initWithSender:self];
    [self notifyPresentersOfView:self.view withEvent:event];
}

-(void)visper_viewDidLoad{
    [self visper_viewDidLoad];
    
    ViewDidLoadEvent *event = [[ViewDidLoadEvent alloc] initWithSender:self];
    [self notifyPresentersOfView:self.view withEvent:event];
}


- (void)visper_viewWillAppear:(BOOL)animated {
    [self visper_viewWillAppear:animated];
    
    ViewWillAppearEvent *event = [[ViewWillAppearEvent alloc] initWithSender:self animated:animated];
    [self notifyPresentersOfView:self.view withEvent:event];
}

- (void)visper_viewDidAppear:(BOOL)animated {
    [self visper_viewDidAppear:animated];
    
    ViewDidAppearEvent *event = [[ViewDidAppearEvent alloc] initWithSender:self animated:animated];
    [self notifyPresentersOfView:self.view withEvent:event];
}

- (void)visper_viewWillDisappear:(BOOL)animated {
    [self visper_viewWillDisappear:animated];
    
    ViewWillDisappearEvent *event = [[ViewWillDisappearEvent alloc] initWithSender:self animated:animated];
    [self notifyPresentersOfView:self.view withEvent:event];
}

- (void)visper_viewDidDisappear:(BOOL)animated {
    [self visper_viewDidDisappear:animated];
    
    ViewDidDisappearEvent *event = [[ViewDidDisappearEvent alloc] initWithSender:self animated:animated];
    [self notifyPresentersOfView:self.view withEvent:event];
}

@end
