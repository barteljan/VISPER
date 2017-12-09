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
-(void)viewEvent:(NSObject<IVISPERViewEvent>*)event
        withView:(UIView*)view
   andController:(UIViewController*)viewController{
    
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
      @"viewWillAppear:":^(){
          BOOL animated = [self getBOOLFromKeyWithNumber:@"animated"
                                                fromDict:event.info];
          
          [self viewWillAppear:animated
                          view:view
                withController:viewController
                       onEvent:event];
      },
      @"viewDidAppear:":^(){
          BOOL animated = [self getBOOLFromKeyWithNumber:@"animated"
                                                fromDict:event.info];
          
          [self viewDidAppear:animated
                         view:view
               withController:viewController
                      onEvent:event];
      },
      @"viewDidAppear:":^(){
          BOOL animated = [self getBOOLFromKeyWithNumber:@"animated"
                                                fromDict:event.info];
          
          [self viewDidAppear:animated
                         view:view
               withController:viewController
                      onEvent:event];
      },
      @"viewWillDisappear:":^(){
          BOOL animated = [self getBOOLFromKeyWithNumber:@"animated"
                                                fromDict:event.info];
          
          [self viewWillDisappear:animated
                             view:view
               withController:viewController
                      onEvent:event];
      },
      @"viewDidDisappear:":^(){
          BOOL animated = [self getBOOLFromKeyWithNumber:@"animated"
                                                fromDict:event.info];
          
          [self viewDidDisappear:animated
                             view:view
                   withController:viewController
                          onEvent:event];
      },
      @"viewWillTransitionToSize:withTransitionCoordinator:":^(){
          NSNumber *width = [event.info objectForKey:@"width"];
          NSNumber *height = [event.info objectForKey:@"height"];
          
          CGSize size = CGSizeMake([width floatValue], [height floatValue]);
          
          id<UIViewControllerTransitionCoordinator> coordinator = [event.info objectForKey:@"coordinator"];
          
          [self viewWillTransitionToSize:size
               withTransitionCoordinator:coordinator
                                    view:view
                          withController:viewController
                                 onEvent:event];
      },
      @"didReceiveMemoryWarning":^(){
          [self didReceiveMemoryWarning:view
                         withController:viewController
                                onEvent:event];
      }
    };

    if(!event || !event.name || ![eventBlocks objectForKey:event.name]){
        return;
    }

    ((void(^)())eventBlocks[event.name])();
}

