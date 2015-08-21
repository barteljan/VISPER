//
//  Example3VisperViewController.m
//  VISPER
//
//  Created by Bartel on 12.07.15.
//  Copyright (c) 2015 Jan Bartel. All rights reserved.
//

#import "Example3VisperViewController.h"
#import <VISPER/UIViewController+VISPER.h>
@interface Example3VisperViewController ()

@end

@implementation Example3VisperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Example3VisperVC";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeViewController:(id)sender {
    NSObject<IVISPERViewEvent>*event = [self.visperServiceProvider createEventWithName:@"shouldCloseViewController"
                                                                                sender:self
                                                                                  info:@{}];
    [self notifyPresentersOfView:self.view withEvent:event];
}
@end
