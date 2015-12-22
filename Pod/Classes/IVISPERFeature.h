//
//  IVISPERFeature.h
//  Pods
//
//  Created by Bartel on 23.07.15.
//
//

#import <Foundation/Foundation.h>
#import "IVISPERWireframe.h"
#import "IVISPERComposedInteractor.h"
#import "IVISPERCommandBus.h"

@protocol IVISPERFeature <NSObject>

@optional
-(NSArray*)routePatterns;

-(void)bootstrapWireframe:(NSObject<IVISPERWireframe> *)wireframe
               commandBus:(NSObject<IVISPERCommandBus> *)commandBus;

#pragma mark deprecated
@optional
-(void)bootstrapWireframe:(NSObject<IVISPERWireframe> *)wireframe
               interactor:(NSObject<IVISPERCommandBus> *)interactor __attribute((deprecated(("use bootstrapWireframe:commandBus: instead"))));



@end
