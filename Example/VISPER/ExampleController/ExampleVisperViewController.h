//
//  ExampleVisperViewController.h
//  VISPER
//
//  Created by Bartel on 10.07.15.
//  Copyright (c) 2015 Jan Bartel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <VISPER/VISPERViewController.h>
#import <VISPER/VISPERViewPresenter.h>

@interface ExampleVisperViewController : VISPERViewController<IVISPERViewController>
- (IBAction)nextButtonPressed:(id)sender;

@end