-(void)routingEvent:(NSObject<IVISPERRoutingEvent>*)event
         controller:(UIViewController*)viewController
        andWireframe:(NSObject<IVISPERWireframe>*)wireframe{
   
    if([event.name isEqualToString:@"willRouteToController"]){
        [self willRouteToViewController:viewController
                            onWireframe:event.sender
                           routePattern:[event.info objectForKey:@"routePattern"]
                               priority:[[event.info objectForKey:@"priority"] longValue]
                                options:(NSObject<IVISPERRoutingOption>*)[event.info objectForKey:@"options"]
                             parameters:(NSDictionary*)[event.info objectForKey:@"parameters"]
         ];
    }else if([event.name isEqualToString:@"didRouteToController"]){
        [self    didRouteToViewController:viewController
                          onWireframe:event.sender
                         routePattern:[event.info objectForKey:@"routePattern"]
                             priority:[[event.info objectForKey:@"priority"] longValue]
                              options:(NSObject<IVISPERRoutingOption>*)[event.info objectForKey:@"options"]
                           parameters:(NSDictionary*)[event.info objectForKey:@"parameters"]
         ];
    }else if([event.name isEqualToString:@"willPushController"]){
        [self willPushViewController:viewController
                         onWireframe:event.sender
                        routePattern:[event.info objectForKey:@"routePattern"]
                            priority:[[event.info objectForKey:@"priority"] longValue]
                             options:(NSObject<IVISPERRoutingOption>*)[event.info objectForKey:@"options"]
                          parameters:(NSDictionary*)[event.info objectForKey:@"parameters"]
         ];
    }else if([event.name isEqualToString:@"didPushController"]){
        [self didPushViewController:viewController
                        onWireframe:event.sender
                       routePattern:[event.info objectForKey:@"routePattern"]
                           priority:[[event.info objectForKey:@"priority"] longValue]
                            options:(NSObject<IVISPERRoutingOption>*)[event.info objectForKey:@"options"]
                         parameters:(NSDictionary*)[event.info objectForKey:@"parameters"]
         ];
    }else if([event.name isEqualToString:@"willPresentController"]){
        [self willPresentViewController:viewController
                            onWireframe:event.sender
                           routePattern:[event.info objectForKey:@"routePattern"]
                               priority:[[event.info objectForKey:@"priority"] longValue]
                                options:(NSObject<IVISPERRoutingOption>*)[event.info objectForKey:@"options"]
                             parameters:(NSDictionary*)[event.info objectForKey:@"parameters"]
         ];
    }else if([event.name isEqualToString:@"didPresentController"]){
        [self didPresentViewController:viewController
                           onWireframe:event.sender
                          routePattern:[event.info objectForKey:@"routePattern"]
                              priority:[[event.info objectForKey:@"priority"] longValue]
                               options:(NSObject<IVISPERRoutingOption>*)[event.info objectForKey:@"options"]
                            parameters:(NSDictionary*)[event.info objectForKey:@"parameters"]
         ];
    }
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
 * Called on orientation change
 **/
-(void)viewWillTransitionToSize:(CGSize)size
      withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
                           view:(UIView*)view
                 withController:(UIViewController*)controller
                        onEvent:(NSObject<IVISPERViewEvent>*)event{
    
    
}

/**
 * Called on memory warning
 **/
- (void)didReceiveMemoryWarning:(UIView*)view
                 withController:(UIViewController*)controller
                        onEvent:(NSObject<IVISPERViewEvent>*)event {

}


/**
 * Called before pushing a controller of this presenter
 **/
-(void)willRouteToViewController:(UIViewController*)viewController
                     onWireframe:(NSObject<IVISPERWireframe>*)wireframe
                    routePattern:(NSString*)routePattern
                        priority:(NSInteger)priority
                         options:(NSObject<IVISPERRoutingOption>*)options
                      parameters:(NSDictionary *)parameters{
    
}

/**
 * Called before pushing a controller of this presenter
 **/
-(void)didRouteToViewController:(UIViewController*)viewController
                  onWireframe:(NSObject<IVISPERWireframe>*)wireframe
                 routePattern:(NSString*)routePattern
                     priority:(NSInteger)priority
                      options:(NSObject<IVISPERRoutingOption>*)options
                   parameters:(NSDictionary *)parameters{
    
}


/**
 * Called before pushing a controller of this presenter
 **/
-(void)willPushViewController:(UIViewController*)viewController
                  onWireframe:(NSObject<IVISPERWireframe>*)wireframe
                 routePattern:(NSString*)routePattern
                     priority:(NSInteger)priority
                      options:(NSObject<IVISPERRoutingOption>*)options
                   parameters:(NSDictionary *)parameters{
    
}

/**
 * Called after pushing a controller of this presenter
 **/
-(void)didPushViewController:(UIViewController*)viewController
                 onWireframe:(NSObject<IVISPERWireframe>*)wireframe
                routePattern:(NSString*)routePattern
                    priority:(NSInteger)priority
                     options:(NSObject<IVISPERRoutingOption>*)options
                  parameters:(NSDictionary *)parameters{
    
}

/**
 * Called before modal presenting a controller of this presenter
 **/
-(void)willPresentViewController:(UIViewController*)viewController
                     onWireframe:(NSObject<IVISPERWireframe>*)wireframe
                    routePattern:(NSString*)routePattern
                        priority:(NSInteger)priority
                         options:(NSObject<IVISPERRoutingOption>*)options
                      parameters:(NSDictionary *)parameters{
    
}


/**
 * Called after modal presenting a controller of this presenter
 **/
-(void)didPresentViewController:(UIViewController*)viewController
                    onWireframe:(NSObject<IVISPERWireframe>*)wireframe
                   routePattern:(NSString*)routePattern
                       priority:(NSInteger)priority
                        options:(NSObject<IVISPERRoutingOption>*)options
                     parameters:(NSDictionary *)parameters{
    
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
    
    return value;
}


@end