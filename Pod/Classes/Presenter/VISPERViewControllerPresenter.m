//
// Created by Bartel on 10.07.15.
// Copyright (c) 2015 Jan Bartel. All rights reserved.
//

#import "VISPERViewControllerPresenter.h"
@interface VISPERViewControllerPresenter()

-(BOOL)getBOOLFromKeyWithNumber:(NSString*)key fromDict:(NSDictionary*)dict;

@end

@implementation VISPERViewControllerPresenter


/**
 * called when a view event happens
 */
-(void)renderView:(UIView*)view
   withController:(UIViewController*)viewController
          onEvent:(NSObject<IVISPERViewEvent>*)event{
    
    NSDictionary *eventBlocks =
  @{
      @"loadView":^(){
        [self    loadView:view
           withController:viewController
                    event:event];
      },
      @"viewDidLoad":^(){
          [self viewDidLoad:view
             withController:viewController
                      event:event];
      },
      @"viewWillAppear":^(){
          BOOL animated = [self getBOOLFromKeyWithNumber:@"animated"
                                                fromDict:event.info];
          
          [self viewWillAppear:animated
                          view:view
                withController:viewController
                       onEvent:event];
      },
      @"viewDidAppear":^(){
          BOOL animated = [self getBOOLFromKeyWithNumber:@"animated"
                                                fromDict:event.info];
          
          [self viewDidAppear:animated
                         view:view
               withController:viewController
                      onEvent:event];
      },
      @"viewDidAppear":^(){
          BOOL animated = [self getBOOLFromKeyWithNumber:@"animated"
                                                fromDict:event.info];
          
          [self viewDidAppear:animated
                         view:view
               withController:viewController
                      onEvent:event];
      },
      @"viewWillDisappear":^(){
          BOOL animated = [self getBOOLFromKeyWithNumber:@"animated"
                                                fromDict:event.info];
          
          [self viewWillDisappear:animated
                             view:view
               withController:viewController
                      onEvent:event];
      },
      @"viewDidDisappear":^(){
          BOOL animated = [self getBOOLFromKeyWithNumber:@"animated"
                                                fromDict:event.info];
          
          [self viewDidDisappear:animated
                             view:view
                   withController:viewController
                          onEvent:event];
      }
    };

    if(!event || !event.name || ![eventBlocks objectForKey:event.name]){
        return;
    }

    ((void(^)())eventBlocks[event.name])();
}


/**
 * Called when view controller loads the view
 **/
-(void)   loadView:(UIView*)view
    withController:(UIViewController*)viewController
             event:(NSObject<IVISPERViewEvent>*)event{
    
}

/**
 * Called when view controller did the viewDidLoad method
 **/
-(void)viewDidLoad:(UIView*)view
    withController:(UIViewController*)viewController
             event:(NSObject<IVISPERViewEvent>*)event{

}

/**
 * Called when view controller did the viewWillAppear method
 **/
- (void)viewWillAppear:(BOOL)animated
                  view:(UIView*)view
        withController:(UIViewController*)viewController
               onEvent:(NSObject<IVISPERViewEvent>*)event{

}


/**
 * Called when view controller did the viewDidAppear method
 **/
- (void)viewDidAppear:(BOOL)animated
                  view:(UIView*)view
        withController:(UIViewController*)viewController
               onEvent:(NSObject<IVISPERViewEvent>*)event{
    
}


/**
 * Called when view controller did the viewWillDisappear method
 **/
- (void)viewWillDisappear:(BOOL)animated
                    view:(UIView*)view
          withController:(UIViewController*)viewController
                 onEvent:(NSObject<IVISPERViewEvent>*)event{
    
}

/**
 * Called when view controller did the viewDidDisappear method
 **/
- (void)viewDidDisappear:(BOOL)animated
                 view:(UIView*)view
       withController:(UIViewController*)viewController
              onEvent:(NSObject<IVISPERViewEvent>*)event{
    
}


/**
 * Converts a number value from an dictionary to a BOOL value
 **/
-(BOOL)getBOOLFromKeyWithNumber:(NSString*)key fromDict:(NSDictionary*)dict{
    BOOL value = FALSE;
    
    if(dict &&
       [dict objectForKey:key] &&
       [[dict objectForKey:key] isEqualToNumber:@TRUE]){
        value = TRUE;
    }
    
    return TRUE;
}
@end