//
//  Example1VisperViewController.m
//  VISPER
//
//  Created by Bartel on 10.07.15.
//  Copyright (c) 2015 Jan Bartel. All rights reserved.
//

#import "Example1VisperViewController.h"
#import "VISPERViewEvent.h"

@interface Example1VisperViewController ()

@end

@implementation Example1VisperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)example2ButtonPressed:(id)sender {
    NSObject <IVISPERViewEvent> *event = [self.visperServiceProvider
                                          createEventWithName:@"example2ButtonPressed" sender:sender info:nil];
    [self notifyPresentersOfView:self.view withEvent:event];
}

- (IBAction)example3ButtonPressed:(id)sender {
    NSObject <IVISPERViewEvent> *event = [self.visperServiceProvider
                                          createEventWithName:@"example3ButtonPressed" sender:sender info:nil];
    [self notifyPresentersOfView:self.view withEvent:event];
}

- (IBAction)loadDataButtonPressed:(id)sender {
    
    NSObject <IVISPERViewEvent> *event = [self.visperServiceProvider
                                          createEventWithName:@"loadDataButtonPressed" sender:sender info:nil];
    [self notifyPresentersOfView:self.view withEvent:event];
}
@end
