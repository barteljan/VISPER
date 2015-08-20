//
//  IVISPERFeature.h
//  Pods
//
//  Created by Bartel on 23.07.15.
//
//

#import <Foundation/Foundation.h>
#import "IVISPERWireframe.h"
#import "IVISPERComposedPersistenceStore.h"
#import "IVISPERComposedRepository.h"
#import "IVISPERComposedInteractor.h"

@protocol IVISPERFeature <NSObject>

-(void)bootstrapWireframe:(NSObject<IVISPERWireframe> *)wireframe
               interactor:(NSObject<IVISPERComposedInteractor> *)interactor;

@optional
-(NSArray*)routePatterns;

@end
