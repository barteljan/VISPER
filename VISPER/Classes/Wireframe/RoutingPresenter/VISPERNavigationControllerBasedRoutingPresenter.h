//
//  VISPERNavigationControllerBasedRoutingPresenter.h
//  Pods
//
//  Created by Bartel on 02.08.15.
//
//
@import Foundation;
@import UIKit;
#import "VISPERRoutingPresenter.h"

@interface VISPERNavigationControllerBasedRoutingPresenter : VISPERRoutingPresenter

@property(nonatomic)UINavigationController *navigationController;

-(instancetype)initWithNavigationController:(UINavigationController*)navigationController;
-(instancetype)initWithNavigationController:(UINavigationController*)navigationController
                            serviceProvider:(NSObject<IVISPERRoutingPresenterServiceProvider>*)serviceProvider;


@end
