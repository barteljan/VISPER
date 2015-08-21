//
//  AppDelegate.h
//  VISPER
//
//  Created by Bartel on 10.07.15.
//  Copyright (c) 2015 Bartel. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <VISPER/VISPERApplication.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) IBOutlet UIWindow *window;
@property (strong, nonatomic) VISPERApplication *visperApplication;

@end
