//
//  Example1VisperViewControllerPresenter.m
//  VISPER
//
//  Created by Bartel on 11.07.15.
//  Copyright (c) 2015 Jan Bartel. All rights reserved.
//

#import "Example1VisperViewControllerPresenter.h"
#import <VISPER/IVISPERViewEvent.h>
#import "Example1View.h"

@interface Example1VisperViewControllerPresenter()

@property(nonatomic)CommandBus* commandBus;

@end

@implementation Example1VisperViewControllerPresenter


-(instancetype)initWithWireframe:(NSObject<IVISPERWireframe>*)wireframe
                      commandBus:(CommandBus*)commandBus{
    self = [super initWithWireframe:wireframe];
    if(self){
        self.commandBus = commandBus;
    }
    return self;
}

-(void)viewEvent:(NSObject<IVISPERViewEvent> *)event
        withView:(UIView *)view
   andController:(UIViewController *)viewController{
    [super viewEvent:event
            withView:view
       andController:viewController];
    
    
    if([event.name isEqualToString:@"example2ButtonPressed"]){
        [self example2ButtonPressed:event.sender
                               view:view
                     viewController:viewController];
    }else if([event.name isEqualToString:@"example3ButtonPressed"]){
        [self example3ButtonPressed:event.sender
                               view:view
                     viewController:viewController];
    }else if([event.name isEqualToString:@"loadDataButtonPressed"]){
        [self loadDataButtonPressed:event.sender
                               view:view
                     viewController:viewController];
    }
    
}


-(void)example2ButtonPressed:(id)sender
                        view:(UIView *)view
              viewController:(UIViewController*)viewController{
    [self.wireframe routeURL:[NSURL URLWithString:@"/example2"]];
}


-(void)example3ButtonPressed:(id)sender
                        view:(UIView *)view
              viewController:(UIViewController*)viewController{
    [self.wireframe routeURL:[NSURL URLWithString:@"/example3"]];
}


-(void)loadDataButtonPressed:(id)sender
                        view:(UIView *)view
              viewController:(UIViewController*)viewController{
    
    [self.commandBus processCommand:@"loadData" completion:^(id _Nullable result, id _Nullable error) {
        
        
        Example1View *exampleView = (Example1View *)view;
        exampleView.text = (NSString*)result;
        
        
    }];
    
    
}


@end
