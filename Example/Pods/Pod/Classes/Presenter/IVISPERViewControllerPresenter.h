//
// Created by Bartel on 10.07.15.
// Copyright (c) 2015 Jan Bartel. All rights reserved.
//

@import Foundation;
@import UIKit;
#import "IVISPERViewEvent.h"
#import "IVISPERPresenter.h"

@protocol IVISPERViewControllerPresenter <IVISPERPresenter>


/**
 * Called when view controller loads the view
 **/
-(void)   loadView:(UIView*)view
    withController:(UIViewController*)viewController
             event:(NSObject<IVISPERViewEvent>*)event;


/**
 * Called when view controller did the viewDidLoad method
 **/
-(void)viewDidLoad:(UIView*)view
    withController:(UIViewController*)viewController
             event:(NSObject<IVISPERViewEvent>*)event;


/**
 * Called when view controller did the viewWillAppear method
 **/
- (void)viewWillAppear:(BOOL)animated
                  view:(UIView*)view
        withController:(UIViewController*)viewController
               onEvent:(NSObject<IVISPERViewEvent>*)event;


/**
 * Called when view controller did the viewDidAppear method
 **/
- (void)viewDidAppear:(BOOL)animated
                 view:(UIView*)view
       withController:(UIViewController*)viewController
              onEvent:(NSObject<IVISPERViewEvent>*)event;


/**
 * Called when view controller did the viewWillDisappear method
 **/
- (void)viewWillDisappear:(BOOL)animated
                     view:(UIView*)view
           withController:(UIViewController*)viewController
                  onEvent:(NSObject<IVISPERViewEvent>*)event;


/**
 * Called when view controller did the viewDidDisappear method
 **/
- (void)viewDidDisappear:(BOOL)animated
                    view:(UIView*)view
          withController:(UIViewController*)viewController
                 onEvent:(NSObject<IVISPERViewEvent>*)event;

@end