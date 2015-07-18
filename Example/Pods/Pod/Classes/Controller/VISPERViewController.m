//
//  VISPERViewController.m
//  VISPER
//
//  Created by Bartel on 10.07.15.
//  Copyright (c) 2015 Jan Bartel. All rights reserved.
//

#import "VISPERViewController.h"
#import "IVISPERViewEvent.h"
#import "VISPERViewEvent.h"
#import "VISPERViewControllerServiceProvider.h"

@interface VISPERViewController ()

@end

@implementation VISPERViewController

#pragma mark init funtions
-(instancetype)initWithServiceProvider:(NSObject<IVISPERViewControllerServiceProvider>*)serviceProvider
                             presenter:(NSObject<IVISPERPresenter>*)presenter{
    self = [super init];
    if (self) {
        self->_serviceProvider  = serviceProvider;
        self->_presenter        = presenter;
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
             serviceProvider:(NSObject<IVISPERViewControllerServiceProvider>*)serviceProvider
                   presenter:(NSObject<IVISPERPresenter>*)presenter{
    self = [super initWithCoder:aDecoder];
    if(self){
        self->_serviceProvider = serviceProvider;
        self->_presenter       = presenter;
    }
    return self;
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil
                        bundle:(NSBundle *)nibBundleOrNil
               serviceProvider:(NSObject<IVISPERViewControllerServiceProvider>*)serviceProvider
                     presenter:(NSObject<IVISPERPresenter>*)presenter{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        self->_serviceProvider  = serviceProvider;
        self->_presenter        = presenter;
    }
    return self;
}

-(instancetype)init{
    return [self initWithServiceProvider:[[VISPERViewControllerServiceProvider alloc] init]
                               presenter:nil];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    return [self initWithCoder:aDecoder
               serviceProvider:[[VISPERViewControllerServiceProvider alloc] init]
                     presenter:nil];
}


-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    return [self initWithNibName:nibNameOrNil
                          bundle:nibBundleOrNil
                 serviceProvider:[[VISPERViewControllerServiceProvider alloc] init]
                       presenter:nil];
}

#pragma mark send view events to presenter
-(void)sendEventToPresenter:(NSObject<IVISPERViewEvent>*)event{
    if( self.presenter &&
        [self.presenter respondsToSelector:@selector(renderView:withController:onEvent:)]){


        [self.presenter renderView:self.view
                    withController:self
                           onEvent:event];
    }
}

#pragma mark view lifecycle
-(void)loadView{
    [super loadView];
    NSObject<IVISPERViewEvent> *event = [self.serviceProvider createEventWithName:@"loadView"
                                                                           sender:self
                                                                             info:nil];
    [self sendEventToPresenter:event];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSObject<IVISPERViewEvent> *event = [self.serviceProvider createEventWithName:@"viewDidLoad"
                                                                           sender:self
                                                                             info:nil];
    [self sendEventToPresenter:event];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    NSObject<IVISPERViewEvent> *event = [self.serviceProvider createEventWithName:@"viewWillAppear"
                                                                           sender:self
                                                                             info:@{@"animated":(animated)?@TRUE:@FALSE}];
  
    [self sendEventToPresenter:event];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    NSObject<IVISPERViewEvent> *event = [self.serviceProvider createEventWithName:@"viewDidAppear"
                                                                           sender:self
                                                                             info:@{@"animated":(animated)?@TRUE:@FALSE}];
    
    [self sendEventToPresenter:event];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    NSObject<IVISPERViewEvent> *event = [self.serviceProvider createEventWithName:@"viewWillDisappear"
                                                                           sender:self
                                                                             info:@{@"animated":(animated)?@TRUE:@FALSE}];
    [self sendEventToPresenter:event];
}


-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
        
    NSObject<IVISPERViewEvent> *event = [self.serviceProvider createEventWithName:@"viewDidDisappear"
                                                                           sender:self
                                                                             info:@{@"animated":(animated)?@TRUE:@FALSE}];
    [self sendEventToPresenter:event];

}

-(void)viewWillTransitionToSize:(CGSize)size
      withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
