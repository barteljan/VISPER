//
//  Example2VisperViewController.m
//  VISPER
//
//  Created by Bartel on 12.07.15.
//  Copyright (c) 2015 Jan Bartel. All rights reserved.
//

#import "Example2VisperViewController.h"

@interface Example2VisperViewController ()

@end

@implementation Example2VisperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Example2VisperVC";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)backAction:(id)sender {
    
    [self.visperWireframe back:true completion:^{
        NSLog(@"dismissed vc");
    }];
}

- (IBAction)nextAction:(id)sender {
    [self.visperWireframe routeURL:[NSURL URLWithString:@"/example3"]];
}
@end
