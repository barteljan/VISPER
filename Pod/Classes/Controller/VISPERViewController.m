//
//  VISPERViewController.m
//  VISPER
//
//  Created by Bartel on 10.07.15.
//  Copyright (c) 2015 Jan Bartel. All rights reserved.
//

#import "VISPERViewController.h"

@interface VISPERViewController ()

@end

@implementation VISPERViewController

#pragma mark init funtions
-(instancetype)initWithServiceProvider:(NSObject<IVISPERViewControllerServiceProvider>*)serviceProvider
                             presenter:(NSObject<IVISPERPresenter>*)presenter{
    self = [super init];
    if (self) {
        [self setVisperServiceProvider:serviceProvider] ;
        [self addVisperPresenter:presenter];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
             serviceProvider:(NSObject<IVISPERViewControllerServiceProvider>*)serviceProvider
                   presenter:(NSObject<IVISPERPresenter>*)presenter{
    self = [super initWithCoder:aDecoder];
    if(self){
        [self setVisperServiceProvider:serviceProvider] ;
        [self addVisperPresenter:presenter];
    }
    return self;
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil
                        bundle:(NSBundle *)nibBundleOrNil
               serviceProvider:(NSObject<IVISPERViewControllerServiceProvider>*)serviceProvider
                     presenter:(NSObject<IVISPERPresenter>*)presenter{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        [self setVisperServiceProvider:serviceProvider] ;
        [self addVisperPresenter:presenter];
    }
    return self;
}


#pragma mark view lifecycle
-(void)loadView{
    [super loadView];
    
    if(![UIViewController areVISPEREventsOnAllViewControllersEnabled]){
    
        NSObject<IVISPERViewEvent> *event = [self.visperServiceProvider createEventWithName:@"loadView"
                                                                                     sender:self
                                                                                       info:nil];
        [self notifyPresentersOfView:self.view withEvent:event];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(![UIViewController areVISPEREventsOnAllViewControllersEnabled]){
        NSObject<IVISPERViewEvent> *event = [self.visperServiceProvider createEventWithName:@"viewDidLoad"
                                                                                     sender:self
                                                                                       info:nil];
        [self notifyPresentersOfView:self.view withEvent:event];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    if(![UIViewController areVISPEREventsOnAllViewControllersEnabled]){
        NSObject<IVISPERViewEvent> *event = [self.visperServiceProvider createEventWithName:@"viewWillAppear"
                                                                                     sender:self
                                                                                       info:@{@"animated":(animated)?@TRUE:@FALSE}];
        [self notifyPresentersOfView:self.view withEvent:event];
    }

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if(![UIViewController areVISPEREventsOnAllViewControllersEnabled]){
        NSObject<IVISPERViewEvent> *event = [self.visperServiceProvider createEventWithName:@"viewDidAppear"
                                                                                     sender:self
                                                                                       info:@{@"animated":(animated)?@TRUE:@FALSE}];
    
        [self notifyPresentersOfView:self.view withEvent:event];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    if(![UIViewController areVISPEREventsOnAllViewControllersEnabled]){
        NSObject<IVISPERViewEvent> *event = [self.visperServiceProvider createEventWithName:@"viewWillDisappear"
                                                                                     sender:self
                                                                                       info:@{@"animated":(animated)?@TRUE:@FALSE}];
        [self notifyPresentersOfView:self.view withEvent:event];
    }
}


-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    if(![UIViewController areVISPEREventsOnAllViewControllersEnabled]){
        NSObject<IVISPERViewEvent> *event = [self.visperServiceProvider createEventWithName:@"viewDidDisappear"
                                                                                     sender:self
                                                                                       info:@{@"animated":(animated)?@TRUE:@FALSE}];
        [self notifyPresentersOfView:self.view withEvent:event];
    }
}

-(void)viewWillTransitionToSize:(CGSize)size
      withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
