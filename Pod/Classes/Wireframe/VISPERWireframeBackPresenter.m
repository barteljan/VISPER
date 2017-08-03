//
//  VISPERWireframeBackPresenter.m
//  Pods
//
//  Created by bartel on 02.08.17.
//
//

#import "VISPERWireframeBackPresenter.h"
#import "UIViewController+VISPER.h"

@implementation VISPERWireframeBackPresenter

- (void)viewWillDisappear:(BOOL)animated
                     view:(UIView*)view
           withController:(UIViewController*)viewController
                  onEvent:(NSObject<IVISPERViewEvent>*)event{
    
    [super viewWillDisappear:animated
                        view:view
              withController:viewController
                     onEvent:event];
    //if controller is managed by visper
    if(viewController.routePattern != nil){
        
        //if controller will be popped and is the wireframes current vc
        //then assume the next current view controller
        //and lives in a navigation controller
        if([viewController isMovingFromParentViewController] &&
            viewController == self.wireframe.currentViewController &&
            viewController.navigationController) {
            
            NSArray *viewControllers = viewController.navigationController.viewControllers;
            
            UIViewController *controllerAfterPop = [viewControllers objectAtIndex:viewControllers.count - 1];
            [self.wireframe setCurrentViewController:controllerAfterPop];
                
        }
        
    }
    
}

@end
