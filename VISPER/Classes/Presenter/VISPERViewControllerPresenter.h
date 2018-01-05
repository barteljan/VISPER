//
// Created by Bartel on 10.07.15.
// Copyright (c) 2015 Jan Bartel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IVISPERViewControllerPresenter.h"
#import "VISPERViewPresenter.h"
@import VISPER_Presenter;

@interface VISPERViewControllerPresenter : VISPERViewPresenter <IVISPERViewControllerPresenter>

/**
 * called when a view event happens
 */
-(void)viewEvent:(NSObject<IVISPERViewEvent>*)event
        withView:(UIView*)view
   andController:(UIViewController*)viewController;


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


-(void)willRouteToViewController:(UIViewController*)viewController
                 onWireframe:(NSObject<IVISPERWireframe>*)wireframe
                routePattern:(NSString*)routePattern
                    priority:(NSInteger)priority
                     options:(NSObject<IVISPERRoutingOption>*)options
                  parameters:(NSDictionary *)parameters;

-(void)didRouteToViewController:(UIViewController*)viewController
                  onWireframe:(NSObject<IVISPERWireframe>*)wireframe
                 routePattern:(NSString*)routePattern
                     priority:(NSInteger)priority
                      options:(NSObject<IVISPERRoutingOption>*)options
                   parameters:(NSDictionary *)parameters;

@end
