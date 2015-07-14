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
@dynamic presenter;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)example2ButtonPressed:(id)sender {
    NSObject <IVISPERViewEvent> *event = [self.serviceProvider createEventWithName:@"example2ButtonPressed" sender:sender info:nil];
    [self sendEventToPresenter:event];
}

- (IBAction)example3ButtonPressed:(id)sender {
    NSObject <IVISPERViewEvent> *event = [self.serviceProvider createEventWithName:@"example3ButtonPressed" sender:sender info:nil];
    [self sendEventToPresenter:event];
}
@end
