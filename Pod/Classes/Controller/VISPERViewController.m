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

@interface VISPERViewController ()

@end

@implementation VISPERViewController

-(void)sendEventToPresenter:(NSObject<IVISPERViewEvent>*)event{
    if(self.presenter &&
            [self.presenter respondsToSelector:@selector(renderView:withController:onEvent:)]){


        [self.presenter renderView:self.view
                    withController:self
                           onEvent:event];
    }
}

-(void)loadView{
    [super loadView];
    NSObject<IVISPERViewEvent> *event = [[VISPERViewEvent alloc] initWithName:@"loadView"
                                                                       sender:self];
    [self sendEventToPresenter:event];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    NSObject<IVISPERViewEvent> *event = [[VISPERViewEvent alloc] initWithName:@"viewDidLoad"
                                                                       sender:self];
    [self sendEventToPresenter:event];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    NSObject<IVISPERViewEvent> *event = [[VISPERViewEvent alloc] initWithName:@"viewWillAppear"
                                                                       sender:self
                                                                         info:@{@"animated":(animated)?@TRUE:@FALSE}];
    [self sendEventToPresenter:event];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    NSObject<IVISPERViewEvent> *event = [[VISPERViewEvent alloc] initWithName:@"viewDidAppear"
                                                                       sender:self
                                                                         info:@{@"animated":(animated)?@TRUE:@FALSE}];
    [self sendEventToPresenter:event];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSObject<IVISPERViewEvent> *event = [[VISPERViewEvent alloc] initWithName:@"viewWillDisappear"
                                                                       sender:self
                                                                         info:@{@"animated":(animated)?@TRUE:@FALSE}];
    [self sendEventToPresenter:event];
}


-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    NSObject<IVISPERViewEvent> *event = [[VISPERViewEvent alloc] initWithName:@"viewDidDisappear"
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
