//
//  Example1VisperViewControllerPresenter.h
//  VISPER
//
//  Created by Bartel on 11.07.15.
//  Copyright (c) 2015 Jan Bartel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <VISPER/VISPERViewControllerPresenter.h>
@import VISPER;

@interface Example1VisperViewControllerPresenter : VISPERViewControllerPresenter

-(instancetype)initWithWireframe:(NSObject<IVISPERWireframe>*)wireframe
                      commandBus:(CommandBus*)commandBus;

@end
