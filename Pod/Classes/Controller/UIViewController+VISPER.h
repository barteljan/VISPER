//
//  UIViewController+VISPER.h
//  Pods
//
//  Created by Bartel on 18.07.15.
//
//

#import <UIKit/UIKit.h>
#import "IVISPERPresenter.h"
#import "IVISPERViewControllerServiceProvider.h"

@interface UIViewController (VISPER)

+ (BOOL)areVISPEREventsOnAllViewControllersEnabled;
+ (void)enableVISPEREventsOnAllViewControllers;

@property (nonatomic,strong) IBOutlet NSObject<IVISPERViewControllerServiceProvider> *visperServiceProvider;


#pragma mark presenter management
@property (readonly,nonatomic, strong) NSArray *visperPresenters;

-(void)addVisperPresenter:(NSObject<IVISPERPresenter> *)presenter;
-(void)removeVisperPresenter:(NSObject<IVISPERPresenter> *)presenter;
-(void)notifyPresentersOfView:(UIView*)view
                    withEvent:(NSObject<IVISPERViewEvent>*)event;


@end
