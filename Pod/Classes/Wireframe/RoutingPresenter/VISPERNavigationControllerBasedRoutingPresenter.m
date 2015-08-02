//
//  VISPERNavigationControllerBasedRoutingPresenter.m
//  Pods
//
//  Created by Bartel on 02.08.15.
//
//

#import "VISPERNavigationControllerBasedRoutingPresenter.h"

@implementation VISPERNavigationControllerBasedRoutingPresenter

-(instancetype)init{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"Please use initWithNavigationController: instead of %@", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

-(instancetype)initWithServiceProvider:(NSObject<IVISPERRoutingPresenterServiceProvider> *)serviceProvider{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@" please use initWithNavigationController:serviceProvider: instead of %@", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}


-(instancetype)initWithNavigationController:(UINavigationController*)navigationController{
    self = [super init];
    if(self){
        self->_navigationController = navigationController;
    }
    return self;
}


-(instancetype)initWithNavigationController:(UINavigationController*)navigationController
                            serviceProvider:(NSObject<IVISPERRoutingPresenterServiceProvider>*)serviceProvider{
    self = [super initWithServiceProvider:serviceProvider];
    if(self){
        self->_navigationController = navigationController;
    }
    return self;
}


@end
