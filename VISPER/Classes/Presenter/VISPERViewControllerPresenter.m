//
// Created by Bartel on 10.07.15.
// Copyright (c) 2015 Jan Bartel. All rights reserved.
//

#import "VISPERViewControllerPresenter.h"
#import "VISPERViewEvent.h"
@interface VISPERViewControllerPresenter()

-(BOOL)getBOOLFromKeyWithNumber:(NSString*)key fromDict:(NSDictionary*)dict;

@end

@implementation VISPERViewControllerPresenter

- (BOOL)isResponsible:(NSObject *)event view:(UIView *)view controller:(UIViewController *)controller {
    
    if([super isResponsible:event view:view controller:controller]){
        return TRUE;
    }
    
    if([event isKindOfClass:[LifecycleEvent class]]){
        return TRUE;
    }
    
    return FALSE;
}



- (void)receivedEvent:(NSObject *)event view:(UIView *)view controller:(UIViewController *)controller {
    
    [super receivedEvent:event view:view controller:controller];
    
    if([event isKindOfClass:[ViewDidLoadEvent class]]){
        VISPERViewEvent *event = [[VISPERViewEvent alloc] initWithName:@"viewDidLoad"
                                                                sender:controller
                                                                  info:nil];
        [self viewEvent:event withView:view andController:controller];
    } else if([event isKindOfClass:[ViewWillAppearEvent class]]){
        
        NSNumber *animated = [NSNumber numberWithBool:((ViewWillAppearEvent*)event).animated];
    
        NSDictionary *info = @{@"animated" : animated};
        
        VISPERViewEvent *viewEvent = [[VISPERViewEvent alloc] initWithName:@"viewWillAppear:"
                                                                sender:controller
                                                                  info:info];
        [self viewEvent:viewEvent withView:view andController:controller];
    
    } else if([event isKindOfClass:[ViewDidAppearEvent class]]){
        
        NSNumber *animated = [NSNumber numberWithBool:((ViewDidAppearEvent*)event).animated];
        
        NSDictionary *info = @{@"animated" : animated};
        
        VISPERViewEvent *viewEvent = [[VISPERViewEvent alloc] initWithName:@"viewDidAppear:"
                                                                    sender:controller
                                                                      info:info];
        [self viewEvent:viewEvent withView:view andController:controller];
        
    } else if([event isKindOfClass:[ViewWillDisappearEvent class]]){
        
        NSNumber *animated = [NSNumber numberWithBool:((ViewWillDisappearEvent*)event).animated];
        
        NSDictionary *info = @{@"animated" : animated};
        
        VISPERViewEvent *viewEvent = [[VISPERViewEvent alloc] initWithName:@"viewWillDisappear:"
                                                                    sender:controller
                                                                      info:info];
        [self viewEvent:viewEvent withView:view andController:controller];
        
    } else if([event isKindOfClass:[ViewDidDisappearEvent class]]){
        
        NSNumber *animated = [NSNumber numberWithBool:((ViewDidDisappearEvent*)event).animated];
        
        NSDictionary *info = @{@"animated" : animated};
        
        VISPERViewEvent *viewEvent = [[VISPERViewEvent alloc] initWithName:@"viewDidDisappear:"
                                                                    sender:controller
                                                                      info:info];
        [self viewEvent:viewEvent withView:view andController:controller];
        
    }
    
}

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
      }
    };

    if(!event || !event.name || ![eventBlocks objectForKey:event.name]){
        return;
    }

    ((void(^)(void))eventBlocks[event.name])();
}

-(void)routingEvent:(NSObject<IVISPERRoutingEvent>*)event
         controller:(UIViewController*)viewController
        andWireframe:(NSObject<IVISPERWireframe>*)wireframe{
   
    if([event.name isEqualToString:@"willRouteToController"]){
        [self willRouteToViewController:viewController
                            onWireframe:wireframe
                           routePattern:[event.info objectForKey:@"routePattern"]
                               priority:[[event.info objectForKey:@"priority"] longValue]
                                options:(NSObject<IVISPERRoutingOption>*)[event.info objectForKey:@"options"]
                             parameters:(NSDictionary*)[event.info objectForKey:@"parameters"]
         ];
    }else if([event.name isEqualToString:@"didRouteToController"]){
        [self    didRouteToViewController:viewController
                          onWireframe:wireframe
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
